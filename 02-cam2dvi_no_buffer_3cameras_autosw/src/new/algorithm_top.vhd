library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.mt_lib.all;  
entity algorithm_top is
    generic (        
        coms0_addra                 :in  std_logic_vector (27 downto 0) ; 
        coms0_addrb                 :in  std_logic_vector (27 downto 0) ; 
        coms1_addra                 :in  std_logic_vector (27 downto 0) ; 
        coms1_addrb                 :in  std_logic_vector (27 downto 0) ; 
        coms2_addra                 :in  std_logic_vector (27 downto 0) ; 
        coms2_addrb                 :in  std_logic_vector (27 downto 0) 
    );
    port (        
	    clk                         : in std_logic;  
	    rst_n                       : in std_logic;  
        syn_off0_vs                 : in std_logic ; 
        coms0_wr_area               : in std_logic;
        coms1_wr_area               : in std_logic;
        coms2_wr_area               : in std_logic;   
        current_buffer_addr         : out std_logic_vector(27 downto 0);
        usr_ddr3_wr_q               : buffer usr_ddr3_wr_q ;
        usr_ddr3_wr_p               : in usr_ddr3_wr_p   ;  
        usr_ddr3_rd_q               : buffer usr_ddr3_rd_q ;
        usr_ddr3_rd_p               : in usr_ddr3_rd_p  );
end algorithm_top ;
architecture rtl of algorithm_top is 

component ram_256x128
    port (
        dout: out std_logic_vector(255 downto 0);
        clka: in std_logic;
        cea: in std_logic;
        clkb: in std_logic;
        ceb: in std_logic;
        oce: in std_logic;
        reset: in std_logic;
        ada: in std_logic_vector(6 downto 0);
        din: in std_logic_vector(255 downto 0);
        adb: in std_logic_vector(6 downto 0)
    );
end component;

constant IDLE                       : std_logic_vector(7 downto 0):= X"01"; 
constant CHECK_DDR                  : std_logic_vector(7 downto 0):= X"02"; 
constant RD_PRE                     : std_logic_vector(7 downto 0):= X"03"; 
constant RD_REQ                     : std_logic_vector(7 downto 0):= X"04";   
constant RD_DDR                     : std_logic_vector(7 downto 0):= X"05";  
constant COMS_CHECK                 : std_logic_vector(7 downto 0):= X"06"; 
constant RD_NEXT_CMOS               : std_logic_vector(7 downto 0):= X"07"; 
constant RD_LINE_END                : std_logic_vector(7 downto 0):= X"08"; 
constant WR_PRE                     : std_logic_vector(7 downto 0):= X"09"; 
constant WR_REQ                     : std_logic_vector(7 downto 0):= X"0a"; 
constant WR                         : std_logic_vector(7 downto 0):= X"0b"; 
constant WR_LINE_END 				: std_logic_vector(7 downto 0):= X"0c"; 
constant CHECK_LINE_NUM             : std_logic_vector(7 downto 0):= X"0d"; 
constant CONVERT_END                : std_logic_vector(7 downto 0):= X"0e"; 
constant TIMEOUT                    : std_logic_vector(7 downto 0):= X"0f"; 
constant WR_NEXT_LINE               : std_logic_vector(7 downto 0):= X"10"; 

constant time_10ms                  : integer := 1_000_000 ;
signal time_out                     : integer range 0 to time_10ms + 1 ;
signal cs                           : std_logic_vector(7 downto 0):= IDLE ;
signal ns                           : std_logic_vector(7 downto 0):= IDLE ; 
signal cs_r1                        : std_logic;
signal cs_r2                        : std_logic;
signal cs_rise                      : std_logic; 
-- signal ddr_area_buffer              : std_logic_vector(2 downto 0);
signal cmos_cnt                     : integer range 0 to 16 ;
signal line_cnt                     : integer range 0 to 1024;
signal ram_rd_data                  : std_logic_vector(255 downto 0);
signal ram_wr_data                  : std_logic_vector(255 downto 0);
signal ram_wr_addr                  : std_logic_vector(6 downto 0);
signal ram_rd_addr                  : std_logic_vector(6 downto 0);
signal ram_rd_en                    : std_logic ;
signal ram_wr_en                    : std_logic ;
signal cmos0_rd_addr                : std_logic_vector(27 downto 0);
signal cmos1_rd_addr                : std_logic_vector(27 downto 0);
signal cmos2_rd_addr                : std_logic_vector(27 downto 0);
signal cnt_rx_pix                   : integer range 0 to 2048 ;
signal ddr_wr_init_addr             : std_logic_vector(27 downto 0);
begin 
process( rst_n,clk )
    begin
        if rst_n ='0' then
            cs_rise <= '0' ; cs_r1 <= '0' ; cs_r2 <= '0' ;
        elsif rising_edge( clk ) then
            re ( syn_off0_vs, cs_rise, cs_r1, cs_r2 ) ;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then 
            cs <= IDLE ;
        elsif rising_edge( clk ) then
            cs <= ns ;
        end if;
end process;
process( cs,time_out,usr_ddr3_rd_p.ack,usr_ddr3_rd_p.finish,usr_ddr3_wr_p.ack,usr_ddr3_wr_p.finish,cmos_cnt,line_cnt,cs_rise )
    begin    
        case cs is      
            when IDLE =>                        if ( cs_rise = '1' ) then       --linea data rd start   
                                                    ns <= CHECK_DDR ;
                                                else
                                                    ns <= IDLE ;
                                                end if;    
            when CHECK_DDR =>                       ns <= RD_PRE;
			--READ DDR 	  
            when RD_PRE =>                          ns <=  RD_REQ ;
            when RD_REQ =>                      if time_out >= time_10ms then 
                                                    ns <=  TIMEOUT ;
                                                elsif ( usr_ddr3_rd_p.ack = '1' ) then 
                                                    ns <=  RD_DDR ;
                                                else
                                                    ns <=  RD_REQ ; 
                                                end if ;  
            when RD_DDR  =>                     if time_out >= time_10ms then 
                                                    ns <=  TIMEOUT ;
                                                elsif usr_ddr3_rd_p.finish = '1' then               
                                                    ns <=  COMS_CHECK ;
                                                else 
                                                    ns <=  RD_DDR ;                   
                                                end if; 
            when COMS_CHECK =>                    if cmos_cnt >= 2 then   
                                                    ns <=  RD_LINE_END ; 	 
                                                else  
                                                    ns <=  RD_NEXT_CMOS ;  
                                                end if ;   
            when RD_NEXT_CMOS =>                     ns <=  RD_PRE ; 

            when RD_LINE_END =>                     ns <=  WR_PRE ; 

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
                                                    ns <=  WR_LINE_END ;
                                                else
                                                    ns <=  WR ; 
                                                end if ;  
			when WR_LINE_END => 				    ns <=  CHECK_LINE_NUM ;  
            when CHECK_LINE_NUM =>              if line_cnt >= 719 then   
                                                    ns <=  CONVERT_END ; 
                                                else  
                                                    ns <=  WR_NEXT_LINE ;  
                                                end if ; 
            when WR_NEXT_LINE =>                    ns <=  RD_PRE ; 	 
            when CONVERT_END =>                     ns <=  IDLE ; 	 
            when TIMEOUT =>                     	ns <=  IDLE ; 	 
            when others =>                          ns <=  IDLE ;
        end case;
end process; 
process( rst_n,clk )
    begin
        if rst_n ='0' then
            time_out <= 0 ;
        elsif rising_edge( clk ) then
            if ( cs /= ns ) then
                time_out <= 0 ;
            else
                time_out <= time_out + 1 ;
            end if;
        end if;
end process;  

process( rst_n,clk )
    begin
        if rst_n ='0' then
            cmos_cnt <= 0 ;
        elsif rising_edge( clk ) then
            if ( cs = CONVERT_END ) or (cs = IDLE) or (cs = RD_LINE_END)then
                cmos_cnt <= 0 ;
            elsif cs =  RD_NEXT_CMOS then 
                cmos_cnt <= cmos_cnt + 1 ;
            end if;
        end if;
end process;  
process( rst_n,clk )
    begin
        if rst_n ='0' then
            line_cnt <= 0 ;
        elsif rising_edge( clk ) then
            if ( cs = CONVERT_END ) or (cs = IDLE)  then
                line_cnt <= 0 ;
            elsif cs =  WR_NEXT_LINE then 
                line_cnt <= line_cnt + 1 ;
            end if;
        end if;
end process;  
--***************************************************************
-- rd ddr
--***************************************************************
usr_ddr3_rd_q.len  <=  X"0050"  ;
process ( rst_n , clk )
    begin
        if rst_n = '0' then 
            usr_ddr3_rd_q.req <= '0'; 
        elsif rising_edge ( clk ) then
            if ( cs = RD_REQ ) then
                usr_ddr3_rd_q.req <= '1';
            else
                usr_ddr3_rd_q.req <= '0';
            end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then 
            cmos0_rd_addr <= (others => '0'); 
        elsif rising_edge ( clk ) then
            if (cs = IDLE )then --初始化读取地址
                cmos0_rd_addr <= (others => '0');
            elsif  cs = CHECK_DDR  then 
                if ( coms0_wr_area = '0'  ) then 
                    cmos0_rd_addr  <= coms0_addrb ; 
                else 
                    cmos0_rd_addr  <= coms0_addra; 
                end if;
            elsif cs = RD_LINE_END then   
                cmos0_rd_addr <= cmos0_rd_addr + X"100";  
            end if ;
        end if;
end process; 
process ( rst_n , clk )
    begin
        if rst_n = '0' then 
            cmos1_rd_addr <= (others => '0'); 
        elsif rising_edge ( clk ) then
            if (cs = IDLE )then --初始化读取地址
                cmos1_rd_addr <= (others => '0');
            elsif  cs = CHECK_DDR  then 
                if ( coms1_wr_area = '0'  ) then 
                    cmos1_rd_addr  <= coms1_addrb ; 
                else 
                    cmos1_rd_addr  <= coms1_addra; 
                end if;
            elsif cs = RD_LINE_END then   
                cmos1_rd_addr <= cmos1_rd_addr + X"100";  
            end if ;
        end if;
end process; 
process ( rst_n , clk )
    begin
        if rst_n = '0' then 
            cmos2_rd_addr <= (others => '0'); 
        elsif rising_edge ( clk ) then
            if (cs = IDLE )then --初始化读取地址
                cmos2_rd_addr <= (others => '0');
            elsif  cs = CHECK_DDR  then 
                if ( coms2_wr_area = '0'  ) then 
                    cmos2_rd_addr  <= coms2_addrb ; 
                else 
                    cmos2_rd_addr  <= coms2_addra; 
                end if;
            elsif cs = RD_LINE_END then   
                cmos2_rd_addr <= cmos2_rd_addr + X"100";  
            end if ;
        end if;
end process; 
process ( rst_n , clk )
    begin
        if rst_n = '0' then 
            usr_ddr3_rd_q.addr <= (others => '0');
        elsif rising_edge ( clk ) then
            if ( cs = RD_PRE ) then
                if cmos_cnt = 0 then 
                    usr_ddr3_rd_q.addr(27 downto 0) <= cmos0_rd_addr ;
                elsif cmos_cnt = 1 then 
                    usr_ddr3_rd_q.addr(27 downto 0) <= cmos1_rd_addr ; 
                elsif cmos_cnt = 2 then 
                    usr_ddr3_rd_q.addr(27 downto 0) <= cmos2_rd_addr ;               
                end if ;
            elsif cs = IDLE then 
                usr_ddr3_rd_q.addr(27 downto 0) <= (others => '0'); 
            end if ;
        end if;
end process; 
process( rst_n,clk )
    begin
        if rst_n ='0' then
             ram_wr_data <= (others => '0');
        elsif rising_edge( clk ) then
             ram_wr_data <= usr_ddr3_rd_p.data ;
        end if;
end process;
process( rst_n,clk )
    begin
        if rst_n ='0' then
            cnt_rx_pix <= 0 ;
        elsif rising_edge( clk ) then
            if ( usr_ddr3_rd_p.dv  = '1'  ) then
                cnt_rx_pix <= cnt_rx_pix + 1 ;
            else
                cnt_rx_pix <= 0 ;
            end if; 
        end if;
end process;
process( rst_n,clk )
    begin
        if rst_n ='0' then
            ram_wr_en <= '0';
        elsif rising_edge( clk ) then
            if ( cmos_cnt = 0  ) then
                if ( cnt_rx_pix >= 26 and cnt_rx_pix <= 53  ) and usr_ddr3_rd_p.dv  = '1' then
                    ram_wr_en <= '1';
                else
                    ram_wr_en <= '0';
                end if;
            elsif ( cmos_cnt = 1  ) then
                if ( cnt_rx_pix >= 27 and cnt_rx_pix <= 52  ) and usr_ddr3_rd_p.dv  = '1' then
                    ram_wr_en <= '1';
                else
                    ram_wr_en <= '0';
                end if;
            elsif ( cmos_cnt = 2  ) then
                if ( cnt_rx_pix >= 27 and cnt_rx_pix <= 52  ) and usr_ddr3_rd_p.dv  = '1' then
                    ram_wr_en <= '1';
                else
                    ram_wr_en <= '0';
                end if;
            else
                ram_wr_en <= '0';
            end if; 
        end if;
end process;
process( rst_n,clk )
    begin
        if rst_n ='0' then
             ram_wr_addr <= (others => '0');
        elsif rising_edge( clk ) then
            if cs = IDLE or cs = RD_LINE_END or cs = WR_NEXT_LINE then 
                ram_wr_addr <= (others => '0');
            elsif ( ram_wr_en  = '1' ) then
                ram_wr_addr <= ram_wr_addr +'1';
             end if;
        end if;
end process;
buffer_line : ram_256x128 port map (
        dout         => ram_rd_data ,
        clka         => clk         ,
        cea          => ram_wr_en   ,
        clkb         => clk         ,
        ceb          => ram_rd_en   ,
        oce          => '1'         ,
        reset        => not rst_n   ,
        ada          => ram_wr_addr ,
        din          => ram_wr_data ,
        adb          => ram_rd_addr );
ram_rd_en <= usr_ddr3_wr_p.data_req ;        
process( rst_n,clk )
    begin
        if rst_n ='0' then
            ram_rd_addr <= (others => '0');
        elsif rising_edge( clk ) then
            if cs = WR_REQ or cs = WR then 
                if ( ram_rd_en  = '1' ) then
                    ram_rd_addr <= ram_rd_addr +'1'; 
                end if ;
            else
                ram_rd_addr <= (others => '0');
            end if ;
        end if;
end process; 
--***************************************************************
-- wr ddr 
--***************************************************************
usr_ddr3_wr_q.data      <= ram_rd_data ;
usr_ddr3_wr_q.len       <=  X"0050"  ; 
current_buffer_addr     <= ddr_wr_init_addr ;
process( rst_n,clk )
    begin
        if rst_n ='0' then
            ddr_wr_init_addr <= X"0200000"; 
        elsif rising_edge( clk ) then
            if ( cs = CONVERT_END ) then
                if ( ddr_wr_init_addr = X"0200000" ) then
                    ddr_wr_init_addr <= X"0240000" ;
                elsif ( ddr_wr_init_addr = X"0240000" ) then
                    ddr_wr_init_addr <= X"0280000" ;
                else
                    ddr_wr_init_addr <= X"0200000" ;
                end if;
            end if; 
        end if;
end process;
process( rst_n,clk )
    begin
        if rst_n ='0' then
            usr_ddr3_wr_q.addr <= (others => '0') ;
        elsif rising_edge( clk ) then
            if ( cs = CHECK_DDR ) then 
                usr_ddr3_wr_q.addr(27 downto 0) <=ddr_wr_init_addr;     
            elsif cs = WR_LINE_END then  
                usr_ddr3_wr_q.addr(27 downto 0) <= usr_ddr3_wr_q.addr(27 downto 0) +  X"100" ;   
            end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then 
            usr_ddr3_wr_q.req <= '0';
        elsif rising_edge( clk ) then
            if ( cs = WR_REQ ) then
                usr_ddr3_wr_q.req <= '1';
            else
                usr_ddr3_wr_q.req <= '0';
            end if;
        end if;
end process;   

end rtl; 