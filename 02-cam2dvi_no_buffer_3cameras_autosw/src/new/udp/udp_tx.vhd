library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.src_lib.all;
use work.mt_lib.all;
entity udp_tx is
    port (
        clk               	            : in std_logic ; 
        rst_n               	        : in std_logic ; 

        phy_tx_clk                      : in std_logic ; 
        phy_tx_rst_n                    : in std_logic ;

		local_net 						: in net_type ;	
		usr1_tx_q						: in usr_tx_q ;	
		usr1_tx_p						: buffer usr_tx_p ;
		usr2_tx_q						: in usr_tx_q ;	
		usr2_tx_p						: buffer usr_tx_p ;
		usr3_tx_q						: in usr_tx_q ;	
		usr3_tx_p						: buffer usr_tx_p ;
		usr4_tx_q						: in usr_tx_q ;	
		usr4_tx_p						: buffer usr_tx_p ;
		usr5_tx_q						: in usr_tx_q ;		
		usr5_tx_p						: buffer usr_tx_p ;
		usr6_tx_q						: in usr_tx_q ;	
		usr6_tx_p						: buffer usr_tx_p ;
		usr7_tx_q						: in usr_tx_q ;	
		usr7_tx_p						: buffer usr_tx_p ;
		usr8_tx_q						: in usr_tx_q ;	
		usr8_tx_p						: buffer usr_tx_p ;
		udp_tx_ack			            : buffer udp_tx_ack ;
		-- to mac tx	
		udp_tx_q						: buffer mac_tx_q ;		
		udp_tx_p						: in mac_tx_p ;			
		mac_tx_ack						: in mac_tx_ack  );
end udp_tx;
architecture rtl of udp_tx is
COMPONENT ram_2p_2c_8x2048 PORT (
    clka  : IN STD_LOGIC;
    wea   : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    dina  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb  : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) );
END COMPONENT; 
constant IDLE         			: std_logic_vector(7 downto 0) := X"01" ;
constant USR1_FM_FALSE         	: std_logic_vector(7 downto 0) := X"02" ;
constant USR1_FM_TRUE         	: std_logic_vector(7 downto 0) := X"03" ;
constant USR1_WAIT_0        	: std_logic_vector(7 downto 0) := X"04" ;
constant USR1_WAIT_1         	: std_logic_vector(7 downto 0) := X"05" ;
constant USR1_DATA         		: std_logic_vector(7 downto 0) := X"06" ; 
constant USR2_FM_FALSE         	: std_logic_vector(7 downto 0) := X"07" ;
constant USR2_FM_TRUE         	: std_logic_vector(7 downto 0) := X"08" ;
constant USR2_WAIT_0        	: std_logic_vector(7 downto 0) := X"09" ;
constant USR2_WAIT_1         	: std_logic_vector(7 downto 0) := X"0A" ;
constant USR2_DATA         		: std_logic_vector(7 downto 0) := X"0B" ;
constant USR3_FM_FALSE         	: std_logic_vector(7 downto 0) := X"0C" ;
constant USR3_FM_TRUE         	: std_logic_vector(7 downto 0) := X"0D" ;
constant USR3_WAIT_0        	: std_logic_vector(7 downto 0) := X"0E" ;
constant USR3_WAIT_1         	: std_logic_vector(7 downto 0) := X"0F" ;
constant USR3_DATA         		: std_logic_vector(7 downto 0) := X"11" ; 
constant USR4_FM_FALSE         	: std_logic_vector(7 downto 0) := X"12" ;
constant USR4_FM_TRUE         	: std_logic_vector(7 downto 0) := X"13" ;
constant USR4_WAIT_0        	: std_logic_vector(7 downto 0) := X"14" ;
constant USR4_WAIT_1         	: std_logic_vector(7 downto 0) := X"15" ;
constant USR4_DATA         		: std_logic_vector(7 downto 0) := X"16" ; 
constant USR5_FM_FALSE         	: std_logic_vector(7 downto 0) := X"17" ;
constant USR5_FM_TRUE         	: std_logic_vector(7 downto 0) := X"18" ;
constant USR5_WAIT_0        	: std_logic_vector(7 downto 0) := X"19" ;
constant USR5_WAIT_1         	: std_logic_vector(7 downto 0) := X"1A" ;
constant USR5_DATA         		: std_logic_vector(7 downto 0) := X"1B" ;  
constant USR6_FM_FALSE         	: std_logic_vector(7 downto 0) := X"1C" ;
constant USR6_FM_TRUE         	: std_logic_vector(7 downto 0) := X"1D" ;
constant USR6_WAIT_0        	: std_logic_vector(7 downto 0) := X"1E" ;
constant USR6_WAIT_1         	: std_logic_vector(7 downto 0) := X"1F" ;
constant USR6_DATA         		: std_logic_vector(7 downto 0) := X"21" ; 
constant USR7_FM_FALSE         	: std_logic_vector(7 downto 0) := X"22" ;
constant USR7_FM_TRUE         	: std_logic_vector(7 downto 0) := X"23" ;
constant USR7_WAIT_0        	: std_logic_vector(7 downto 0) := X"24" ;
constant USR7_WAIT_1         	: std_logic_vector(7 downto 0) := X"25" ;
constant USR7_DATA         		: std_logic_vector(7 downto 0) := X"26" ;
constant USR8_FM_FALSE         	: std_logic_vector(7 downto 0) := X"27" ;
constant USR8_FM_TRUE         	: std_logic_vector(7 downto 0) := X"28" ;
constant USR8_WAIT_0        	: std_logic_vector(7 downto 0) := X"29" ;
constant USR8_WAIT_1         	: std_logic_vector(7 downto 0) := X"2a" ;
constant USR8_DATA         		: std_logic_vector(7 downto 0) := X"2b" ;  
constant SEND_UDP_END         	: std_logic_vector(7 downto 0) := X"2c" ;  
signal   cs                     : std_logic_vector(7 downto 0) := IDLE;
signal   ns                     : std_logic_vector(7 downto 0) := IDLE;
 
signal udp_send_cnt 		 : integer range 0 to 2047 ;
signal usr1_tx_req_reg1 	 : std_logic;
signal usr1_tx_req_reg2 	 : std_logic;
signal usr2_tx_req_reg1 	 : std_logic;
signal usr2_tx_req_reg2 	 : std_logic;
signal usr3_tx_req_reg1 	 : std_logic;
signal usr3_tx_req_reg2 	 : std_logic;
signal usr4_tx_req_reg1 	 : std_logic;
signal usr4_tx_req_reg2 	 : std_logic;
signal usr5_tx_req_reg1 	 : std_logic;
signal usr5_tx_req_reg2 	 : std_logic;
signal usr6_tx_req_reg1 	 : std_logic;
signal usr6_tx_req_reg2 	 : std_logic;
signal usr7_tx_req_reg1 	 : std_logic;
signal usr7_tx_req_reg2 	 : std_logic;
signal usr8_tx_req_reg1 	 : std_logic;
signal usr8_tx_req_reg2 	 : std_logic;
signal fragment_length_reg 	 : std_logic_vector(15 downto 0);
signal usr1_fragment_en_s	 : std_logic;
signal usr1_fragment_en_reg1 : std_logic;
signal usr1_fragment_en_reg2 : std_logic;
signal usr1_fragment_en_fall : std_logic;	
signal usr2_fragment_en_s	 : std_logic;
signal usr2_fragment_en_reg1 : std_logic;
signal usr2_fragment_en_reg2 : std_logic;
signal usr2_fragment_en_fall : std_logic;
signal usr3_fragment_en_s	 : std_logic;
signal usr3_fragment_en_reg1 : std_logic;
signal usr3_fragment_en_reg2 : std_logic;
signal usr3_fragment_en_fall : std_logic;		
signal usr4_fragment_en_s	 : std_logic;
signal usr4_fragment_en_reg1 : std_logic;
signal usr4_fragment_en_reg2 : std_logic;
signal usr4_fragment_en_fall : std_logic;
signal usr5_fragment_en_s    : std_logic;
signal usr5_fragment_en_reg1 : std_logic;
signal usr5_fragment_en_reg2 : std_logic;
signal usr5_fragment_en_fall : std_logic;
signal usr6_fragment_en_s    : std_logic;
signal usr6_fragment_en_reg1 : std_logic;
signal usr6_fragment_en_reg2 : std_logic;
signal usr6_fragment_en_fall : std_logic;
signal usr7_fragment_en_s    : std_logic;
signal usr7_fragment_en_reg1 : std_logic;
signal usr7_fragment_en_reg2 : std_logic;
signal usr7_fragment_en_fall : std_logic;
signal usr8_fragment_en_s    : std_logic;
signal usr8_fragment_en_reg1 : std_logic;
signal usr8_fragment_en_reg2 : std_logic;
signal usr8_fragment_en_fall : std_logic;
signal udp_data_req_0        : std_logic;
signal udp_tx_ack_reg        : std_logic;
signal usr1_tx_ready_reg     : std_logic;
signal usr2_tx_ready_reg     : std_logic;
signal usr3_tx_ready_reg     : std_logic;
signal usr4_tx_ready_reg     : std_logic;
signal usr5_tx_ready_reg     : std_logic;
signal usr6_tx_ready_reg     : std_logic;
signal usr7_tx_ready_reg     : std_logic;
signal usr8_tx_ready_reg     : std_logic;
signal ram_wr_addr           : std_logic_vector(10 downto 0);
signal ram_rd_addr           : std_logic_vector(10 downto 0);
signal ram_wr_data           : std_logic_vector( 7 downto 0);
signal ram_rd_data           : std_logic_vector( 7 downto 0);
signal ram_wr_en             : std_logic;
signal ip_id                 : std_logic_vector(15 downto 0);
signal ip_id_reg             : std_logic_vector(15 downto 0);
signal ip_length_reg         : std_logic_vector(15 downto 0);
signal ip_length             : std_logic_vector(15 downto 0);
signal ip_checksum           : std_logic_vector(15 downto 0);
signal ip_checksum_sub1      : std_logic_vector(31 downto 0);
signal ip_checksum_sub2      : std_logic_vector(31 downto 0);
signal ip_checksum_reg       : std_logic_vector(31 downto 0);
signal ip_checksum_reg2      : std_logic_vector(31 downto 0);
signal remote_ip             : std_logic_vector(31 downto 0);
signal remote_ip_reg         : std_logic_vector(31 downto 0);
signal local_ip_reg          : std_logic_vector(31 downto 0);
signal remote_mac            : std_logic_vector(47 downto 0);
signal timeout               : std_logic_vector(15 downto 0);
signal ip_send_length        : std_logic_vector(15 downto 0);
signal ip_send_length_reg    : std_logic_vector(15 downto 0);
signal sm_state              : std_logic_vector(7 downto 0);
signal udp_tx_end_reg        : std_logic;
signal udp_tx_end_reg1       : std_logic;
signal usr1_fragment_valid   : std_logic;
signal usr2_fragment_valid   : std_logic;
signal usr3_fragment_valid   : std_logic;
signal usr4_fragment_valid   : std_logic;
signal usr5_fragment_valid   : std_logic;
signal usr6_fragment_valid   : std_logic;
signal usr7_fragment_valid   : std_logic;
signal usr8_fragment_valid   : std_logic;
signal fragment_valid_reg    : std_logic;
signal fragment_valid        : std_logic;
signal flags                 : std_logic_vector(2 downto 0);
signal flags_reg             : std_logic_vector(2 downto 0);
signal flagment_offset       : std_logic_vector(15 downto 0);
signal flagment_offset_reg   : std_logic_vector(15 downto 0);
signal flagment_cnt          : std_logic_vector(7 downto 0);
signal tx_data_length_reg    : std_logic_vector(15 downto 0);
signal usr_fragment_length   : std_logic_vector(15 downto 0);
signal udp_tx_q_en           : std_logic;
signal udp_tx_q_data         : std_logic_vector(7 downto 0);

--***************************************************************
-- debug
--***************************************************************
constant ILA_LENTH                  : integer := 256 ;
component ila_256 port (
    clk                             : in std_logic;
    probe0                          : in std_logic_vector( ILA_LENTH -1 downto 0) );
end component;   

begin
--====================================
-- sm
--====================================
process( phy_tx_rst_n, phy_tx_clk ) 
    begin
        if phy_tx_rst_n = '0' then 
            cs <= IDLE ;
        elsif rising_edge( phy_tx_clk ) then
            cs <= ns ;
        end if;
end process;
process( cs , 
 usr1_fragment_en_reg2,usr1_fragment_valid,usr1_tx_req_reg2  ,
 usr2_fragment_en_reg2,usr2_fragment_valid,usr2_tx_req_reg2  ,
 usr3_fragment_en_reg2,usr3_fragment_valid,usr3_tx_req_reg2  ,
 usr4_fragment_en_reg2,usr4_fragment_valid,usr4_tx_req_reg2  ,
 usr5_fragment_en_reg2,usr5_fragment_valid,usr5_tx_req_reg2  ,
 usr6_fragment_en_reg2,usr6_fragment_valid,usr6_tx_req_reg2  ,
 usr7_fragment_en_reg2,usr7_fragment_valid,usr7_tx_req_reg2  ,
 usr8_fragment_en_reg2,usr8_fragment_valid,usr8_tx_req_reg2  ,
 udp_tx_p.ack,ip_send_length_reg,udp_send_cnt,mac_tx_ack.data_req,udp_tx_ack.tx_end,mac_tx_ack.mac_end,timeout )
    begin    
        case cs is     
            when IDLE =>                        if usr1_fragment_valid = '1' then 
			                                        if  ( usr1_tx_req_reg2 = '1' ) then 
												    	if ( usr1_fragment_en_reg2 = '0' ) then
												    	    ns <= USR1_FM_FALSE ;  
												    	else
												    	    ns <= USR1_FM_TRUE ;  
												    	end if;	
													else 
														ns <= IDLE ; 
													end if ;
												elsif usr2_fragment_valid = '1' then 		
			                                        if ( usr2_tx_req_reg2 = '1' ) then 
												    	if ( usr2_fragment_en_reg2 = '0' ) then
												    	    ns <= USR2_FM_FALSE ;  
												    	else
												    	    ns <= USR2_FM_TRUE ;  
												    	end if;	
													else 
														ns <= IDLE ; 
													end if ;
												elsif usr3_fragment_valid = '1' then 
				                                    if ( usr3_tx_req_reg2 = '1' ) then 
												    	if ( usr3_fragment_en_reg2 = '0' ) then
												    	    ns <= USR3_FM_FALSE ;  
												    	else
												    	    ns <= USR3_FM_TRUE ;  
												    	end if;	
													else 
														ns <= IDLE ; 
													end if ;
												elsif usr4_fragment_valid = '1' then 
				                                    if ( usr4_tx_req_reg2 = '1' ) then 
												        if ( usr4_fragment_en_reg2 = '0' ) then
												    	    ns <= USR4_FM_FALSE ;  
												    	else
												    	    ns <= USR4_FM_TRUE ;  
												    	end if;	
													else 
														ns <= IDLE ; 
													end if ;
												elsif usr5_fragment_valid = '1' then 
				                                    if ( usr5_tx_req_reg2 = '1' ) then 
												        if ( usr5_fragment_en_reg2 = '0' ) then
												    	    ns <= USR5_FM_FALSE ;  
												    	else
												    	    ns <= USR5_FM_TRUE ;  
												    	end if;	
													else 
														ns <= IDLE ; 
													end if ;
												elsif usr6_fragment_valid = '1' then 
				                                    if ( usr6_tx_req_reg2 = '1' ) then 
												        if ( usr6_fragment_en_reg2 = '0' ) then
												    	    ns <= USR6_FM_FALSE ;  
												    	else
												    	    ns <= USR6_FM_TRUE ;  
												    	end if;	
													else 
														ns <= IDLE ; 
													end if ;
												elsif usr7_fragment_valid = '1' then 
				                                    if ( usr7_tx_req_reg2 = '1' ) then 
												        if ( usr7_fragment_en_reg2 = '0' ) then
												    	    ns <= USR7_FM_FALSE ;  
												    	else
												    	    ns <= USR7_FM_TRUE ;  
												    	end if;	
													else 
														ns <= IDLE ; 
													end if ;
												elsif usr8_fragment_valid = '1' then 
				                                    if ( usr8_tx_req_reg2 = '1' ) then 
												        if ( usr8_fragment_en_reg2 = '0' ) then
												    	    ns <= USR8_FM_FALSE ;  
												    	else
												    	    ns <= USR8_FM_TRUE ;  
												    	end if;	
													else 
														ns <= IDLE ; 
													end if ;													
				                                elsif  ( usr1_tx_req_reg2 = '1' ) then 
												    if ( usr1_fragment_en_reg2 = '0' ) then
												        ns <= USR1_FM_FALSE ;  
												    else
												        ns <= USR1_FM_TRUE ;  
												    end if;	
												elsif ( usr2_tx_req_reg2 = '1' ) then 
												    if ( usr2_fragment_en_reg2 = '0' ) then
												        ns <= USR2_FM_FALSE ;  
												    else
												        ns <= USR2_FM_TRUE ;  
												    end if;	
												elsif ( usr3_tx_req_reg2 = '1' ) then 
												    if ( usr3_fragment_en_reg2 = '0' ) then
												        ns <= USR3_FM_FALSE ;  
												    else
												        ns <= USR3_FM_TRUE ;  
												    end if;	
												elsif ( usr4_tx_req_reg2 = '1' ) then 
												    if ( usr4_fragment_en_reg2 = '0' ) then
												        ns <= USR4_FM_FALSE ;  
												    else
												        ns <= USR4_FM_TRUE ;  
												    end if;	
												elsif ( usr5_tx_req_reg2 = '1' ) then 
												    if ( usr5_fragment_en_reg2 = '0' ) then
												        ns <= USR5_FM_FALSE ;  
												    else
												        ns <= USR5_FM_TRUE ;  
												    end if;	
												elsif ( usr6_tx_req_reg2 = '1' ) then 
												    if ( usr6_fragment_en_reg2 = '0' ) then
												        ns <= USR6_FM_FALSE ;  
												    else
												        ns <= USR6_FM_TRUE ;  
												    end if;	
												elsif ( usr7_tx_req_reg2 = '1' ) then 
												    if ( usr7_fragment_en_reg2 = '0' ) then
												        ns <= USR7_FM_FALSE ;  
												    else
												        ns <= USR7_FM_TRUE ;  
												    end if;	
												elsif ( usr8_tx_req_reg2 = '1' ) then 
												    if ( usr8_fragment_en_reg2 = '0' ) then
												        ns <= USR8_FM_FALSE ;  
												    else
												        ns <= USR8_FM_TRUE ;  
												    end if;														
												else 
													ns <= IDLE ;           
												end if; 
			when USR1_FM_FALSE =>                   ns <= USR1_WAIT_0 ;     
			when USR1_FM_TRUE =>                    ns <= USR1_WAIT_0 ;     
			when USR1_WAIT_0 =>                 if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( udp_tx_p.ack = '1' ) then 
													ns <= USR1_WAIT_1 ;
				                                else                                  
													ns <= USR1_WAIT_0  ; 
												end if;
			when USR1_WAIT_1 =>                 if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( mac_tx_ack.data_req = '1' )then 
													ns <= USR1_DATA ;
				                                else                                  
													ns <= USR1_WAIT_1  ; 
												end if;
			when USR1_DATA =>                   if (  udp_send_cnt = conv_integer( ip_send_length_reg ) + 21 ) then 
													ns <= SEND_UDP_END  ;
				                                elsif ( timeout = X"ffff" )then 
													ns <= IDLE ;
				                                else                                  
												    ns <= USR1_DATA  ;    
												end if;
			when USR2_FM_FALSE =>                   ns <= USR2_WAIT_0 ;     
			when USR2_FM_TRUE =>                    ns <= USR2_WAIT_0 ;  												
			when USR2_WAIT_0 =>                 if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( udp_tx_p.ack = '1' ) then 
													ns <= USR2_WAIT_1 ;
				                                else                                  
													ns <= USR2_WAIT_0  ; 
												end if;
			when USR2_WAIT_1 =>                 if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( mac_tx_ack.data_req = '1' ) then 
													ns <= USR2_DATA ;
				                                else                                  
													ns <= USR2_WAIT_1  ; 
												end if;
			when USR2_DATA =>                   if (  udp_send_cnt = conv_integer( ip_send_length_reg ) + 21 ) then 
													ns <= SEND_UDP_END  ;
				                                elsif ( timeout = X"ffff" )then 
													ns <= IDLE ;
											    else                                  
													ns <= USR2_DATA  ;    
												end if;
			when USR3_FM_FALSE =>                   ns <= USR3_WAIT_0 ;     
			when USR3_FM_TRUE =>                    ns <= USR3_WAIT_0 ;												
			when USR3_WAIT_0 =>                 if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( udp_tx_p.ack = '1' )then 
													ns <= USR3_WAIT_1 ;
				                                else                                  
													ns <= USR3_WAIT_0  ; 
												end if;
			when USR3_WAIT_1 =>                 if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( mac_tx_ack.data_req = '1' )then 
													ns <= USR3_DATA ;
				                                else                                  
													ns <= USR3_WAIT_1  ; 
												end if;
			when USR3_DATA =>                   if (  udp_send_cnt = conv_integer( ip_send_length_reg ) + 21 ) then 
													ns <= SEND_UDP_END  ;
				                                elsif ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                else                                  
													ns <= USR3_DATA  ;    
												end if;
			when USR4_FM_FALSE =>                   ns <= USR4_WAIT_0 ;     
			when USR4_FM_TRUE =>                    ns <= USR4_WAIT_0 ;												
			when USR4_WAIT_0 =>                 if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( udp_tx_p.ack = '1' )then 
													ns <= USR4_WAIT_1 ;
				                                else                                  
													ns <= USR4_WAIT_0  ; 
												end if;
			when USR4_WAIT_1 =>                 if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( mac_tx_ack.data_req = '1')then 
													ns <= USR4_DATA ;
				                                else                                  
													ns <= USR4_WAIT_1  ; 
												end if;
			when USR4_DATA =>                   if ( udp_send_cnt = conv_integer( ip_send_length_reg ) + 21 ) then 
													ns <= SEND_UDP_END  ;
				                                elsif ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                else                                  
													ns <= USR4_DATA  ;    
												end if;	
			when USR5_FM_FALSE =>                   ns <= USR5_WAIT_0 ;     
			when USR5_FM_TRUE =>                    ns <= USR5_WAIT_0 ;												
			when USR5_WAIT_0 =>                 if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( udp_tx_p.ack = '1' )then 
													ns <= USR5_WAIT_1 ;
				                                else                                  
													ns <= USR5_WAIT_0  ; 
												end if;
			when USR5_WAIT_1 =>                 if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( mac_tx_ack.data_req = '1')then 
													ns <= USR5_DATA ;
				                                else                                  
													ns <= USR5_WAIT_1  ; 
												end if;
			when USR5_DATA =>                   if ( udp_send_cnt = conv_integer( ip_send_length_reg ) + 21 ) then 
													ns <= SEND_UDP_END  ;
				                                elsif ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                else                                  
													ns <= USR5_DATA  ;    
												end if;	
			when USR6_FM_FALSE =>                   ns <= USR6_WAIT_0 ;     
			when USR6_FM_TRUE =>                    ns <= USR6_WAIT_0 ;												
			when USR6_WAIT_0 =>                 if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( udp_tx_p.ack = '1' )then 
													ns <= USR6_WAIT_1 ;
				                                else                                  
													ns <= USR6_WAIT_0  ; 
												end if;
			when USR6_WAIT_1 =>                 if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( mac_tx_ack.data_req = '1')then 
													ns <= USR6_DATA ;
				                                else                                  
													ns <= USR6_WAIT_1  ; 
												end if;
			when USR6_DATA =>                   if ( udp_send_cnt = conv_integer( ip_send_length_reg ) + 21 ) then 
													ns <= SEND_UDP_END  ;
				                                elsif ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                else                                  
													ns <= USR6_DATA  ;    
												end if;	
			when USR7_FM_FALSE =>                   ns <= USR7_WAIT_0 ;     
			when USR7_FM_TRUE =>                    ns <= USR7_WAIT_0 ;												
			when USR7_WAIT_0 =>                 if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( udp_tx_p.ack = '1' )then 
													ns <= USR7_WAIT_1 ;
				                                else                                  
													ns <= USR7_WAIT_0  ; 
												end if;
			when USR7_WAIT_1 =>                 if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( mac_tx_ack.data_req = '1')then 
													ns <= USR7_DATA ;
				                                else                                  
													ns <= USR7_WAIT_1  ; 
												end if;
			when USR7_DATA =>                   if ( udp_send_cnt = conv_integer( ip_send_length_reg ) + 21 ) then 
													ns <= SEND_UDP_END  ;
				                                elsif ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                else                                  
													ns <= USR7_DATA  ;    
												end if;	
			when USR8_FM_FALSE =>                   ns <= USR8_WAIT_0 ;     
			when USR8_FM_TRUE =>                    ns <= USR8_WAIT_0 ;												
			when USR8_WAIT_0 =>                 if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( udp_tx_p.ack = '1' )then 
													ns <= USR8_WAIT_1 ;
				                                else                                  
													ns <= USR8_WAIT_0  ; 
												end if;
			when USR8_WAIT_1 =>                 if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( mac_tx_ack.data_req = '1')then 
													ns <= USR8_DATA ;
				                                else                                  
													ns <= USR8_WAIT_1  ; 
												end if;
			when USR8_DATA =>                   if ( udp_send_cnt = conv_integer( ip_send_length_reg ) + 21 ) then 
													ns <= SEND_UDP_END  ;
				                                elsif ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                else                                  
													ns <= USR8_DATA  ;    
												end if;													
			when SEND_UDP_END =>                if ( timeout = X"ffff")then 
													ns <= IDLE ;
				                                elsif ( mac_tx_ack.mac_end = '1' ) then        
													ns <= IDLE  ;
				                                else                                  
													ns <= SEND_UDP_END  ;      
												end if;
			when others   =>                        ns <= IDLE  ;
        end case;
end process;
--====================================
-- fragment crossdomain
--====================================
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
			usr1_fragment_en_reg1  <= '0';  usr1_fragment_en_reg2 <= '0';  usr1_fragment_en_fall  <= '0';	
			usr2_fragment_en_reg1  <= '0';  usr2_fragment_en_reg2 <= '0';  usr2_fragment_en_fall  <= '0';	
			usr3_fragment_en_reg1  <= '0';  usr3_fragment_en_reg2 <= '0';  usr3_fragment_en_fall  <= '0';	
			usr4_fragment_en_reg1  <= '0';  usr4_fragment_en_reg2 <= '0';  usr4_fragment_en_fall  <= '0';	
			usr5_fragment_en_reg1  <= '0';  usr5_fragment_en_reg2 <= '0';  usr5_fragment_en_fall  <= '0';	
			usr6_fragment_en_reg1  <= '0';  usr6_fragment_en_reg2 <= '0';  usr6_fragment_en_fall  <= '0';	
			usr7_fragment_en_reg1  <= '0';  usr7_fragment_en_reg2 <= '0';  usr7_fragment_en_fall  <= '0';	
			usr8_fragment_en_reg1  <= '0';  usr8_fragment_en_reg2 <= '0';  usr8_fragment_en_fall  <= '0';	
        elsif rising_edge ( phy_tx_clk ) then
			fe ( usr1_tx_q.frg_en,usr1_fragment_en_fall,usr1_fragment_en_reg1,usr1_fragment_en_reg2 );			
			fe ( usr2_tx_q.frg_en,usr2_fragment_en_fall,usr2_fragment_en_reg1,usr2_fragment_en_reg2 );			
			fe ( usr3_tx_q.frg_en,usr3_fragment_en_fall,usr3_fragment_en_reg1,usr3_fragment_en_reg2 );			
			fe ( usr4_tx_q.frg_en,usr4_fragment_en_fall,usr4_fragment_en_reg1,usr4_fragment_en_reg2 );			
			fe ( usr5_tx_q.frg_en,usr5_fragment_en_fall,usr5_fragment_en_reg1,usr5_fragment_en_reg2 );			
			fe ( usr6_tx_q.frg_en,usr6_fragment_en_fall,usr6_fragment_en_reg1,usr6_fragment_en_reg2 );			
			fe ( usr7_tx_q.frg_en,usr7_fragment_en_fall,usr7_fragment_en_reg1,usr7_fragment_en_reg2 );			
			fe ( usr8_tx_q.frg_en,usr8_fragment_en_fall,usr8_fragment_en_reg1,usr8_fragment_en_reg2 );			
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr1_fragment_valid <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            if( cs = USR1_FM_TRUE ) then
                usr1_fragment_valid <= '1';
            elsif ( cs = USR1_FM_FALSE ) then 
                usr1_fragment_valid <= '0';
            elsif ( usr1_fragment_en_fall = '1' ) then 
                usr1_fragment_valid <= '0';
            end if;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr2_fragment_valid <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            if( cs = USR2_FM_TRUE ) then
                usr2_fragment_valid <= '1';
            elsif ( cs = USR2_FM_FALSE ) then 
                usr2_fragment_valid <= '0';
            elsif ( usr2_fragment_en_fall = '1' ) then 
                usr2_fragment_valid <= '0';
            end if;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr3_fragment_valid <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            if( cs = USR3_FM_TRUE ) then
                usr3_fragment_valid <= '1';
            elsif ( cs = USR3_FM_FALSE ) then 
                usr3_fragment_valid <= '0';
            elsif ( usr3_fragment_en_fall = '1' ) then 
                usr3_fragment_valid <= '0';
            end if;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr4_fragment_valid <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            if( cs = USR4_FM_TRUE ) then
                usr4_fragment_valid <= '1';
            elsif ( cs = USR4_FM_FALSE ) then 
                usr4_fragment_valid <= '0';
            elsif ( usr4_fragment_en_fall = '1' ) then 
                usr4_fragment_valid <= '0';
            end if;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr5_fragment_valid <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            if( cs = USR5_FM_TRUE ) then
                usr5_fragment_valid <= '1';
            elsif ( cs = USR5_FM_FALSE ) then 
                usr5_fragment_valid <= '0';
            elsif ( usr5_fragment_en_fall = '1' ) then 
                usr5_fragment_valid <= '0';
            end if;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr6_fragment_valid <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            if( cs = USR6_FM_TRUE ) then
                usr6_fragment_valid <= '1';
            elsif ( cs = USR6_FM_FALSE ) then 
                usr6_fragment_valid <= '0';
            elsif ( usr6_fragment_en_fall = '1' ) then 
                usr6_fragment_valid <= '0';
            end if;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr7_fragment_valid <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            if( cs = USR7_FM_TRUE ) then
                usr7_fragment_valid <= '1';
            elsif ( cs = USR7_FM_FALSE ) then 
                usr7_fragment_valid <= '0';
            elsif ( usr7_fragment_en_fall = '1' ) then 
                usr7_fragment_valid <= '0';
            end if;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr8_fragment_valid <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            if( cs = USR8_FM_TRUE ) then
                usr8_fragment_valid <= '1';
            elsif ( cs = USR8_FM_FALSE ) then 
                usr8_fragment_valid <= '0';
            elsif ( usr8_fragment_en_fall = '1' ) then 
                usr8_fragment_valid <= '0';
            end if;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            flagment_cnt <= (others=>'0') ;
        elsif rising_edge ( phy_tx_clk ) then
            if ( fragment_valid = '1' ) then
                if ( cs = USR1_FM_TRUE or cs = USR2_FM_TRUE or cs = USR3_FM_TRUE or cs = USR4_FM_TRUE or cs = USR5_FM_TRUE or cs = USR6_FM_TRUE or cs = USR7_FM_TRUE or cs = USR8_FM_TRUE ) then
                    flagment_cnt <= flagment_cnt + '1' ;
                end if;
            else
                flagment_cnt<= (others=>'0') ;
            end if;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            fragment_valid_reg <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            if ( usr1_fragment_valid = '1' or usr2_fragment_valid = '1' or usr3_fragment_valid = '1' or usr4_fragment_valid = '1' or usr5_fragment_valid = '1' or usr6_fragment_valid = '1' or usr7_fragment_valid = '1' or usr8_fragment_valid = '1') then
                fragment_valid_reg <= '1';
            else
                fragment_valid_reg <= '0';
            end if;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            fragment_valid <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            fragment_valid <= fragment_valid_reg ;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            tx_data_length_reg <= (others=>'0') ;
        elsif rising_edge ( phy_tx_clk ) then
			case cs is 
				when  USR1_DATA =>  tx_data_length_reg <= usr1_tx_q.len ;
				when  USR2_DATA =>  tx_data_length_reg <= usr2_tx_q.len ;
				when  USR3_DATA =>  tx_data_length_reg <= usr3_tx_q.len ;
				when  USR4_DATA =>  tx_data_length_reg <= usr4_tx_q.len ;
				when  USR5_DATA =>  tx_data_length_reg <= usr5_tx_q.len ;
				when  USR6_DATA =>  tx_data_length_reg <= usr6_tx_q.len ;
				when  USR7_DATA =>  tx_data_length_reg <= usr7_tx_q.len ;
				when  USR8_DATA =>  tx_data_length_reg <= usr8_tx_q.len ;
				when others        =>  null  ;
			end case ;      
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            fragment_length_reg <= (others=>'0') ;
        elsif rising_edge ( phy_tx_clk ) then
            if ( fragment_valid = '1'  ) then 
				if flagment_cnt = 0 and (cs = USR1_DATA or cs = USR2_DATA or cs = USR3_DATA or cs = USR4_DATA or cs = USR5_DATA or cs = USR6_DATA or cs = USR7_DATA or cs = USR8_DATA ) then 
					fragment_length_reg <= (others=>'0') ;
				else 
				    case cs is 
				    	when  USR1_FM_TRUE =>  fragment_length_reg <= fragment_length_reg + usr1_tx_q.len ;
				    	when  USR2_FM_TRUE =>  fragment_length_reg <= fragment_length_reg + usr2_tx_q.len ;
				    	when  USR3_FM_TRUE =>  fragment_length_reg <= fragment_length_reg + usr3_tx_q.len ;
				    	when  USR4_FM_TRUE =>  fragment_length_reg <= fragment_length_reg + usr4_tx_q.len ;
				    	when  USR5_FM_TRUE =>  fragment_length_reg <= fragment_length_reg + usr5_tx_q.len ;
				    	when  USR6_FM_TRUE =>  fragment_length_reg <= fragment_length_reg + usr6_tx_q.len ;
				    	when  USR7_FM_TRUE =>  fragment_length_reg <= fragment_length_reg + usr7_tx_q.len ;
				    	when  USR8_FM_TRUE =>  fragment_length_reg <= fragment_length_reg + usr8_tx_q.len ;
				    	when others        =>  null  ;
				    end case ;
				end if ;
			else
				fragment_length_reg <= (others=>'0') ;
            end if;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr_fragment_length <= (others=>'0') ;
        elsif rising_edge ( phy_tx_clk ) then
            if ( fragment_valid = '0' ) then
				case cs is 
					when  USR1_FM_TRUE =>  usr_fragment_length <= usr1_tx_q.frg_len ;
					when  USR2_FM_TRUE =>  usr_fragment_length <= usr2_tx_q.frg_len ;
					when  USR3_FM_TRUE =>  usr_fragment_length <= usr3_tx_q.frg_len ;
					when  USR4_FM_TRUE =>  usr_fragment_length <= usr4_tx_q.frg_len ;
					when  USR5_FM_TRUE =>  usr_fragment_length <= usr5_tx_q.frg_len ;
					when  USR6_FM_TRUE =>  usr_fragment_length <= usr6_tx_q.frg_len ;
					when  USR7_FM_TRUE =>  usr_fragment_length <= usr7_tx_q.frg_len ;
					when  USR8_FM_TRUE =>  usr_fragment_length <= usr8_tx_q.frg_len ;
					when others        =>  null  ;
				end case ;
            end if;           
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            flags <= ( others=>'0' ) ;
        elsif rising_edge ( phy_tx_clk ) then
            if ( fragment_valid = '1' ) then
				if cs = USR1_DATA or cs = USR2_DATA or cs = USR3_DATA or cs = USR4_DATA or cs = USR5_DATA or cs = USR6_DATA or cs = USR7_DATA or cs = USR8_DATA then 
                    if ( ( usr_fragment_length - fragment_length_reg ) <= tx_data_length_reg ) then
                        flags <= "000" ;       
                    else
				        flags <= "001" ;
					end if ;
				end if ;
            else
                flags <= ( others=>'0' ) ;
            end if;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            flagment_offset <= ( others=>'0' ) ;
        elsif rising_edge ( phy_tx_clk ) then
            if ( fragment_valid = '1' ) then
                if ( cs = USR1_DATA or cs = USR2_DATA or cs = USR3_DATA or cs = USR4_DATA or cs = USR5_DATA or cs = USR6_DATA or cs = USR7_DATA or cs = USR8_DATA ) then
                    flagment_offset <= fragment_length_reg ;                     
                end if;
            else
                flagment_offset <= ( others=>'0' ) ;
            end if;
        end if;
end process;
--====================================
-- gen req
--====================================
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr1_tx_req_reg1 <= '0';
            usr1_tx_req_reg2 <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            usr1_tx_req_reg1 <= usr1_tx_q.req ;
            usr1_tx_req_reg2 <= usr1_tx_req_reg1 ;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr2_tx_req_reg1 <= '0';
            usr2_tx_req_reg2 <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            usr2_tx_req_reg1 <= usr2_tx_q.req ;
            usr2_tx_req_reg2 <= usr2_tx_req_reg1 ;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr3_tx_req_reg1 <= '0';
            usr3_tx_req_reg2 <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            usr3_tx_req_reg1 <= usr3_tx_q.req ;
            usr3_tx_req_reg2 <= usr3_tx_req_reg1 ;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr4_tx_req_reg1 <= '0';
            usr4_tx_req_reg2 <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            usr4_tx_req_reg1 <= usr4_tx_q.req ;
            usr4_tx_req_reg2 <= usr4_tx_req_reg1 ;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr5_tx_req_reg1 <= '0';
            usr5_tx_req_reg2 <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            usr5_tx_req_reg1 <= usr5_tx_q.req ;
            usr5_tx_req_reg2 <= usr5_tx_req_reg1 ;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr6_tx_req_reg1 <= '0';
            usr6_tx_req_reg2 <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            usr6_tx_req_reg1 <= usr6_tx_q.req ;
            usr6_tx_req_reg2 <= usr6_tx_req_reg1 ;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr7_tx_req_reg1 <= '0';
            usr7_tx_req_reg2 <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            usr7_tx_req_reg1 <= usr7_tx_q.req ;
            usr7_tx_req_reg2 <= usr7_tx_req_reg1 ;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr8_tx_req_reg1 <= '0';
            usr8_tx_req_reg2 <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            usr8_tx_req_reg1 <= usr8_tx_q.req ;
            usr8_tx_req_reg2 <= usr8_tx_req_reg1 ;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            udp_tx_q.req <= '0'; 
        elsif rising_edge ( phy_tx_clk ) then
			if ( cs = USR1_WAIT_0 or cs = USR2_WAIT_0 or  cs = USR3_WAIT_0 or  cs = USR4_WAIT_0 or cs = USR5_WAIT_0 or cs = USR6_WAIT_0 or  cs = USR7_WAIT_0 or  cs = USR8_WAIT_0) then
			    udp_tx_q.req <= '1'; 
			else
			    udp_tx_q.req <= '0'; 
			end if;            
        end if;
end process;
--====================================
-- gen ack
--====================================
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            udp_tx_ack_reg <= '0'; 
        elsif rising_edge ( clk ) then
			udp_tx_ack_reg <= udp_tx_p.ack ;	
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr1_tx_p.ack 			<= '0'; 
        elsif rising_edge ( clk ) then
			if ( cs = USR1_WAIT_1  ) then
			    usr1_tx_p.ack 		<= udp_tx_ack_reg ; 			    
			else
			    usr1_tx_p.ack 		<= '0'; 
			end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr2_tx_p.ack 			<= '0'; 
        elsif rising_edge ( clk ) then
			if ( cs = USR2_WAIT_1  ) then
			    usr2_tx_p.ack 		<= udp_tx_ack_reg ; 			    
			else
			    usr2_tx_p.ack 		<= '0'; 
			end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr3_tx_p.ack 			<= '0'; 
        elsif rising_edge ( clk ) then
			if ( cs = USR3_WAIT_1  ) then
			    usr3_tx_p.ack 		<= udp_tx_ack_reg ; 			    
			else
			    usr3_tx_p.ack 		<= '0'; 
			end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr4_tx_p.ack 			<= '0'; 
        elsif rising_edge ( clk ) then
			if ( cs = USR4_WAIT_1  ) then
			    usr4_tx_p.ack 		<= udp_tx_ack_reg ; 			    
			else
			    usr4_tx_p.ack 		<= '0'; 
			end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr5_tx_p.ack 			<= '0'; 
        elsif rising_edge ( clk ) then
			if ( cs = USR5_WAIT_1  ) then
			    usr5_tx_p.ack 		<= udp_tx_ack_reg ; 			    
			else
			    usr5_tx_p.ack 		<= '0'; 
			end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr6_tx_p.ack 			<= '0'; 
        elsif rising_edge ( clk ) then
			if ( cs = USR6_WAIT_1  ) then
			    usr6_tx_p.ack 		<= udp_tx_ack_reg ; 			    
			else
			    usr6_tx_p.ack 		<= '0'; 
			end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr7_tx_p.ack 			<= '0'; 
        elsif rising_edge ( clk ) then
			if ( cs = USR7_WAIT_1  ) then
			    usr7_tx_p.ack 		<= udp_tx_ack_reg ; 			    
			else
			    usr7_tx_p.ack 		<= '0'; 
			end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr8_tx_p.ack 			<= '0'; 
        elsif rising_edge ( clk ) then
			if ( cs = USR8_WAIT_1  ) then
			    usr8_tx_p.ack 		<= udp_tx_ack_reg ; 			    
			else
			    usr8_tx_p.ack 		<= '0'; 
			end if;
        end if;
end process;
--====================================
-- gen ready
--====================================
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            usr1_tx_ready_reg 	<= '0'; 
            usr2_tx_ready_reg 	<= '0'; 
            usr3_tx_ready_reg 	<= '0'; 
            usr4_tx_ready_reg 	<= '0'; 
            usr5_tx_ready_reg 	<= '0'; 
            usr6_tx_ready_reg 	<= '0'; 
            usr7_tx_ready_reg 	<= '0'; 
            usr8_tx_ready_reg 	<= '0'; 
        elsif rising_edge ( phy_tx_clk ) then
			usr1_tx_ready_reg 	<= usr1_tx_q.rdy ; 
			usr2_tx_ready_reg 	<= usr2_tx_q.rdy ; 
			usr3_tx_ready_reg 	<= usr3_tx_q.rdy ; 
			usr4_tx_ready_reg 	<= usr4_tx_q.rdy ; 
			usr5_tx_ready_reg 	<= usr5_tx_q.rdy ; 
			usr6_tx_ready_reg 	<= usr6_tx_q.rdy ; 
			usr7_tx_ready_reg 	<= usr7_tx_q.rdy ; 
			usr8_tx_ready_reg 	<= usr8_tx_q.rdy ; 
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            udp_tx_q.ready 		<= '0'; 
        elsif rising_edge ( phy_tx_clk ) then
			if (  cs = USR1_WAIT_1 ) then
				udp_tx_q.ready 		<= usr1_tx_ready_reg ; 			    
			elsif ( cs = USR2_WAIT_1  ) then 
				udp_tx_q.ready      <= usr2_tx_ready_reg ;
			elsif ( cs = USR3_WAIT_1 ) then
				udp_tx_q.ready 		<= usr3_tx_ready_reg ;
			elsif ( cs = USR4_WAIT_1 ) then
				udp_tx_q.ready 		<= usr4_tx_ready_reg ;		
			elsif ( cs = USR5_WAIT_1 ) then
				udp_tx_q.ready 		<= usr5_tx_ready_reg ;	
			elsif ( cs = USR6_WAIT_1 ) then
				udp_tx_q.ready 		<= usr6_tx_ready_reg ;	
			elsif ( cs = USR7_WAIT_1 ) then
				udp_tx_q.ready 		<= usr7_tx_ready_reg ;		
			elsif ( cs = USR8_WAIT_1 ) then
				udp_tx_q.ready 		<= usr8_tx_ready_reg ;				
			else 
            	udp_tx_q.ready 		<= '0'; 
			end if;
        end if;
end process;
--====================================
--  udp_tx_ack.data_req  /udp_tx_ack.tx_end
--====================================
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            udp_data_req_0 <= '0'; 
        elsif rising_edge ( phy_tx_clk ) then
			if ( cs = USR1_DATA or cs = USR2_DATA or cs = USR3_DATA or cs = USR4_DATA or cs = USR5_DATA or cs = USR6_DATA or cs = USR7_DATA or cs = USR8_DATA  ) then
			    udp_data_req_0 <= '1'; 
			else
			    udp_data_req_0 <= '0'; 
			end if;            
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            udp_tx_ack.data_req <= '0';
        elsif rising_edge ( clk ) then
            udp_tx_ack.data_req <= udp_data_req_0 ;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            udp_tx_end_reg <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            if (  cs = SEND_UDP_END ) then
                udp_tx_end_reg  <= '1';
            else
                udp_tx_end_reg <= '0';
            end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            udp_tx_end_reg1 		<= '0';
            udp_tx_ack.tx_end      	<= '0';
        elsif rising_edge ( clk ) then
            udp_tx_end_reg1 		<= udp_tx_end_reg ;
            udp_tx_ack.tx_end 		<= udp_tx_end_reg1 ;
        end if;
end process;
--====================================
-- write fifo
--====================================
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            ram_wr_data <= (others=>'0') ;
        elsif rising_edge ( clk ) then
            case cs is 
				when USR1_DATA => ram_wr_data 		<= usr1_tx_q.data ;
				when USR2_DATA => ram_wr_data 		<= usr2_tx_q.data ;
				when USR3_DATA => ram_wr_data 		<= usr3_tx_q.data ;
				when USR4_DATA => ram_wr_data 		<= usr4_tx_q.data ;
				when USR5_DATA => ram_wr_data 		<= usr5_tx_q.data ;
				when USR6_DATA => ram_wr_data 		<= usr6_tx_q.data ;
				when USR7_DATA => ram_wr_data 		<= usr7_tx_q.data ;
				when USR8_DATA => ram_wr_data 		<= usr8_tx_q.data ;
				when others    => ram_wr_data       <= (others=>'0') ;
			end case ;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            ram_wr_en <= '0';
        elsif rising_edge ( clk ) then
            case cs is 
				when USR1_DATA => ram_wr_en 		<= 	usr1_tx_q.en ;
				when USR2_DATA => ram_wr_en 		<= 	usr2_tx_q.en ;
				when USR3_DATA => ram_wr_en 		<= 	usr3_tx_q.en ;
				when USR4_DATA => ram_wr_en 		<= 	usr4_tx_q.en ;
				when USR5_DATA => ram_wr_en 		<= 	usr5_tx_q.en ;
				when USR6_DATA => ram_wr_en 		<= 	usr6_tx_q.en ;
				when USR7_DATA => ram_wr_en 		<= 	usr7_tx_q.en ;
				when USR8_DATA => ram_wr_en 		<= 	usr8_tx_q.en ;
				when others    => ram_wr_en  		<=  '0' ;
			end case ;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            ram_wr_addr  <= (others=>'0') ;
        elsif rising_edge ( clk ) then
            if ( ram_wr_en = '1' ) then
                ram_wr_addr <= ram_wr_addr + '1' ;
            else
                ram_wr_addr  <= (others=>'0') ;
            end if;
        end if;
end process;
udp_tx_ram : ram_2p_2c_8x2048 PORT MAP (
    clka  => clk,
    wea   => vec (ram_wr_en),
    addra => ram_wr_addr,
    dina  => ram_wr_data,
    clkb  => phy_tx_clk,
    addrb => ram_rd_addr,
    doutb => ram_rd_data	); 
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            ram_rd_addr <= (others=>'0') ;
        elsif rising_edge ( phy_tx_clk ) then
            if ( udp_send_cnt >=40 and  udp_send_cnt <= 19 + conv_integer ( ip_length ) ) then
                 ram_rd_addr <= ram_rd_addr + '1';
            else
                 ram_rd_addr <= (others=>'0') ;
            end if;
        end if;
end process;
--====================================
--  gen udp data/en
--====================================		 
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            udp_send_cnt  <=  0 ;
        elsif rising_edge ( phy_tx_clk ) then
            if ( cs  = USR1_DATA or cs =  USR2_DATA or cs = USR3_DATA or cs = USR4_DATA or cs  = USR5_DATA or cs =  USR6_DATA or cs = USR7_DATA or cs = USR8_DATA ) then
                udp_send_cnt <= udp_send_cnt + 1 ;
            else
                udp_send_cnt  <= 0 ;
            end if;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            timeout  <=  (others=>'0') ;
        elsif rising_edge ( phy_tx_clk ) then
            if ( cs  = USR1_DATA or cs =  USR2_DATA or cs = USR3_DATA or cs = USR4_DATA or cs  = USR5_DATA or cs =  USR6_DATA or cs = USR7_DATA or cs = USR8_DATA 
			  or cs = USR1_WAIT_1 or cs = USR2_WAIT_1 or cs = USR3_WAIT_1 or cs = USR4_WAIT_1 or cs = USR5_WAIT_1 or cs = USR6_WAIT_1 or cs = USR7_WAIT_1 or cs = USR8_WAIT_1 or cs = SEND_UDP_END) then
                timeout <= timeout + '1';
            else
                timeout  <=  (others=>'0') ;
            end if;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            udp_tx_q_en <= '0';
        elsif rising_edge ( phy_tx_clk ) then
            if (  cs  = USR1_DATA or cs =  USR2_DATA or cs = USR3_DATA or cs = USR4_DATA or cs  = USR5_DATA or cs =  USR6_DATA or cs = USR7_DATA or cs = USR8_DATA ) then
                udp_tx_q_en <= '1';
            else
                udp_tx_q_en <= '0';
            end if;
        end if;
end process; 
udp_tx_q.tx_end <= udp_tx_ack.tx_end ;
udp_tx_q.en <= udp_tx_q_en ;
process( phy_tx_rst_n,phy_tx_clk )
    begin
        if phy_tx_rst_n='0' then
            ip_id <= (others=>'0');
        elsif rising_edge( phy_tx_clk ) then
			if usr1_fragment_en_fall = '1' then 
				ip_id <= ip_id +1;
            elsif fragment_valid = '0' then 
			    if udp_send_cnt = 60 then
				    ip_id <= ip_id +1;
			    end if;
			end if ;
        end if;
end process;
ip_length <= usr1_tx_q.len + X"14" when cs = USR1_DATA else
			 usr2_tx_q.len + X"14" when cs = USR2_DATA else
			 usr3_tx_q.len + X"14" when cs = USR3_DATA else
			 usr4_tx_q.len + X"14" when cs = USR4_DATA else
			 usr5_tx_q.len + X"14" when cs = USR5_DATA else
			 usr6_tx_q.len + X"14" when cs = USR6_DATA else
			 usr7_tx_q.len + X"14" when cs = USR7_DATA else
			 usr8_tx_q.len + X"14" when cs = USR8_DATA else ip_length ;
ip_send_length <=  ip_length when conv_integer( ip_length ) >= 46  else X"002e" ;
ip_send_length_reg <= ip_send_length ;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            remote_ip <= (others=>'0') ;
            remote_mac <= (others=>'0') ;
        elsif rising_edge ( phy_tx_clk ) then
            case cs is
                when USR1_DATA  => 	remote_ip 	<= usr1_tx_q.dst_ip ;
									remote_mac 	<= usr1_tx_q.dst_mac ;
				when USR2_DATA  => 	remote_ip 	<= usr2_tx_q.dst_ip ;
									remote_mac 	<= usr2_tx_q.dst_mac ;
                when USR3_DATA   => remote_ip 	<= usr3_tx_q.dst_ip ; 
									remote_mac 	<= usr3_tx_q.dst_mac ;	
                when USR4_DATA   => remote_ip 	<= usr4_tx_q.dst_ip ; 
									remote_mac 	<= usr4_tx_q.dst_mac ;	
                when USR5_DATA   => remote_ip 	<= usr5_tx_q.dst_ip ; 
									remote_mac 	<= usr5_tx_q.dst_mac ;
                when USR6_DATA   => remote_ip 	<= usr6_tx_q.dst_ip ; 
									remote_mac 	<= usr6_tx_q.dst_mac ;	
                when USR7_DATA   => remote_ip 	<= usr7_tx_q.dst_ip ; 
									remote_mac 	<= usr7_tx_q.dst_mac ;	
                when USR8_DATA   => remote_ip 	<= usr8_tx_q.dst_ip ; 
									remote_mac 	<= usr8_tx_q.dst_mac ;					
                when others =>   null;
            end case;            
        end if;
end process;
--====================================
-- gen ip checksum
--====================================
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            IP_checksum_sub1 	<= (others=>'0') ;
        elsif rising_edge ( phy_tx_clk ) then
            IP_checksum_sub1 	<= X"00000000" + X"4500" + ip_length + ip_id + X"ff11" ;           
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            IP_checksum_sub2 	<= (others=>'0') ;
        elsif rising_edge ( phy_tx_clk ) then
            IP_checksum_sub2 	<= X"00000000" +  ( flags & flagment_offset (15 downto 3 )) + local_net.ip (31 downto 16) + local_net.ip (15 downto 0) + remote_ip(31 downto 16) + remote_ip(15 downto 0) ;
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            IP_checksum_reg 	<= (others=>'0') ;
            IP_checksum_reg2 	<= (others=>'0') ;
            IP_checksum 		<= (others=>'0') ;  
        elsif rising_edge ( phy_tx_clk ) then
            IP_checksum_reg 	<= IP_checksum_sub1 + IP_checksum_sub2 ;
            IP_checksum_reg2 	<= X"00000000" + IP_checksum_reg (31 downto 16) + IP_checksum_reg (15 downto 0);
            IP_checksum 		<= not ( IP_checksum_reg2 (31 downto 16) + IP_checksum_reg2 (15 downto 0) );            
        end if;
end process;
process ( phy_tx_rst_n , phy_tx_clk )
    begin
        if phy_tx_rst_n = '0' then
            udp_tx_q_data <= (others=>'0') ;
        elsif rising_edge ( phy_tx_clk ) then
            if cs = USR1_DATA or cs = USR2_DATA or cs = USR3_DATA or cs =  USR4_DATA or cs = USR5_DATA or cs = USR6_DATA or cs = USR7_DATA or cs =  USR8_DATA then 
                case udp_send_cnt is
					when 0 to 6     => udp_tx_q_data <= X"55";
                    when 7 		    => udp_tx_q_data <= X"D5";
                    when 8          => udp_tx_q_data <= remote_mac (47 downto 40);
                    when 9          => udp_tx_q_data <= remote_mac (39 downto 32);
                    when 10         => udp_tx_q_data <= remote_mac (31 downto 24);
                    when 11         => udp_tx_q_data <= remote_mac (23 downto 16);
                    when 12         => udp_tx_q_data <= remote_mac (15 downto 8);
                    when 13         => udp_tx_q_data <= remote_mac (7 downto 0);
                    when 14         => udp_tx_q_data <= local_net.mac (47 downto 40);
                    when 15         => udp_tx_q_data <= local_net.mac (39 downto 32);
                    when 16         => udp_tx_q_data <= local_net.mac (31 downto 24);
                    when 17         => udp_tx_q_data <= local_net.mac (23 downto 16);
                    when 18         => udp_tx_q_data <= local_net.mac (15 downto 8);
                    when 19         => udp_tx_q_data <= local_net.mac (7 downto 0);
                    when 20         => udp_tx_q_data <= Ipv4Type (15 downto 8);
                    when 21         => udp_tx_q_data <= Ipv4Type (7 downto 0);
                    when 22         => udp_tx_q_data <= X"45" ;
                    when 23         => udp_tx_q_data <= X"00" ;
                    when 24         => udp_tx_q_data <= ip_length (15 downto 8);
                    when 25         => udp_tx_q_data <= ip_length (7 downto 0);
                    when 26         => udp_tx_q_data <= ip_id (15 downto 8) ;
                    when 27         => udp_tx_q_data <= ip_id (7 downto 0) ;
                    when 28         => udp_tx_q_data <= flags & flagment_offset (15 downto 11 );
                    when 29         => udp_tx_q_data <= flagment_offset (10 downto 3 );
                    when 30         => udp_tx_q_data <= X"ff" ; 	--ttl
                    when 31         => udp_tx_q_data <= X"11" ; 	--udp
                    when 32         => udp_tx_q_data <= ip_checksum (15 downto 8);
                    when 33         => udp_tx_q_data <= ip_checksum (7 downto 0);
                    when 34         => udp_tx_q_data <= local_net.ip (31 downto 24);
                    when 35         => udp_tx_q_data <= local_net.ip (23 downto 16);
                    when 36         => udp_tx_q_data <= local_net.ip (15 downto 8);
                    when 37         => udp_tx_q_data <= local_net.ip (7 downto 0);
                    when 38         => udp_tx_q_data <= remote_ip (31 downto 24);
                    when 39         => udp_tx_q_data <= remote_ip (23 downto 16);
                    when 40         => udp_tx_q_data <= remote_ip (15 downto 8);
                    when 41         => udp_tx_q_data <= remote_ip (7 downto 0);
					when others     => udp_tx_q_data <= ram_rd_data ; 
				end case ;		
			end if ;
        end if;
end process;
udp_tx_q.data <= udp_tx_q_data ; 
--***************************************************************
-- debug
--***************************************************************

-- ila_256_inst : ila_256 port map (
--         clk                     => phy_tx_clk ,
--         probe0                  => 
-- X"0000000000000000"  & --64
-- X"0000000000000000"  & --64
-- X"0000000000000000"  & --64
-- X"000000000"   & --36
--        "000"                                 & -- 3
--        usr2_tx_req_reg2                      & -- 1
--        timeout				                 &  --16
--        cs                                   );  

end ;         	