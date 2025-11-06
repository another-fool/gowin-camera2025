library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.mt_lib.all;
entity mac_top is
    port (
		clk    				    	    : in std_logic;
		rst_n  				    	    : in std_logic;
        phy_mdc     	                : out std_logic;
        phy_mdio    	                : inout std_logic; 		
        phy_link    	                : out std_logic;	
		
		gmii_tck				    	: in std_logic;
		rst_n_tx				    	: in std_logic;
		gmii_rx						    : in gmii_rx ;		
		gmii_tx						    : out gmii_tx ;
		
		phy_rx							: buffer phy_rx ;	
		rst_n_rx						: in std_logic;
		udp_tx_q						: in mac_tx_q ;		
		udp_tx_p						: out mac_tx_p ;		
		mac_tx_ack						: out mac_tx_ack ;		
		local_net					    : in net_type );
end mac_top ;
architecture rtl of mac_top is
signal phy_rst_cnt 						: integer range 0 to  500000000 + 1 := 0 ;
signal phy_tx                           : phy_tx ;  
signal arp_remote_net    		        : net_type ;
signal icmp_remote_net	    	        : net_type ;
signal arp_reply_ack      		        : std_logic;		
signal arp_reply_req    		        : std_logic ;		
signal icmp_rx_data_length    	        : std_logic_vector(15 downto 0);
signal icmp_rx_en      			        : std_logic;
signal icmp_rx_data    			        : std_logic_vector(7 downto 0);
signal phy_rst 							: std_logic;
begin
--====================================
--  rx
--====================================
gmii_rx_conv   :entity  work.gmii_rx_conv(rtl) port map (
	reset_n					  => rst_n_rx    			,		
	gmii_rx 				  => gmii_rx 				, 	
	phy_rx 				  	  => phy_rx 				);
mac_rx_top_0 : entity work.mac_rx_top(rtl)  port map (  	
	reset_n    				  => rst_n_rx				,		
    local_net                 => local_net              , 
	phy_rx					  => phy_rx					,	
	icmp_remote_net    		  => icmp_remote_net    	,	
    icmp_rx_data_length    	  => icmp_rx_data_length    ,	
    icmp_rx_en      		  => icmp_rx_en      		,
    icmp_rx_data    		  => icmp_rx_data    		,
	arp_remote_net    	      => arp_remote_net    	    ,
    arp_reply_ack      		  => arp_reply_ack      	,	
    arp_reply_req    		  => arp_reply_req    		) ;

mac_tx_top_0 : entity work.mac_tx_top(rtl)  port map (
	phy_rxc                   => phy_rx.clk             ,
	phy_txc                   => gmii_tck        		,
	reset_n                   => rst_n_tx            	,
	local_net	              => local_net	            ,
	udp_tx_q			      => udp_tx_q			    ,
	udp_tx_p	              => udp_tx_p	            ,		
	mac_tx_ack		          => mac_tx_ack		        ,	
	arp_remote_net            => arp_remote_net     	,
	arp_reply_ack             => arp_reply_ack          ,
	arp_reply_req    	      => arp_reply_req    	    ,
	icmp_remote_net	          => icmp_remote_net	    ,
	icmp_rx_data_length       => icmp_rx_data_length    ,
	icmp_rx_en      	      => icmp_rx_en      	    ,
	icmp_rx_data    	      => icmp_rx_data    	    ,
	phy_tx			          => phy_tx			    	) ; 
mdio_top_0 : entity work.mdio_top (rtl)  port map (
    clk                		  => clk           			,
    rst_n                     => rst_n                  ,
	phy_mdc 	              => phy_mdc 				,
	phy_mdio  	              => phy_mdio  				,
	phy_rst_n				  => phy_rst 				,
	phy_link 	           	  => phy_link 				);
--====================================
-- gen gmii_tx bus 
--====================================	 
-- gmii_tx.data 	<= phy_tx.data ;
-- gmii_tx.en 		<= phy_tx.en ;       
gmii_tx.clk 	<= gmii_tck ;
process( rst_n_tx , gmii_tck )
	begin
		if rst_n_tx ='0' then
            gmii_tx.data 	<= (others => '0');
            gmii_tx.en 		<= '0';
		elsif rising_edge( gmii_tck ) then
            gmii_tx.data 	<= phy_tx.data ;
            gmii_tx.en 		<= phy_tx.en ;  
		end if;
end process;
gmii_tx.er 		<= '0' ;
gmii_tx.rst    	<= phy_rst ;  
end rtl ;
