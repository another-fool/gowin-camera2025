library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.mt_lib.all; 
entity hdmi_rd is 
    generic (        
        coms0_addra                 :in  std_logic_vector (27 downto 0) ; 
        coms0_addrb                 :in  std_logic_vector (27 downto 0) ; 
        coms1_addra                 :in  std_logic_vector (27 downto 0) ; 
        coms1_addrb                 :in  std_logic_vector (27 downto 0) ; 
        coms2_addra                 :in  std_logic_vector (27 downto 0) ; 
        coms2_addrb                 :in  std_logic_vector (27 downto 0) 
    );
    port ( 
        rst_n                       : in std_logic ;   
        coms0_wr_area               : in std_logic ;   
        coms1_wr_area               : in std_logic ;   
        coms2_wr_area               : in std_logic ;   
        current_buffer_addr         : in std_logic_vector(27 downto 0);
        mode                        : in std_logic_vector(7 downto 0);
        --hdmi rd        
        video_clk                   : in std_logic ;  
        syn_off0_hs                 : in std_logic ; 
        syn_off0_vs                 : in std_logic ; 
        out_de                      : in std_logic ; 
        off0_syn_data               : buffer std_logic_vector(15 downto 0);
        off0_syn_de                 : buffer std_logic ; 
        --ddr rd        
		ddr_clk	    		        : in std_logic ; 
        usr_ddr3_rd_q               : buffer usr_ddr3_rd_q ;
        usr_ddr3_rd_p               : in usr_ddr3_rd_p        
    );
end hdmi_rd ;
architecture rtl of hdmi_rd is
component fifo_256x512_16x8192
	port (
		Data: in std_logic_vector(255 downto 0);
		Reset: in std_logic;
		WrClk: in std_logic;
		RdClk: in std_logic;
		WrEn: in std_logic;
		RdEn: in std_logic;
		Almost_Full: out std_logic;
		Wnum: out std_logic_vector(9 downto 0);
		Rnum: out std_logic_vector(13 downto 0);
		Q: out std_logic_vector(15 downto 0);
		Empty: out std_logic;
		Full: out std_logic
	);
end component;    
constant IDLE                       : std_logic_vector(7 downto 0):= X"01";  
constant DDR_RD_PRE                 : std_logic_vector(7 downto 0):= X"02";  
constant RD_REQ                     : std_logic_vector(7 downto 0):= X"03";  
constant RD_DDR                     : std_logic_vector(7 downto 0):= X"04";  
constant RD_CHECK                   : std_logic_vector(7 downto 0):= X"05";  
constant TIMEOUT                    : std_logic_vector(7 downto 0):= X"06"; 
constant CONTINUE_RD                : std_logic_vector(7 downto 0):= X"07"; 
constant FRAME_START                : std_logic_vector(7 downto 0):= X"08"; 
constant FRAME_END                  : std_logic_vector(7 downto 0):= X"09"; 
constant FIFO_CHECK                 : std_logic_vector(7 downto 0):= X"0a"; 
constant WAIT_FIFO_RST              : std_logic_vector(7 downto 0):= X"0B"; 

signal cs                           : std_logic_vector(7 downto 0):= IDLE ;
signal ns                           : std_logic_vector(7 downto 0):= IDLE ; 
signal time_out                     : std_logic_vector(23 downto 0);
signal vsync_rise                   : std_logic;
signal vsync_fall                   : std_logic;
signal vsync_r1                     : std_logic;
signal vsync_r2                     : std_logic;
signal fifo_rst                     : std_logic;
signal out_de_reg1                   : std_logic;
signal out_de_reg2                   : std_logic;
signal fifo_prog_full               : std_logic;
signal rd_cnt                       : integer range 0 to 1024 ;
signal cnt_pix                      : integer range 0 to  8192 ; 
signal cnt_line                     : integer range 0 to  8192 ; 
signal out_de_r1                    : std_logic;
signal out_de_r2                    : std_logic;
signal out_de_r3                    : std_logic;
signal out_de_r4                    : std_logic;
signal out_de_fall                  : std_logic;
signal fifo_rd_data                 : std_logic_vector(15 downto 0);
signal vs_r1                        : std_logic;
signal vs_r2                        : std_logic;
signal vs_rise                      : std_logic;
signal hs_r1                        : std_logic;
signal hs_r2                        : std_logic;
signal hs_rise                      : std_logic;
signal over_flag                    : std_logic;
begin
--***************************************************************
-- sm 
--***************************************************************
process( rst_n,ddr_clk )
    begin
        if rst_n ='0' then
            vsync_rise <= '0';
            vsync_fall <= '0';
            vsync_r1 <= '0';
            vsync_r2 <= '0';
        elsif rising_edge( ddr_clk ) then
            vsync_r1 <= syn_off0_vs ; 
            vsync_r2 <= vsync_r1 ; 
            vsync_rise <= vsync_r1 and (not vsync_r2) ; 
            vsync_fall <= vsync_r2 and (not vsync_r1) ; 
        end if;
end process;

process ( rst_n , ddr_clk )
    begin
        if rst_n = '0' then 
            cs <= IDLE ;
        elsif rising_edge( ddr_clk ) then
            cs <= ns ;
        end if;
end process;
process( cs,time_out,usr_ddr3_rd_p.ack,usr_ddr3_rd_p.finish )
    begin    
        case cs is      
            when IDLE =>                        if ( vsync_fall = '1' ) then       --linea data rd start   
                                                    ns <= FRAME_START ;
                                                else
                                                    ns <= IDLE ;
                                                end if;  
			--READ DDR 	 
            when FRAME_START =>                     ns <=  RD_REQ ;
            when RD_REQ 	=>                  if time_out >= X"00ff" then 
                                                    ns <=  TIMEOUT ;
                                                elsif ( usr_ddr3_rd_p.ack = '1' ) then 
                                                    ns <=  RD_DDR ;
                                                else
                                                    ns <=  RD_REQ ; 
                                                end if ;  
            when RD_DDR  =>                     if time_out >= X"0fff" then 
                                                    ns <=  TIMEOUT ;
                                                elsif usr_ddr3_rd_p.finish = '1' then               
                                                    ns <=  RD_CHECK ;
                                                else 
                                                    ns <=  RD_DDR ;                   
                                                end if; 
            when RD_CHECK =>                    if rd_cnt >= 719 then   
                                                    ns <=  FRAME_END ; 	 
                                                else  
                                                    ns <=  CONTINUE_RD ;  
                                                end if ;   
            when CONTINUE_RD =>                     ns <=  FIFO_CHECK ; 
            when FIFO_CHECK =>                  if time_out >= X"03ffff" then 
                                                    ns <=  TIMEOUT ;
                                                elsif out_de_fall = '1' then  -- 等待fifp 超过1帧数据了
                                                    ns <=  WAIT_FIFO_RST ; 
                                                else  
                                                    ns <=  FIFO_CHECK ;  
                                                end if ;
            when WAIT_FIFO_RST =>               if time_out >= X"0020" then  
                                                    ns <=  RD_REQ ; 	 
                                                else  
                                                    ns <=  WAIT_FIFO_RST ;  
                                                end if ; 	 
            when FRAME_END =>                       ns <=  IDLE ; 	 
            when TIMEOUT =>                     	ns <=  IDLE ; 	 
            when others =>                          ns <=  IDLE ;
        end case;
end process; 
process( rst_n,ddr_clk )
    begin
        if rst_n ='0' then
            time_out <= (others => '0') ;
        elsif rising_edge( ddr_clk ) then
            if ( cs /= ns ) then
                time_out <= (others => '0') ;
            else
                time_out <= time_out + '1' ;
            end if;
        end if;
end process; 

process( rst_n,ddr_clk )
    begin
        if rst_n ='0' then
            rd_cnt <= 0 ;
        elsif rising_edge( ddr_clk ) then
            if ( cs = FRAME_START ) then
                rd_cnt <= 0 ;
            elsif cs = CONTINUE_RD then 
                rd_cnt <= rd_cnt + 1 ;
            end if;
        end if;
end process;   

process ( rst_n , ddr_clk )
    begin
        if rst_n = '0' then 
            usr_ddr3_rd_q.req <= '0'; 
        elsif rising_edge ( ddr_clk ) then
            if ( cs = RD_REQ ) then
                usr_ddr3_rd_q.req <= '1';
            else
                usr_ddr3_rd_q.req <= '0';
            end if;
        end if;
end process;   


process ( rst_n , ddr_clk )
    begin
        if rst_n = '0' then 
            usr_ddr3_rd_q.addr <= (others => '0');
        elsif rising_edge ( ddr_clk ) then
            if ( cs = FRAME_START ) then
                if mode = X"01" then 
                    if coms0_wr_area = '0'  then 
                        usr_ddr3_rd_q.addr(27 downto 0)  <= coms0_addrb ;    
                    else
                        usr_ddr3_rd_q.addr(27 downto 0)  <= coms0_addra ;    
                    end if ;
                elsif mode = X"02" then 
                    if coms0_wr_area = '0'  then 
                        usr_ddr3_rd_q.addr(27 downto 0)  <= coms1_addrb ;    
                    else
                        usr_ddr3_rd_q.addr(27 downto 0)  <= coms1_addra ;    
                    end if ;     
                else
                    if coms0_wr_area = '0'  then 
                        usr_ddr3_rd_q.addr(27 downto 0)  <= coms2_addrb ;    
                    else
                        usr_ddr3_rd_q.addr(27 downto 0)  <= coms2_addra ;    
                    end if ;                    
                end if ;
            elsif cs = RD_CHECK then 
                usr_ddr3_rd_q.addr(27 downto 0) <= usr_ddr3_rd_q.addr(27 downto 0) +  X"100" ;      
            end if ;
        end if;
end process; 
-- process ( rst_n , ddr_clk )
--     begin
--         if rst_n = '0' then 
--             usr_ddr3_rd_q.addr <= (others => '0');
--         elsif rising_edge ( ddr_clk ) then
--             if ( cs = FRAME_START ) then
--                 if current_buffer_addr = X"0200000" then  
--                     usr_ddr3_rd_q.addr(27 downto 0)  <= X"0280000" ;   
--                 elsif current_buffer_addr = X"0240000" then           
--                     usr_ddr3_rd_q.addr(27 downto 0)  <= X"0200000" ;        
--                 else 
--                     usr_ddr3_rd_q.addr(27 downto 0)  <= X"0240000" ;                    
--                 end if ;
--             elsif cs = RD_CHECK then 
--                 usr_ddr3_rd_q.addr(27 downto 0) <= usr_ddr3_rd_q.addr(27 downto 0) +  X"100" ;      
--             end if ;
--         end if;
-- end process; 



usr_ddr3_rd_q.len  <=  X"0050"  ;
fifo_rst <=   out_de_fall or vsync_rise ;
-- fifo_rst <=   out_de_fall  ;
hdmi_buffer: fifo_256x512_16x8192
	port map (
		Data => usr_ddr3_rd_p.data,
		Reset => fifo_rst,
		WrClk => ddr_clk,
		RdClk => video_clk,
		WrEn => usr_ddr3_rd_p.dv,
		RdEn => out_de,
		Almost_Full => fifo_prog_full, 
		Wnum => open, 
		Rnum => open, 
		Q       => fifo_rd_data,
		Empty   => open,
		Full    => open );
 
process( rst_n,video_clk )
    begin
        if rst_n ='0' then
            out_de_reg1 <= '0'; 
            off0_syn_de  <= '0';
        elsif rising_edge( video_clk ) then
            out_de_reg1  <= out_de ; 
            off0_syn_de  <= out_de_reg1 ;
        end if;
end process;
 
            off0_syn_data <= fifo_rd_data ; 
process( rst_n,ddr_clk )
    begin
        if rst_n ='0' then
            out_de_r1 <= '0';
            out_de_r2 <= '0';
            out_de_r3 <= '0';
            out_de_r4 <= '0';
            out_de_fall <= '0';
        elsif rising_edge( ddr_clk ) then
            out_de_r1 <=out_de  ;
            out_de_r2 <=out_de_r1  ;
            out_de_r3 <=out_de_r2  ;
            out_de_r4 <=out_de_r3  ;
            out_de_fall <=out_de_r4 and (not out_de_r3)  ;
        end if;
end process;
--***************************************************************
-- debug
--***************************************************************

-- process( rst_n,video_clk )
--     begin
--         if rst_n ='0' then
--             vs_r1 <= '0';
--             vs_r2 <= '0';
--             vs_rise <= '0';
--             hs_r1 <= '0';
--             hs_r2 <= '0';
--             hs_rise <= '0';
--         elsif rising_edge( video_clk ) then
--             vs_r1 <= out_de ;
--             vs_r2 <= vs_r1 ;
--             vs_rise <= vs_r1 and (not vs_r2) ;
--             hs_r1 <= syn_off0_hs ;
--             hs_r2 <= hs_r1 ;
--             hs_rise <= hs_r1 and (not hs_r2) ;
--         end if;
-- end process;

-- process( rst_n,video_clk )
--     begin
--         if rst_n ='0' then
--             cnt_pix <= 0 ;
--         elsif rising_edge( video_clk ) then
--             if ( off0_syn_de = '1' ) then
--                 cnt_pix <= cnt_pix + 1;
--             else
--                 cnt_pix <= 0 ;
--             end if;
--         end if;
-- end process;
-- process( rst_n,video_clk )
--     begin
--         if rst_n ='0' then
--             cnt_line <= 0 ;
--         elsif rising_edge( video_clk ) then
--             if ( hs_rise = '1' ) then
--                 cnt_line <= cnt_line + 1;
--             elsif vs_rise = '1' then 
--                 cnt_line <= 0 ;
--             end if;
--         end if;
-- end process;
-- process( rst_n,video_clk )
--     begin
--         if rst_n ='0' then
--             over_flag <= '0';
--         elsif rising_edge( video_clk ) then
--             if ( off0_syn_de = '1' ) and cnt_pix < 320 and off0_syn_data (15 downto 14) > 0  then
--                 over_flag <= '1';
--             else
--                 over_flag <= '0';
--             end if;
--         end if;
-- end process;

end rtl; 