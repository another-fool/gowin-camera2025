library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.mt_lib.all; 
 
entity mem_burst is	
    port (		
        clk 			        	: in std_logic; 
        rst_n 			        	: in std_logic; 
		ddr3_rd_q					: in ddr3_rd_q ;		
		ddr3_rd_p					: buffer ddr3_rd_p ;		
		ddr3_wr_q					: in ddr3_wr_q ;		
		ddr3_wr_p					: buffer ddr3_wr_p ;
		init_calib_complete         : in std_logic;
		cmd_ready                   : in std_logic;
		cmd                         : buffer  std_logic_vector(2 downto 0);
		cmd_en                      : buffer std_logic;
		addr                        : buffer  std_logic_vector(28 downto 0);
		wr_data_rdy                 : in std_logic;
		wr_data                     : buffer  std_logic_vector(255 downto 0);
		wr_data_en                  : buffer  std_logic;
		wr_data_end                 : buffer  std_logic;
		wr_data_mask                : buffer  std_logic_vector(31 downto 0);
		rd_data                     : in std_logic_vector(255 downto 0);
		rd_data_valid               : in std_logic;
		rd_data_end                 : in std_logic);
end mem_burst ;
architecture rtl of mem_burst is
constant IDLE              : std_logic_vector(7 downto 0) := X"01";
constant INIT              : std_logic_vector(7 downto 0) := X"02";
constant MEM_READ_PREPARE  : std_logic_vector(7 downto 0) := X"03";
constant MEM_READ          : std_logic_vector(7 downto 0) := X"04";
constant READ_END          : std_logic_vector(7 downto 0) := X"05";
constant MEM_WRITE_PREPARE : std_logic_vector(7 downto 0) := X"06";
constant MEM_WRITE         : std_logic_vector(7 downto 0) := X"07";
constant WRITE_END         : std_logic_vector(7 downto 0) := X"08";
signal  cs                 : std_logic_vector(7 downto 0) := IDLE;
signal  ns                 : std_logic_vector(7 downto 0) := IDLE;
constant TIME_OUT	                : integer := 512 + 256 ;
signal rd_addr_cnt 		            : std_logic_vector(15 downto 0);
signal rd_data_cnt 		            : std_logic_vector(15 downto 0);
signal wr_addr_cnt 		            : std_logic_vector(15 downto 0);
signal wr_data_cnt 		            : std_logic_vector(15 downto 0);
signal app_en_r 		            : std_logic;
signal data_req 		            : std_logic;
signal app_addr_r 		            : std_logic_vector( 28 downto 0);
signal sm_state 		            : std_logic_vector(7 downto 0);
signal timeout_cnt 		            : integer range 0 to TIME_OUT +1 ; 
 begin
wr_data_mask <= (others=>'0') ;
process( rst_n,clk ) 
    begin
        if rst_n = '0' then 
            cs <= INIT ;
        elsif rising_edge( clk ) then
            cs <= ns ;
        end if;
end process;
	
process(cs,init_calib_complete,ddr3_rd_q.req,ddr3_wr_q.req,rd_data_cnt,cmd_ready,app_en_r,wr_data_rdy,wr_addr_cnt,timeout_cnt,rd_data_valid ,ddr3_wr_q.len,ddr3_rd_q.len,wr_data_cnt)
    begin    
        case cs is     
            when INIT =>			    if ( init_calib_complete = '1' ) then
                                            ns <= IDLE ;
                                        else
                                            ns <= INIT ;
                                        end if;
            when IDLE =>			    if ( ddr3_rd_q.req = '1' ) then
                                            ns <= MEM_READ_PREPARE ;
									    elsif ( ddr3_wr_q.req = '1' ) then
                                            ns <= MEM_WRITE_PREPARE ;
                                        else
                                            ns <= IDLE ;
                                        end if;	
			when MEM_READ_PREPARE =>        ns <= MEM_READ ;										
            when MEM_READ =>		    if timeout_cnt = TIME_OUT then 
											ns <= READ_END ;		
			                            elsif ( rd_data_valid = '1' and rd_data_cnt >= ddr3_rd_q.len - '1' )  then 
                                            ns <= READ_END ;
                                        else
                                            ns <= MEM_READ ;
                                        end if;	
			when READ_END =>        		ns <= IDLE ;										
			when MEM_WRITE_PREPARE =>       ns <= MEM_WRITE ;										
            when MEM_WRITE =>		    if timeout_cnt = TIME_OUT then 
											ns <= WRITE_END ;		
			                            elsif (  wr_addr_cnt >= ddr3_wr_q.len - '1' and cmd_ready = '1'  )and (  wr_data_cnt >= ddr3_wr_q.len - '1' and wr_data_rdy = '1'  ) then 
											ns <= WRITE_END ;
										else
											ns <= MEM_WRITE ;	
                                        end if ;
			when WRITE_END =>        		ns <= IDLE ;
			when others	=>      			ns <= IDLE ;
        end case;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            timeout_cnt <= 0 ;
        elsif rising_edge ( clk ) then
            if ( cs = MEM_WRITE or cs = MEM_READ ) then
                timeout_cnt <= timeout_cnt + 1 ;
            else
                timeout_cnt <= 0 ;
            end if;
        end if;
end process;
--====================================
-- app interface
--====================================
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            cmd <= (others=>'0') ;
        elsif rising_edge ( clk ) then
            if cs = IDLE then 
                 cmd <= "000" ;   
            elsif ( cs = MEM_READ_PREPARE ) then
                cmd <= "001" ;
            elsif ( cs = MEM_WRITE_PREPARE ) then
                cmd <= "000" ;
            end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            rd_addr_cnt <= (others=>'0') ;
        elsif rising_edge ( clk ) then
            if ( cs = MEM_READ ) then	
				if ( cmd_ready = '1' and cmd_en = '1' ) then
                    if ( rd_addr_cnt < ddr3_rd_q.len - '1' ) then
                        rd_addr_cnt <= rd_addr_cnt + '1' ;
                    end if;
				end if;
            else 
               rd_addr_cnt <= (others=>'0') ; 
            end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            wr_addr_cnt <= (others=>'0') ;
        elsif rising_edge ( clk ) then
            if ( cs = MEM_WRITE ) then	
				if ( cmd_ready = '1' and cmd_en = '1') then
                    if ( wr_addr_cnt < ddr3_wr_q.len - '1' ) then
                        wr_addr_cnt <= wr_addr_cnt + '1' ;
                    end if;
				end if;
            else
               wr_addr_cnt <= (others=>'0') ; 
            end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            rd_data_cnt <= (others=>'0') ;
        elsif rising_edge ( clk ) then
            if ( cs = MEM_READ ) then	
				if ( rd_data_valid = '1' ) then
                    if ( rd_data_cnt < ddr3_rd_q.len - '1' ) then
                        rd_data_cnt <= rd_data_cnt + '1' ;
                    end if;
				end if;
            else
               rd_data_cnt <= (others=>'0') ; 
            end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            wr_data_cnt <= (others=>'0') ;
        elsif rising_edge ( clk ) then
            if ( cs = MEM_WRITE ) then	
				if ( wr_data_en = '1' and wr_data_rdy = '1' ) then
                    if ( wr_data_cnt < ddr3_wr_q.len - '1' ) then
                        wr_data_cnt <= wr_data_cnt + '1' ;
                    end if;
				end if;
            else
               wr_data_cnt <= (others=>'0') ; 
            end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            app_addr_r <= (others=>'0') ;
        elsif rising_edge ( clk ) then
			if cs = MEM_READ_PREPARE then
			    app_addr_r <= ddr3_rd_q.addr ( 25 downto 0) & "000" ;
			elsif cs = MEM_WRITE_PREPARE then
			    app_addr_r <= ddr3_wr_q.addr ( 25 downto 0) & "000" ;				
            elsif ( cs = MEM_READ ) then	
				if ( cmd_ready = '1' and app_en_r = '1' ) then
                    app_addr_r <= app_addr_r + "1000" ;
				end if ;
            elsif ( cs = MEM_WRITE ) then	
				if ( cmd_ready = '1'and app_en_r = '1' ) then
                    app_addr_r <= app_addr_r + "1000" ;
				end if ;
            end if;
        end if;
end process;
addr<= app_addr_r ;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            app_en_r <= '0';
        elsif rising_edge ( clk ) then
			if ( cs = MEM_READ ) then	
				if ( rd_addr_cnt < ddr3_rd_q.len - '1' ) then 
                    app_en_r <= '1';
				elsif cmd_ready = '1' then 
					app_en_r <= '0';
				end if ;	
			elsif ( cs = MEM_WRITE ) then	
				if ( wr_addr_cnt < ddr3_wr_q.len - '1' ) then 
                    app_en_r <= '1';
				elsif cmd_ready = '1' then 
					app_en_r <= '0';
				end if ;
			else
				app_en_r <= '0';
            end if;
        end if;
end process;
cmd_en <= app_en_r and cmd_ready ;
-- process ( rst_n , clk )
--     begin
--         if rst_n = '0' then
--             wr_data_en 		<= '0';
--         elsif rising_edge ( clk ) then
--             if ( cs = MEM_WRITE )then
-- 				if ( wr_data_cnt >= ddr3_wr_q.len - '1' and wr_data_rdy = '1' ) then
-- 					wr_data_en 	<= '0';	
-- 				elsif ( wr_data_rdy = '1'  ) then
--                 	wr_data_en 	<= '1';			
-- 				end if ;
--             else
--                 wr_data_en 	<= '0';
--             end if;
--         end if;
-- end process;
wr_data_en <= cmd_en  when cmd = 0 else '0' ;
wr_data_end <= wr_data_en ;

-- ddr3_wr_p.data_req 	<=  wr_data_rdy  when cs = MEM_WRITE and (wr_data_cnt < ddr3_wr_q.len - '1') and (wr_data_en = '1') else  '0' ;
data_req 	<=  wr_data_rdy  when cs = MEM_WRITE and (wr_data_cnt < ddr3_wr_q.len - '1') else  '0' ;
ddr3_wr_p.data_req <= data_req and cmd_ready ;   
-- wr_data_end 	<= wr_data_en ;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            ddr3_wr_p.finish <= '0';
        elsif rising_edge ( clk ) then
            if ( cs = WRITE_END ) then
                ddr3_wr_p.finish <= '1';
            else
                ddr3_wr_p.finish <= '0';
            end if;
        end if;
end process;
wr_data <= ddr3_wr_q.data ;
--rd ddr
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            ddr3_rd_p.dv 	<= '0';
            ddr3_rd_p.data 		<= (others=>'0') ;
        elsif rising_edge ( clk ) then
            ddr3_rd_p.dv 	<= rd_data_valid ;
            ddr3_rd_p.data	 		<= rd_data ;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            ddr3_rd_p.finish <= '0';
        elsif rising_edge ( clk ) then
            if ( cs = READ_END ) then
                ddr3_rd_p.finish <= '1';
            else
                ddr3_rd_p.finish <= '0';
            end if;
        end if;
end process;
end rtl ;
	