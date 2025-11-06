library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.mt_lib.all; 
entity ov5640_ctl is 
    generic (
        ddr3_start_addra:in  std_logic_vector (27 downto 0) ; 
        ddr3_start_addrb:in  std_logic_vector (27 downto 0)  
    );
    
    port ( 
        rst_n           : in std_logic; 
        --frome sensor
        cmos_vsync      : in std_logic;
        cmos_href       : in std_logic;
        cmos_pclk       : in std_logic; 
        cmos_db         : in std_logic_vector (7 downto 0) ; 
        --to ddr3
		ddr_clk	    	: in std_logic ;
		coms_wr_area	: buffer std_logic ;
        usr_ddr3_wr_q   : buffer usr_ddr3_wr_q ;
        usr_ddr3_wr_p   : in usr_ddr3_wr_p  );
end ov5640_ctl ;
architecture rtl of ov5640_ctl is
-- component ram_256X128
--     port (
--         dout: out std_logic_vector(255 downto 0);
--         clka: in std_logic;
--         cea: in std_logic;
--         clkb: in std_logic;
--         ceb: in std_logic;
--         oce: in std_logic;
--         reset: in std_logic;
--         ada: in std_logic_vector(6 downto 0);
--         din: in std_logic_vector(255 downto 0);
--         adb: in std_logic_vector(6 downto 0)
--     );
-- end component;
constant IDLE                       : std_logic_vector(7 downto 0) := X"01";
constant FIFO_RD_PRE                : std_logic_vector(7 downto 0) := X"02";
constant WR_PRE                     : std_logic_vector(7 downto 0) := X"03";
constant WR_REQ                     : std_logic_vector(7 downto 0) := X"04";
constant WR                         : std_logic_vector(7 downto 0) := X"05";
constant WR_END   				    : std_logic_vector(7 downto 0) := X"06"; 
constant CHECK_FIFO                 : std_logic_vector(7 downto 0) := X"07";
constant CONTINUE_WR                : std_logic_vector(7 downto 0) := X"08";
constant TIMEOUT                    : std_logic_vector(7 downto 0) := X"09";
constant FRAME_BUFFER_END           : std_logic_vector(7 downto 0) := X"0a";
constant FRAME_START                : std_logic_vector(7 downto 0) := X"0B";
constant FIFO_RST_WAIT                : std_logic_vector(7 downto 0) := X"0C";
constant RD_REQ                     : std_logic_vector(7 downto 0) := X"0d";
constant RD_DDR                     : std_logic_vector(7 downto 0) := X"0e";
signal cs                           : std_logic_vector(7 downto 0) := IDLE;
signal ns                           : std_logic_vector(7 downto 0) := IDLE;
signal cmos_16bit_data              : std_logic_vector(15 downto 0);
signal cmos_16bit_wr                : std_logic;
signal cmos_16bit_clk               : std_logic; 
signal fifo_rdy_n                   : std_logic; 
signal fifo_rdy                     : std_logic; 
signal fifo_reset                   : std_logic; 
signal time_out                     : std_logic_vector(23 downto 0);
signal vsync_rise                   : std_logic;
signal vsync_fall                   : std_logic;
signal vsync_r1                     : std_logic;
signal vsync_r2                     : std_logic;
signal href_rise                   : std_logic;
signal href_fall                   : std_logic;
signal href_r1                     : std_logic;
signal href_r2                     : std_logic;
signal href_r3                     : std_logic;
signal href_r4                     : std_logic;
signal fifo_rd_en_rst              : std_logic;
signal line_cnt                     : integer range 0 to 1024 ; 
begin
 

cmos_8_16bit_inst : entity work.cmos_8_16bit port map (
    rst                  => not rst_n             ,
    pclk                 => cmos_pclk             ,
    pdata_i              => cmos_db               ,
    de_i                 => cmos_href             ,
    pdata_o              => cmos_16bit_data       ,
    hblank               => cmos_16bit_wr         ,
    de_o                 => cmos_16bit_clk        );
-- fifo_reset <= vsync_fall ;--or fifo_rd_en_rst  ;
fifo_reset <= vsync_fall  or fifo_rd_en_rst  ;

sensor_wr_buffer : entity work.fifo_16x8192_256x512 port map (
	Data                 => cmos_16bit_data         ,
	WrClk                => cmos_16bit_clk          ,	 
    Reset                => fifo_reset              ,	
	RdClk                => ddr_clk                 ,
	WrEn                 => cmos_16bit_wr           ,
	RdEn                 => usr_ddr3_wr_p.data_req  ,
	Almost_Empty         => fifo_rdy_n              ,
	Rnum                 => open                    ,
	Q                    => usr_ddr3_wr_q.data      ,
	Empty                => open                    ,
	Full                 => open                    );
-- your_instance_name: ram_256X128
--     port map (
--         dout => ram_rd_data,
--         clka => ddr_clk,
--         cea => cea,
--         clkb => ddr_clk,
--         ceb => ceb,
--         oce => oce,
--         reset => reset,
--         ada => ada,
--         din => usr_ddr3_wr_q.data,
--         adb => adb
--     );
--***************************************************************
-- ddr wr 
--***************************************************************

process( rst_n,ddr_clk )
    begin
        if rst_n ='0' then 
            href_fall <= '0';
            href_r1 <= '0';
            href_r2 <= '0';
            href_r3 <= '0';
            href_r4 <= '0';
        elsif rising_edge( ddr_clk ) then
            href_r1 <= cmos_href ; 
            href_r2 <= href_r1 ; 
            href_r3 <= href_r2 ; 
            href_r4 <= href_r3 ;  
            href_fall <= href_r4 and (not href_r3) ; 
        end if;
end process;
process( rst_n,ddr_clk )
    begin
        if rst_n ='0' then
            vsync_rise <= '0';
            vsync_fall <= '0';
            vsync_r1 <= '0';
            vsync_r2 <= '0';
        elsif rising_edge( ddr_clk ) then
            vsync_r1 <= cmos_vsync ; 
            vsync_r2 <= vsync_r1 ; 
            vsync_rise <= vsync_r1 and (not vsync_r2) ; 
            vsync_fall <= vsync_r2 and (not vsync_r1) ; 
        end if;
end process;
process( rst_n, ddr_clk )
    begin
        if rst_n ='0' then
            fifo_rdy        <= '0' ;
        elsif rising_edge( ddr_clk ) then
            fifo_rdy        <= not fifo_rdy_n ;
        end if;
end process; 
--cross domain 
process ( rst_n , ddr_clk )
    begin
        if rst_n = '0' then 
            cs <= IDLE ;
        elsif rising_edge( ddr_clk ) then
            cs <= ns ;
        end if;
end process;
process( cs,time_out,usr_ddr3_wr_p.finish,usr_ddr3_wr_p.ack)
    begin    
        case cs is      
            when IDLE =>                        if vsync_fall = '1' then            --wr ddr start
                                         			ns <=  FRAME_START ; 
                                                else
                                                    ns <= IDLE ;
                                                end if;
            when FRAME_START =>                     ns <=  FIFO_RD_PRE ;
            when FIFO_RD_PRE =>                 if time_out >= X"0FFFFF" then                  
                                                    ns <=  TIMEOUT ;
                                                elsif  href_fall = '1' then  
                                                    ns <=  WR_PRE ;  
                                                else
													ns <=  FIFO_RD_PRE ;
                                                end if;  
            when WR_PRE =>                          ns <=  WR_REQ ; 	
            when WR_REQ =>                      if time_out >= X"00ff" then                  
                                                    ns <=  TIMEOUT ;
                                                elsif ( usr_ddr3_wr_p.ack = '1' ) then 
                                                    ns <=  WR  ;
                                                else
                                                    ns <=  WR_REQ ; 
                                                end if ;
            when WR  =>                         if time_out >= X"0fff" then 					
                                                    ns <=  TIMEOUT ;
                                                elsif ( usr_ddr3_wr_p.finish = '1' ) then 
                                                    ns <=  WR_END ;
                                                else
                                                    ns <=  WR ; 
                                                end if ;  
			when WR_END => 				    	    ns <=  CHECK_FIFO ;   
			-- when WR_END => 				    	    ns <=  RD_REQ ; 
            -- when RD_REQ 	=>                  if time_out >= X"00ff" then 
            --                                         ns <=  TIMEOUT ;
            --                                     elsif ( usr_ddr3_rd_p.ack = '1' ) then 
            --                                         ns <=  RD_DDR ;
            --                                     else
            --                                         ns <=  RD_REQ ; 
            --                                     end if ;  
            -- when RD_DDR  =>                     if time_out >= X"0fff" then 
            --                                         ns <=  TIMEOUT ;
            --                                     elsif usr_ddr3_rd_p.finish = '1' then               
            --                                         ns <=  CHECK_FIFO ;
            --                                     else 
            --                                         ns <=  RD_DDR ;                   
            --                                     end if;            

            when CHECK_FIFO =>                   if line_cnt >= 719 then 
                                                    ns <=  FRAME_BUFFER_END ;  
                                                else
													ns <=  CONTINUE_WR ;
                                                end if; 


            when CONTINUE_WR =>                     ns <=  FIFO_RD_PRE ; 	
            when TIMEOUT =>                         ns <=  IDLE ; 	
            when FRAME_BUFFER_END =>                ns <=  IDLE ; 
            when others =>                          ns <=  IDLE ;
        end case ; 
end process ;  
--***************************************************************
-- DDR WR
--***************************************************************
process( rst_n,ddr_clk )
    begin
        if rst_n ='0' then
            fifo_rd_en_rst <= '0';
        elsif rising_edge( ddr_clk ) then
            if ( cs = WR_END ) then
                fifo_rd_en_rst <= '1';
            else
                fifo_rd_en_rst <= '0';
            end if;
        end if;
end process;
process( rst_n,ddr_clk )
    begin
        if rst_n ='0' then
            time_out <= (others => '0');
        elsif rising_edge( ddr_clk ) then
            if ( cs /= ns ) then
                time_out <= (others => '0');
            else
                time_out <= time_out + 1 ;
            end if;
        end if;
end process;
 
process( rst_n,ddr_clk )
    begin
        if rst_n ='0' then
            coms_wr_area <= '0';
        elsif rising_edge( ddr_clk ) then
            if ( cs = FRAME_BUFFER_END ) then
                coms_wr_area <= not coms_wr_area;   
            end if;
        end if;
end process;  
process( rst_n,ddr_clk )
    begin
        if rst_n ='0' then
            line_cnt <= 0 ;
        elsif rising_edge( ddr_clk ) then
            if ( cs = FRAME_START )or cs = IDLE then
                line_cnt <= 0 ;
            elsif cs = CONTINUE_WR then 
                line_cnt <= line_cnt + 1 ;
            end if; 
        end if;
end process;
usr_ddr3_wr_q.len       <=  X"0050"  ; 
process( rst_n,ddr_clk )
    begin
        if rst_n ='0' then
            usr_ddr3_wr_q.addr <= (others => '0') ;
        elsif rising_edge( ddr_clk ) then
            if ( cs = FRAME_START ) then
                if coms_wr_area = '0'  then 
                    usr_ddr3_wr_q.addr(27 downto 0) <=ddr3_start_addra ;    
                else
                    usr_ddr3_wr_q.addr(27 downto 0) <= ddr3_start_addrb;    
                end if ;
            elsif cs = CONTINUE_WR then  
                usr_ddr3_wr_q.addr(27 downto 0) <= usr_ddr3_wr_q.addr(27 downto 0) +  X"100" ;   
            end if;
        end if;
end process;
process ( rst_n , ddr_clk )
    begin
        if rst_n = '0' then 
            usr_ddr3_wr_q.req <= '0';
        elsif rising_edge( ddr_clk ) then
            if ( cs = WR_REQ ) then
                usr_ddr3_wr_q.req <= '1';
            else
                usr_ddr3_wr_q.req <= '0';
            end if;
        end if;
end process;     
end rtl; 