library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.mt_lib.all;
entity udp_rx is 
    generic (
        LocalPort1  : STD_LOGIC_VECTOR(15 DOWNTO 0);
        LocalPort2  : STD_LOGIC_VECTOR(15 DOWNTO 0);
        LocalPort3  : STD_LOGIC_VECTOR(15 DOWNTO 0);
        LocalPort4  : STD_LOGIC_VECTOR(15 DOWNTO 0);
        LocalPort5  : STD_LOGIC_VECTOR(15 DOWNTO 0);
        LocalPort6  : STD_LOGIC_VECTOR(15 DOWNTO 0);
        LocalPort7  : STD_LOGIC_VECTOR(15 DOWNTO 0);
        LocalPort8  : STD_LOGIC_VECTOR(15 DOWNTO 0);
        RemotePort1 : STD_LOGIC_VECTOR(15 DOWNTO 0);
        RemotePort2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
        RemotePort3 : STD_LOGIC_VECTOR(15 DOWNTO 0);
        RemotePort4 : STD_LOGIC_VECTOR(15 DOWNTO 0);
        RemotePort5 : STD_LOGIC_VECTOR(15 DOWNTO 0);
        RemotePort6 : STD_LOGIC_VECTOR(15 DOWNTO 0);
        RemotePort7 : STD_LOGIC_VECTOR(15 DOWNTO 0);
        RemotePort8 : STD_LOGIC_VECTOR(15 DOWNTO 0)) ;	
    port (
        clk                	            : in std_logic;        
        rst_n                	        : in std_logic; 
        clk1                	        : in std_logic;      
        phy_rx							: in phy_rx ;		
		local_net						: in net_type ;
		usr1_rx							: buffer usr_rx	;		
		usr2_rx							: buffer usr_rx	;	
		usr3_rx							: buffer usr_rx	;	
		usr4_rx							: buffer usr_rx	;	
		usr5_rx							: buffer usr_rx	;	
		usr6_rx							: buffer usr_rx	;	
		usr7_rx							: buffer usr_rx	;	
		usr8_rx							: buffer usr_rx	);
end udp_rx;

architecture rtl of udp_rx is
COMPONENT ram_8x2048 PORT (
    clka  : IN STD_LOGIC;
    wea   : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    dina  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb  : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) );
END COMPONENT;
signal cnt_mac 				        : integer range 0 to 2047 :=0;
signal raw_data_length 		        : integer range 0 to 2047 :=0;
signal raw_data_length_domain1 		: integer range 0 to 2047 :=0;
signal raw_data_length_domain2 		: integer range 0 to 2047 :=0;
signal mac_src 				        : std_logic_vector(47 downto 0);
signal mac_src_reg 			        : std_logic_vector(47 downto 0);
signal mac_dst 				        : std_logic_vector(47 downto 0);
signal mac_type 			        : std_logic_vector(15 downto 0);
signal ip_length 			        : std_logic_vector(15 downto 0);
signal ip_protocol 			        : std_logic_vector(7 downto 0);
signal ip_src 				        : std_logic_vector(31 downto 0);
signal ip_src_reg 			        : std_logic_vector(31 downto 0);
signal ip_dst 				        : std_logic_vector(31 downto 0);
signal port_src 			        : std_logic_vector(15 downto 0);
signal port_src_reg 		        : std_logic_vector(15 downto 0);
signal port_dst 			        : std_logic_vector(15 downto 0);
signal udp_valid  			        : std_logic;
signal usr_mode 			        : integer range 0 to 15 ;
signal usr_mode_reg 	            : integer range 0 to 15 ;
signal usr_mode_reg_domain2         : integer range 0 to 15 ;
signal local_ip_s 			        : std_logic_vector(31 downto 0);
signal local_mac_s	 		        : std_logic_vector(47 downto 0);
signal rx_en_raw_phy 		        : std_logic_vector(0 downto 0);
signal rd_addr 				        : std_logic_vector(10 downto 0);
signal wr_addr 				        : std_logic_vector(10 downto 0);
signal rx_en_raw_phy_array 	        : std_logic_vector(7 downto 0);
signal rx_en_raw_reg 		        : std_logic;
signal rx_data_raw 			        : std_logic_vector(7 downto 0);
signal rx_en_raw_flag 		        : std_logic;
signal rx_en_raw_reg1  		        : std_logic;
signal rx_en_raw_reg2  		        : std_logic;
signal rx_en_raw_reg3  		        : std_logic;
signal mac_src_domain2_reg 			: std_logic_vector(47 downto 0);
signal ip_src_domain2_reg 			: std_logic_vector(31 downto 0);
signal port_src_domain2_reg 		: std_logic_vector(15 downto 0);
signal rd_addr_domain2 				: std_logic_vector(10 downto 0);
signal rx_en_raw_phy_array_domain2 	: std_logic_vector(7 downto 0);
signal rx_en_raw_domain2_reg		: std_logic;
signal rx_en_raw_domain2_reg1  		: std_logic;
signal rx_en_raw_domain2_reg2  		: std_logic;
signal rx_en_raw_domain2_reg3  		: std_logic;
signal rx_data_raw_domain2 			: std_logic_vector(7 downto 0);
signal rx_en_raw_flag_domain2 		: std_logic;
signal e_rx_dv_reg 			        : std_logic;
signal e_rxd_reg 			        : std_logic_vector(7 downto 0);

begin

process ( rst_n , phy_rx.clk )
    begin
        if rst_n = '0' then
            e_rx_dv_reg <= '0';
			e_rxd_reg  	<=  (others=>'0') ;			
        elsif rising_edge ( phy_rx.clk ) then
            e_rx_dv_reg <= phy_rx.dv ;
			e_rxd_reg 	<= phy_rx.data ;
        end if;
end process;
process( rst_n, phy_rx.clk )
    begin
        if rst_n = '0' then
            cnt_mac <= 0;
        elsif rising_edge( phy_rx.clk ) then
            if e_rx_dv_reg='1' then
                cnt_mac <= cnt_mac + 1;
            else
                cnt_mac <= 0;
            end if;
        end if;
end process;
process( rst_n, phy_rx.clk ) 
    begin
        if rst_n = '0' then
            mac_dst 		<= (others=>'0');
            mac_src 		<= (others=>'0');
            mac_type 		<= (others=>'0');
            ip_length 		<= (others=>'0');
            ip_protocol 	<= (others=>'0');
            ip_src 			<= (others=>'0');
            ip_dst 			<= (others=>'0');
            port_src 		<= (others=>'0');			
            port_dst 		<= (others=>'0');
        elsif rising_edge( phy_rx.clk ) then
            if e_rx_dv_reg='1' then
                case cnt_mac is
					when 0  => mac_dst (47 downto 40) 	<= e_rxd_reg ;
                    when 1  => mac_dst (39 downto 32) 	<= e_rxd_reg ;
                    when 2  => mac_dst (31 downto 24) 	<= e_rxd_reg ;
                    when 3  => mac_dst (23 downto 16) 	<= e_rxd_reg ;
                    when 4 	=> mac_dst (15 downto 8)  	<= e_rxd_reg ;
                    when 5 	=> mac_dst (7 downto 0)   	<= e_rxd_reg ;					                                        
					when 6  => mac_src (47 downto 40) 	<= e_rxd_reg ;
                    when 7  => mac_src (39 downto 32) 	<= e_rxd_reg ;
                    when 8  => mac_src (31 downto 24) 	<= e_rxd_reg ;
                    when 9  => mac_src (23 downto 16) 	<= e_rxd_reg ;
                    when 10 => mac_src (15 downto 8)  	<= e_rxd_reg ;
                    when 11 => mac_src (7 downto 0)   	<= e_rxd_reg ;					                                        
                    when 12 => mac_type (15 downto 8) 	<= e_rxd_reg ;
                    when 13 => mac_type (7 downto 0) 	<= e_rxd_reg ; 					
                    when 16 => ip_length (15 downto 8) 	<= e_rxd_reg ;
                    when 17 => ip_length (7 downto 0) 	<= e_rxd_reg ;
                    when 23 => ip_protocol 				<= e_rxd_reg ;					                                     
                    when 26 => ip_src (31 downto 24) 	<= e_rxd_reg ;
                    when 27 => ip_src (23 downto 16) 	<= e_rxd_reg ;
                    when 28 => ip_src (15 downto 8) 	<= e_rxd_reg ;
                    when 29 => ip_src (7 downto 0) 		<= e_rxd_reg ;
                    when 30 => ip_dst (31 downto 24) 	<= e_rxd_reg ;
                    when 31 => ip_dst (23 downto 16) 	<= e_rxd_reg ;
                    when 32 => ip_dst (15 downto 8) 	<= e_rxd_reg ;
                    when 33 => ip_dst (7 downto 0) 		<= e_rxd_reg ;					                                        
                    when 34 => port_src (15 downto 8)  	<= e_rxd_reg ;
                    when 35 => port_src (7 downto 0)  	<= e_rxd_reg ;
                    when 36 => port_dst (15 downto 8)  	<= e_rxd_reg ;
                    when 37 => port_dst (7 downto 0)  	<= e_rxd_reg ;
                    when others => null;
                end case;
            end if;
        end if;
end process;
--====================================
-- 
--====================================
process ( rst_n , phy_rx.clk )
    begin
        if rst_n = '0' then
            local_ip_s 		<= (others=>'0') ;
            local_mac_s 	<= (others=>'0') ;
        elsif rising_edge ( phy_rx.clk ) then
            local_ip_s 		<= local_net.ip ;
            local_mac_s 	<= local_net.mac ;
        end if;
end process;
process( rst_n, phy_rx.clk )
	begin
		if rst_n = '0' then
			udp_valid <= '0';
		elsif rising_edge( phy_rx.clk ) then
			if cnt_mac = 34 then
				if ( ( (ip_dst = local_ip_s) and ( mac_dst = local_mac_s ) )        --ip right and mac right 
                 or ( (ip_dst(7 downto 0) = X"ff") and ( mac_dst = local_mac_s ) )  --ip broadcast and mac right 
                 or (  mac_dst = X"ffffffffffff"  ) )                               --mac broadcast                
                and ( mac_type = Ipv4Type )                 -- ipv4
                and ( ip_protocol = UdpProtocol ) then      -- UDP    
					udp_valid <= '1';
				else
					udp_valid <= '0';
				end if;
			end if;
		end if;
end process;
process( rst_n, phy_rx.clk )
	begin
		if rst_n = '0' then
			usr_mode <= 0;
		elsif rising_edge( phy_rx.clk ) then
			if cnt_mac = 38 then
				if ( udp_valid = '1' ) then 
					if LocalEnable and RemoteEnable then 
					    if port_dst = LocalPort1 and port_src = RemotePort1 then usr_mode <= 1 ;	
					 elsif port_dst = LocalPort2 and port_src = RemotePort2 then usr_mode <= 2 ;	
					 elsif port_dst = LocalPort3 and port_src = RemotePort3 then usr_mode <= 3 ;	
					 elsif port_dst = LocalPort4 and port_src = RemotePort4 then usr_mode <= 4 ;								
					 elsif port_dst = LocalPort5 and port_src = RemotePort5 then usr_mode <= 5 ;								
					 elsif port_dst = LocalPort6 and port_src = RemotePort6 then usr_mode <= 6 ;								
					 elsif port_dst = LocalPort7 and port_src = RemotePort7 then usr_mode <= 7 ;								
					 elsif port_dst = LocalPort8 and port_src = RemotePort8 then usr_mode <= 8 ;								
				        else                                                     usr_mode <= 0 ;
						end if ;
				    elsif LocalEnable and RemoteEnable = false then 
					    if port_dst = LocalPort1  then  usr_mode <= 1 ;	
					 elsif port_dst = LocalPort2  then  usr_mode <= 2 ;	
					 elsif port_dst = LocalPort3  then  usr_mode <= 3 ;	
					 elsif port_dst = LocalPort4  then  usr_mode <= 4 ;								
					 elsif port_dst = LocalPort5  then  usr_mode <= 5 ;								
					 elsif port_dst = LocalPort6  then  usr_mode <= 6 ;								
					 elsif port_dst = LocalPort7  then  usr_mode <= 7 ;								
					 elsif port_dst = LocalPort8  then  usr_mode <= 8 ;								
				        else                            usr_mode <= 0 ;
						end if ;
				    elsif LocalEnable = false and RemoteEnable then 
					    if port_src = RemotePort1 then  usr_mode <= 1 ;	
					 elsif port_src = RemotePort2 then  usr_mode <= 2 ;	
					 elsif port_src = RemotePort3 then  usr_mode <= 3 ;	
					 elsif port_src = RemotePort4 then  usr_mode <= 4 ;								
					 elsif port_src = RemotePort5 then  usr_mode <= 5 ;								
					 elsif port_src = RemotePort6 then  usr_mode <= 6 ;								
					 elsif port_src = RemotePort7 then  usr_mode <= 7 ;								
					 elsif port_src = RemotePort8 then  usr_mode <= 8 ;								
				        else                            usr_mode <= 0 ;
						end if ;
					else                                usr_mode <= 0 ;
					end if ;
				else
					usr_mode <= 0 ;
				end if;
			end if;
		end if;
end process;

process( rst_n, phy_rx.clk )
    begin
        if rst_n = '0' then
            raw_data_length <= 0;
        elsif rising_edge( phy_rx.clk ) then
            raw_data_length <= conv_integer ( ip_length ) - 28 ; --ip length 20  udp head 8 
        end if;
end process;
process( rst_n, phy_rx.clk )
    begin
        if rst_n = '0' then
            rx_en_raw_phy <= "0";
        elsif rising_edge( phy_rx.clk ) then
			if ( usr_mode = 0 ) then
				rx_en_raw_phy <= "0";    
			elsif   cnt_mac >= 41 and cnt_mac <= 40 + raw_data_length then
                rx_en_raw_phy <= "1";
            else
                rx_en_raw_phy <= "0";
			end if;
        end if;
end process;

process( rst_n, phy_rx.clk )
    begin
        if rst_n = '0' then
            wr_addr <= (others=>'0');
        elsif rising_edge( phy_rx.clk ) then
            if rx_en_raw_phy = "1" then
                wr_addr <= wr_addr + 1;
            else
                wr_addr <= (others=>'0');
            end if;
        end if;
end process;
--====================================
-- clk domain
--====================================
udp_rx_buffer : ram_8x2048 PORT MAP (
    clka  => phy_rx.clk,
    wea   => rx_en_raw_phy,
    addra => wr_addr,
    dina  => e_rxd_reg,
    clkb  => clk,
    addrb => rd_addr,
    doutb => rx_data_raw	);        
process( rst_n , clk )
    begin
        if rst_n = '0' then
            rx_en_raw_phy_array <= (others=>'0');
            rx_en_raw_flag 		<= '0';
        elsif rising_edge( clk ) then
            rx_en_raw_phy_array <= rx_en_raw_phy_array (6 downto 0) & rx_en_raw_phy ;
			rx_en_raw_flag 		<= rx_en_raw_phy_array (6) and ( not rx_en_raw_phy_array (7) ) ;
        end if;
end process;
process(rst_n,clk)
    begin
        if rst_n='0' then
            raw_data_length_domain1 <= 0 ;
        elsif rising_edge( clk ) then
            raw_data_length_domain1 <= raw_data_length ;
        end if;
end process;
process( rst_n, clk )
    begin
        if rst_n = '0' then
            rx_en_raw_reg <= '0';
        elsif rising_edge( clk ) then
            if rx_en_raw_flag = '1' then
                rx_en_raw_reg <= '1';
            elsif conv_integer ( rd_addr ) >= raw_data_length_domain1 - 1 then
                rx_en_raw_reg <= '0';
            end if;
        end if;
end process;
process( rst_n, clk )
    begin
        if rst_n = '0' then
            rd_addr <= (others=>'0');
        elsif rising_edge( clk ) then
            if rx_en_raw_reg = '1' then
                rd_addr <= rd_addr + 1;
            else
                rd_addr <= (others=>'0');
            end if;
        end if;
end process;    
process( rst_n, clk )
    begin
        if rst_n = '0' then
            rx_en_raw_reg1 <= '0';
            rx_en_raw_reg2 <= '0';
            rx_en_raw_reg3 <= '0';
        elsif rising_edge( clk ) then
            rx_en_raw_reg1 <= rx_en_raw_reg ;
            rx_en_raw_reg2 <= rx_en_raw_reg1 ;
            rx_en_raw_reg3 <= rx_en_raw_reg2 ;
        end if;
end process;
-- output 
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr_mode_reg <=  0 ;
        elsif rising_edge ( clk ) then
            usr_mode_reg <= usr_mode ;          
        end if;
end process;

process ( rst_n , clk )
    begin
        if rst_n = '0' then
            mac_src_reg   	<= (others=>'0') ;
			ip_src_reg    	<= (others=>'0') ;
			port_src_reg  	<= (others=>'0') ;
        elsif rising_edge ( clk ) then
            mac_src_reg   	<= mac_src  ;
			ip_src_reg    	<= ip_src  ;
			port_src_reg  	<= port_src ;            
        end if;
end process;
-- usr1 rx  
usr1_rx.data    			<= rx_data_raw        when usr_mode_reg = 1 else (others=>'0') ;
usr1_rx.dv    				<= rx_en_raw_reg2     when usr_mode_reg = 1 else '0';
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr1_rx.remote_port <= (others=>'0') ;
            usr1_rx.remote_mac <= (others=>'0') ;
            usr1_rx.remote_ip <= (others=>'0') ;
        elsif rising_edge ( clk ) then
            if ( usr_mode_reg = 1 ) then
                if ( conv_integer ( rd_addr ) = 1 ) then
                    usr1_rx.remote_port       	<= port_src_reg  ;
                    usr1_rx.remote_mac       	<= mac_src_reg  ;
                    usr1_rx.remote_ip       	<= ip_src_reg  ;
                end if; 
            end if;
        end if;
end process;
-- usr2 rx 
usr2_rx.data    		    <= rx_data_raw        when usr_mode_reg = 2 else (others=>'0') ;
usr2_rx.dv    		        <= rx_en_raw_reg2     when usr_mode_reg = 2 else '0';
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr2_rx.remote_port <= (others=>'0') ;
            usr2_rx.remote_mac <= (others=>'0') ;
            usr2_rx.remote_ip <= (others=>'0') ;
        elsif rising_edge ( clk ) then
            if ( usr_mode_reg = 2 ) then
                if ( conv_integer ( rd_addr ) = 1 ) then
                    usr2_rx.remote_port       	<= port_src_reg  ;
                    usr2_rx.remote_mac       	<= mac_src_reg  ;
                    usr2_rx.remote_ip       	<= ip_src_reg  ;
                end if; 
            end if;
        end if;
end process;
-- usr3 rx 
usr3_rx.data    		    <= rx_data_raw        when usr_mode_reg = 3 else (others=>'0') ;
usr3_rx.dv    		        <= rx_en_raw_reg2     when usr_mode_reg = 3 else '0';
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr3_rx.remote_port <= (others=>'0') ;
            usr3_rx.remote_mac <= (others=>'0') ;
            usr3_rx.remote_ip <= (others=>'0') ;
        elsif rising_edge ( clk ) then
            if ( usr_mode_reg = 3 ) then
                if ( conv_integer ( rd_addr ) = 1 ) then
                    usr3_rx.remote_port       	<= port_src_reg  ;
                    usr3_rx.remote_mac       	<= mac_src_reg  ;
                    usr3_rx.remote_ip       	<= ip_src_reg  ;
                end if; 
            end if;
        end if;
end process;
-- usr4 rx 
usr4_rx.data    		    <= rx_data_raw        when usr_mode_reg = 4 else (others=>'0') ;
usr4_rx.dv    		        <= rx_en_raw_reg2     when usr_mode_reg = 4 else '0';  
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr4_rx.remote_port <= (others=>'0') ;
            usr4_rx.remote_mac <= (others=>'0') ;
            usr4_rx.remote_ip <= (others=>'0') ;
        elsif rising_edge ( clk ) then
            if ( usr_mode_reg = 4 ) then
                if ( conv_integer ( rd_addr ) = 1 ) then
                    usr4_rx.remote_port       	<= port_src_reg  ;
                    usr4_rx.remote_mac       	<= mac_src_reg  ;
                    usr4_rx.remote_ip       	<= ip_src_reg  ;
                end if; 
            end if;
        end if;
end process;
--====================================
-- clk1 domain
--====================================
udp_rx_buffer2 :  ram_8x2048
PORT MAP (
    clka  => phy_rx.clk,
    wea   => rx_en_raw_phy,
    addra => wr_addr,
    dina  => e_rxd_reg,
    clkb  => clk1,
    addrb => rd_addr_domain2,
    doutb => rx_data_raw_domain2	);        
process( rst_n , clk1 )
    begin
        if rst_n = '0' then
            rx_en_raw_phy_array_domain2 <= (others=>'0');
            rx_en_raw_flag_domain2 		<= '0';
        elsif rising_edge( clk1 ) then
            rx_en_raw_phy_array_domain2 <= rx_en_raw_phy_array_domain2 (6 downto 0) & rx_en_raw_phy  ;
			rx_en_raw_flag_domain2 		<= rx_en_raw_phy_array_domain2 (6) and ( not rx_en_raw_phy_array_domain2 (7) ) ;
        end if;
end process;
process(rst_n,clk1)
    begin
        if rst_n='0' then
            raw_data_length_domain2 <= 0 ;
        elsif rising_edge( clk1 ) then
            raw_data_length_domain2 <= raw_data_length ;
        end if;
end process;
process( rst_n, clk1 )
    begin
        if rst_n = '0' then
            rx_en_raw_domain2_reg <= '0';
        elsif rising_edge( clk1 ) then
            if rx_en_raw_flag_domain2 = '1' then
                rx_en_raw_domain2_reg <= '1';
            elsif conv_integer( rd_addr_domain2 ) >= raw_data_length_domain2 - 1 then
                rx_en_raw_domain2_reg <= '0';
            end if;
        end if;
end process;
process( rst_n, clk1 )
    begin
        if rst_n = '0' then
            rd_addr_domain2 <= (others=>'0');
        elsif rising_edge( clk1 ) then
            if rx_en_raw_domain2_reg = '1' then
                rd_addr_domain2 <= rd_addr_domain2 + 1;
            else
                rd_addr_domain2 <= (others=>'0');
            end if;
        end if;
end process;    
process( rst_n, clk1 )
    begin
        if rst_n = '0' then
            rx_en_raw_domain2_reg1 <= '0';
            rx_en_raw_domain2_reg2 <= '0';
            rx_en_raw_domain2_reg3 <= '0';
        elsif rising_edge( clk1 ) then
            rx_en_raw_domain2_reg1 <= rx_en_raw_domain2_reg ;
            rx_en_raw_domain2_reg2 <= rx_en_raw_domain2_reg1 ;
            rx_en_raw_domain2_reg3 <= rx_en_raw_domain2_reg2 ;
        end if;
end process;
-- output 
process ( rst_n , clk1 )
    begin
        if rst_n = '0' then
            usr_mode_reg_domain2 <=  0 ;
        elsif rising_edge ( clk1 ) then
            usr_mode_reg_domain2 <= usr_mode ;          
        end if;
end process;
process ( rst_n , clk1 )
    begin
        if rst_n = '0' then
            mac_src_domain2_reg   	<= (others=>'0') ;
			ip_src_domain2_reg    	<= (others=>'0') ;
			port_src_domain2_reg  	<= (others=>'0') ;
        elsif rising_edge ( clk1 ) then
            mac_src_domain2_reg   	<= mac_src  ;
			ip_src_domain2_reg    	<= ip_src  ;
			port_src_domain2_reg  	<= port_src ;            
        end if;
end process;
-- usr5 rx 
usr5_rx.data    			<= rx_data_raw_domain2        when usr_mode_reg_domain2 = 5 else (others=>'0') ;
usr5_rx.dv    				<= rx_en_raw_domain2_reg2     when usr_mode_reg_domain2 = 5 else '0';  
process ( rst_n , clk1 )
    begin
        if rst_n = '0' then
            usr5_rx.remote_port <= (others=>'0') ;
            usr5_rx.remote_mac <= (others=>'0') ;
            usr5_rx.remote_ip <= (others=>'0') ;
        elsif rising_edge ( clk1 ) then
            if ( usr_mode_reg = 5 ) then
                if ( conv_integer ( rd_addr ) = 1 ) then
                    usr5_rx.remote_port       	<= port_src_domain2_reg  ;
                    usr5_rx.remote_mac       	<= mac_src_domain2_reg  ;
                    usr5_rx.remote_ip       	<= ip_src_domain2_reg  ;
                end if; 
            end if;
        end if;
end process; 
-- usr6 rx 
usr6_rx.data    			<= rx_data_raw_domain2        when usr_mode_reg_domain2 = 6 else (others=>'0') ;
usr6_rx.dv    				<= rx_en_raw_domain2_reg2     when usr_mode_reg_domain2 = 6 else '0';  
process ( rst_n , clk1 )
    begin
        if rst_n = '0' then
            usr6_rx.remote_port <= (others=>'0') ;
            usr6_rx.remote_mac <= (others=>'0') ;
            usr6_rx.remote_ip <= (others=>'0') ;
        elsif rising_edge ( clk1 ) then
            if ( usr_mode_reg = 6 ) then
                if ( conv_integer ( rd_addr ) = 1 ) then
                    usr6_rx.remote_port       	<= port_src_domain2_reg  ;
                    usr6_rx.remote_mac       	<= mac_src_domain2_reg  ;
                    usr6_rx.remote_ip       	<= ip_src_domain2_reg  ;
                end if; 
            end if;
        end if;
end process; 
-- usr7 rx 
usr7_rx.data    			<= rx_data_raw_domain2        when usr_mode_reg_domain2 = 7 else (others=>'0') ;
usr7_rx.dv    				<= rx_en_raw_domain2_reg2     when usr_mode_reg_domain2 = 7 else '0';  

process ( rst_n , clk1 )
    begin
        if rst_n = '0' then
            usr7_rx.remote_port <= (others=>'0') ;
            usr7_rx.remote_mac <= (others=>'0') ;
            usr7_rx.remote_ip <= (others=>'0') ;
        elsif rising_edge ( clk1 ) then
            if ( usr_mode_reg = 7 ) then
                if ( conv_integer ( rd_addr ) = 1 ) then
                    usr7_rx.remote_port       	<= port_src_domain2_reg  ;
                    usr7_rx.remote_mac       	<= mac_src_domain2_reg  ;
                    usr7_rx.remote_ip       	<= ip_src_domain2_reg  ;
                end if; 
            end if;
        end if;
end process;  
-- usr8 rx 
usr8_rx.data    			<= rx_data_raw_domain2        when usr_mode_reg_domain2 = 8 else (others=>'0') ;
usr8_rx.dv    				<= rx_en_raw_domain2_reg2     when usr_mode_reg_domain2 = 8 else '0'; 

process ( rst_n , clk1 )
    begin
        if rst_n = '0' then
            usr8_rx.remote_port <= (others=>'0') ;
            usr8_rx.remote_mac <= (others=>'0') ;
            usr8_rx.remote_ip <= (others=>'0') ;
        elsif rising_edge ( clk1 ) then
            if ( usr_mode_reg = 8 ) then
                if ( conv_integer ( rd_addr ) = 1 ) then
                    usr8_rx.remote_port       	<= port_src_domain2_reg  ;
                    usr8_rx.remote_mac       	<= mac_src_domain2_reg  ;
                    usr8_rx.remote_ip       	<= ip_src_domain2_reg  ;
                end if; 
            end if;
        end if;
end process;    		 
end rtl;