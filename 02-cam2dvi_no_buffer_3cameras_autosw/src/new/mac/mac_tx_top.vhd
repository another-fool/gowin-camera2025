library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.mt_lib.all;
entity mac_tx_top is
    port (		
        phy_rxc                 : in std_logic;
        phy_txc                 : in std_logic;
        reset_n             	: in std_logic;			
		local_net    	    	: in net_type ;		
		udp_tx_q				: in mac_tx_q ;	
		udp_tx_p	            : out mac_tx_p ;
		mac_tx_ack              : buffer mac_tx_ack ;		
		arp_remote_net    		: in net_type ;	
        arp_reply_ack      		: out std_logic;		
        arp_reply_req    		: in std_logic ; 		
		icmp_remote_net    		: in net_type ;	
        icmp_rx_data_length    	: in std_logic_vector(15 downto 0);
        icmp_rx_en      		: in std_logic;
        icmp_rx_data    		: in std_logic_vector(7 downto 0);
		phy_tx					: out phy_tx );
end mac_tx_top ;
architecture rtl of mac_tx_top is
signal arp_tx_p					: mac_tx_p ;		
signal arp_tx_q               	: mac_tx_q ; 
signal icmp_tx_q				: mac_tx_q ;		
signal icmp_tx_p                : mac_tx_p ; 
begin
icmp_tx_0 : entity work.icmp_tx(rtl) port map (
        phy_rxc                 => phy_rxc               ,
        phy_txc                 => phy_txc               ,
        reset_n             	=> reset_n               ,
		local_net    			=> local_net    		 ,
		remote_net    			=> icmp_remote_net    	 ,
        icmp_rx_data_length     => icmp_rx_data_length   ,
        icmp_rx_en      		=> icmp_rx_en      	     ,
        icmp_rx_data    		=> icmp_rx_data    	     ,
		mac_tx_ack				=> mac_tx_ack			 ,
		icmp_tx_q             	=> icmp_tx_q             ,
		icmp_tx_p				=> icmp_tx_p             );
arp_tx_0 : entity work.arp_tx(rtl) port map(
        phy_txc             	=> phy_txc               ,
        reset_n             	=> reset_n               ,
		local_net    			=> local_net    	     ,
		remote_net    			=> arp_remote_net    	 ,
        arp_reply_ack      		=> arp_reply_ack         ,
        arp_reply_req    		=> arp_reply_req         ,
		arp_tx_q             	=> arp_tx_q              ,
		mac_tx_ack				=> mac_tx_ack			 ,
		arp_tx_p				=> arp_tx_p		         );
mac_tx_0 : entity work.mac_tx(rtl) port map(
   		phy_txc			  		=> phy_txc			  	 ,
   		reset_n		  			=> reset_n		  		 ,
		udp_tx_q				=> udp_tx_q			 	 ,
		udp_tx_p	            => udp_tx_p	         	 ,
		arp_tx_q             	=> arp_tx_q              ,
		arp_tx_p				=> arp_tx_p			     ,
		icmp_tx_q             	=> icmp_tx_q             ,
		icmp_tx_p				=> icmp_tx_p			 ,
		mac_tx_ack				=> mac_tx_ack		 	 ,
		phy_tx					=> phy_tx				 );
end rtl ;
