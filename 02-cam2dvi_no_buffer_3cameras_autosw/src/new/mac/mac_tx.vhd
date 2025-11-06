library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.mt_lib.all;
entity mac_tx is
    port ( 		
   		phy_txc			  		: in std_logic;
   		reset_n		  			: in std_logic;			
		udp_tx_q             	: in mac_tx_q ; 
		udp_tx_p             	: out mac_tx_p; 
		arp_tx_q             	: in mac_tx_q ; 
		arp_tx_p				: out mac_tx_p;		
		icmp_tx_q             	: in mac_tx_q ;
		icmp_tx_p				: out mac_tx_p ;	
		mac_tx_ack				: out mac_tx_ack ;			
		phy_tx   				: buffer phy_tx );
end mac_tx ;
architecture rtl of mac_tx is
signal MAC_data 	   	        : std_logic_vector(7 downto 0);
signal E_TXD 	   		        : std_logic_vector(7 downto 0);
signal MAC_en 		            : std_logic; 
signal E_TXEN 		            : std_logic; 
signal timeout 		            : std_logic_vector(15 downto 0);
signal ifg_cnt                  : integer range 0 to InterframeGap + 1 ;
signal udp_tx_end_reg           : std_logic;
signal arp_tx_end_reg           : std_logic;
signal icmp_tx_end_reg          : std_logic;
type statetype is (SEND_IDLE,SEND_ARP_START,SEND_ICMP_START, SEND_UDP_START,SEND_ARP_DATA,SEND_ICMP_DATA,SEND_UDP_DATA,SEND_IFG,SEND_END );
signal  cs:     statetype;  -- current state of lsm
signal  ns:     statetype;  -- next state of lsm
begin
--====================================
-- mac rec sm
--====================================
process ( reset_n , phy_txc )
    begin
        if reset_n = '0' then
            udp_tx_end_reg	<= '0';
			arp_tx_end_reg	<= '0';
			icmp_tx_end_reg	<= '0';
        elsif rising_edge ( phy_txc ) then
            udp_tx_end_reg <= udp_tx_q.tx_end ;
            arp_tx_end_reg <= arp_tx_q.tx_end ;
            icmp_tx_end_reg <= icmp_tx_q.tx_end ;
        end if;
end process;
process( reset_n , phy_txc ) 
    begin
        if reset_n = '0' then 
            cs <= SEND_IDLE ;
        elsif rising_edge( phy_txc ) then
            cs <= ns ;
        end if;
end process;    
process(cs ,arp_tx_q.req,icmp_tx_q.req,udp_tx_q.req,arp_tx_q.ready,arp_tx_end_reg,icmp_tx_q.ready,icmp_tx_end_reg,udp_tx_q.ready,udp_tx_end_reg,ifg_cnt )
    begin    
        case cs is     
            when SEND_IDLE =>       if ( arp_tx_q.req  = '1' ) then 
                                        ns <= SEND_ARP_START ;
							        elsif ( icmp_tx_q.req  = '1' ) then 
                                        ns <= SEND_ICMP_START ;
								    elsif ( udp_tx_q.req  = '1' ) then
                                        ns <= SEND_UDP_START ;
                                    else
                                        ns <= SEND_IDLE ;
                                    end if;
            when SEND_ARP_START =>  if timeout = X"ffff" then 
										ns <= SEND_END ;
                                   elsif ( arp_tx_q.ready = '1' ) then
                                       ns <= SEND_ARP_DATA ;
                                    else
                                       ns <= SEND_ARP_START ;
                                    end if;
            when SEND_ARP_DATA =>  if ( arp_tx_end_reg  = '1' ) then
                                   		ns <= SEND_IFG ;								
								   elsif timeout = X"ffff" then 
										ns <= SEND_END ;
                                   else
                                        ns <= SEND_ARP_DATA ;
                                   end if;		
			when SEND_ICMP_START =>  if timeout = X"ffff" then 
										ns <= SEND_END ;
                                   elsif ( icmp_tx_q.ready = '1' ) then
                                       ns <= SEND_ICMP_DATA ;
                                    else
                                       ns <= SEND_ICMP_START ;
                                    end if;
            when SEND_ICMP_DATA =>  if ( icmp_tx_end_reg  = '1' ) then
                                   		ns <= SEND_IFG ;								
								   elsif timeout = X"ffff" then 
										ns <= SEND_END ;
                                   else
                                        ns <= SEND_ICMP_DATA ;
                                   end if;	
            when SEND_UDP_START =>  if timeout = X"ffff" then 
										ns <= SEND_END ;
                                   elsif ( udp_tx_q.ready = '1' ) then
                                       ns <= SEND_UDP_DATA ;
                                    else
                                       ns <= SEND_UDP_START ;
                                    end if;
            when SEND_UDP_DATA  =>  if ( udp_tx_end_reg  = '1' ) then
                                   		ns <= SEND_IFG ;								
								   elsif timeout = X"ffff" then 
										ns <= SEND_END ;
                                   else
                                        ns <= SEND_UDP_DATA ;
                                   end if;	
			when SEND_IFG 		=>  if ( ifg_cnt = InterframeGap ) then
                                   		ns <= SEND_END ;
                                   else
                                        ns <= SEND_IFG ;
                                   end if;									   
            when SEND_END =>    ns <= SEND_IDLE  ;
            when others  =>     ns <= SEND_IDLE  ;
        end case;
end process;
process ( reset_n , phy_txc )
    begin
        if reset_n = '0' then
            arp_tx_p.ack <= '0';
        elsif rising_edge ( phy_txc ) then
            if ( cs = SEND_ARP_START ) then
                arp_tx_p.ack <= '1';
            else
                arp_tx_p.ack <= '0';
            end if;
        end if;
end process;
process ( reset_n , phy_txc )
    begin
        if reset_n = '0' then
            icmp_tx_p.ack <= '0';
        elsif rising_edge ( phy_txc ) then
            if ( cs = SEND_ICMP_START ) then
                icmp_tx_p.ack <= '1';
            else
                icmp_tx_p.ack <= '0';
            end if;
        end if;
end process;
process ( reset_n , phy_txc )
    begin
        if reset_n = '0' then
            udp_tx_p.ack <= '0';
        elsif rising_edge ( phy_txc ) then
            if ( cs = SEND_UDP_START ) then
                udp_tx_p.ack <= '1';
            else
                udp_tx_p.ack <= '0';
            end if;
        end if;
end process;
process ( reset_n , phy_txc )
    begin
        if reset_n = '0' then
            mac_tx_ack.data_req <= '0';
        elsif rising_edge ( phy_txc ) then
            if ( cs = SEND_ARP_DATA or cs = SEND_ICMP_DATA or  cs = SEND_UDP_DATA ) then
                mac_tx_ack.data_req <= '1';
            else
                mac_tx_ack.data_req <= '0';
            end if;
        end if;
end process;
process ( reset_n , phy_txc )
    begin
        if reset_n = '0' then
            mac_tx_ack.mac_end <= '0';
        elsif rising_edge ( phy_txc ) then
            if ( cs = SEND_END ) then
                mac_tx_ack.mac_end <= '1';
            else
                mac_tx_ack.mac_end <= '0';
            end if;
        end if;
end process;
process ( reset_n , phy_txc )
    begin
        if reset_n = '0' then
            timeout <=(others=>'0') ;
        elsif rising_edge ( phy_txc ) then
            if ( cs = SEND_UDP_DATA or cs = SEND_ICMP_DATA or cs = SEND_ARP_DATA or cs = SEND_ARP_START or cs = SEND_ICMP_START or cs =  SEND_UDP_START ) then
                timeout <= timeout + '1' ;
            else
                timeout <=(others=>'0') ;
            end if;
        end if;
end process;

process ( reset_n , phy_txc)
    begin
        if reset_n = '0' then
            ifg_cnt <= 0 ;
        elsif rising_edge ( phy_txc ) then
            if ( cs = SEND_IFG ) then
				if ( ifg_cnt < InterframeGap ) then
				    ifg_cnt <= ifg_cnt + 1 ;
				else
				    ifg_cnt <= InterframeGap ;
				end if;                
            else
                ifg_cnt <= 0 ;
            end if;
        end if;
end process;
process ( reset_n , phy_txc )
    begin
        if reset_n = '0' then
            MAC_data <= (others=>'0') ;
			MAC_en <= '0';
        elsif rising_edge ( phy_txc ) then
            case cs  is
                when SEND_ARP_DATA => 
					MAC_data <= arp_tx_q.data ;
					MAC_en   <= arp_tx_q.en ;	
                when SEND_ICMP_DATA => 
					MAC_data <= icmp_tx_q.data ;
					MAC_en   <= icmp_tx_q.en ;
				when SEND_UDP_DATA => 
					MAC_data <= udp_tx_q.data ;
					MAC_en   <= udp_tx_q.en ;					
                when others =>
                    MAC_data <= (others=>'0') ;
					MAC_en <= '0';
            end case;            
        end if;
end process;	
Inst_fcs: entity work.fcs(rtl)
    PORT MAP(
		reset_n 	=> reset_n,
		MAC_data 	=> MAC_data,
		MAC_en 		=> MAC_en,
		E_TXC 		=> phy_txc ,
		E_TXD 		=> E_TXD ,
		E_TXEN 		=> E_TXEN
	); 
-- process ( reset_n , phy_txc )
    -- begin
        -- if reset_n = '0' then
            -- phy_tx.data <= (others=>'0') ;
			-- phy_tx.en <= '0';
        -- elsif rising_edge ( phy_txc ) then
            phy_tx.data <=  E_TXD   ;
			phy_tx.en <= E_TXEN ;
        -- end if;
-- end process;	
end rtl ;  

