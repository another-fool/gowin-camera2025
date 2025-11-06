library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.mt_lib.all;
use work.src_lib.all;
entity frame_tx is port (
		rst_n	    		        : in std_logic ;
		clk	    		            : in std_logic ;
		usr_rx						: in usr_rx ;		

        frame_rx_ack_req          	: in std_logic ;
        frame_rx_ack_rsp          	: out std_logic ;

        frame_rx_ack_cmd          	: in std_logic_vector(15 downto 0);

        usr_tx_q  		    		: buffer usr_tx_q ;
		usr_tx_p                 	: in usr_tx_p ;	
		udp_tx_ack 	    			: in udp_tx_ack );
end frame_tx ;

architecture rtl of frame_tx is 
constant IDLE                       : std_logic_vector(7 downto 0):= X"00";
constant FRAME_RX_ACK_WAIT_0         : std_logic_vector(7 downto 0):= X"01";
constant FRAME_RX_ACK_WAIT_1         : std_logic_vector(7 downto 0):= X"02";
constant FRAME_RX_ACK                : std_logic_vector(7 downto 0):= X"03"; 
constant SEND_END                   : std_logic_vector(7 downto 0):= X"07"; 
signal cs                           : std_logic_vector(7 downto 0):= IDLE ;
signal ns                           : std_logic_vector(7 downto 0):= IDLE ;
signal send_cnt                     : integer range 0 to 2048 ;
signal time_out 					: std_logic_vector(15 downto 0);
signal udp_send_length 				: std_logic_vector(15 downto 0);
signal udp_checksum 				: std_logic_vector(15 downto 0);
signal frame_rx_ack_req_reg         : std_logic;  

constant ILA_LENTH                  : integer := 256 ;
component ila_256 port (
    clk                             : in std_logic;
    probe0                          : in std_logic_vector( ILA_LENTH -1 downto 0) );
end component;      
begin
usr_tx_q.frg_len		            <= (others=>'0') ;
usr_tx_q.frg_en			            <= '0';
usr_tx_q.dst_mac		            <= usr_rx.remote_mac ;
usr_tx_q.dst_ip			            <= usr_rx.remote_ip ;
--====================================
-- send sm
--====================================
process( rst_n,clk )
    begin
        if rst_n ='0' then
            frame_rx_ack_req_reg <= '0'; 
        elsif rising_edge( clk ) then
            frame_rx_ack_req_reg <= frame_rx_ack_req ; 
        end if;
end process;
process ( rst_n,clk ) 
    begin
        if rst_n = '0' then 
            cs <= IDLE ;
        elsif rising_edge( clk ) then
            cs <= ns ;
        end if;
end process;
process( cs,udp_tx_ack.data_req ,udp_send_length,send_cnt,time_out,udp_tx_ack.tx_end,frame_rx_ack_req_reg )
    begin    
        case cs is     
            when IDLE =>                        if frame_rx_ack_req_reg = '1' then
                                                    ns <= FRAME_RX_ACK_WAIT_0 ; 													
                                                else
                                                    ns <= IDLE ;
                                                end if; 
            when  FRAME_RX_ACK_WAIT_0 => 	    if time_out = X"ffff" then 
									            	ns <= IDLE  ;
			                                    elsif usr_tx_p.ack = '1' then
                                                    ns <= FRAME_RX_ACK_WAIT_1 ;
                                                else
                                                    ns <= FRAME_RX_ACK_WAIT_0 ;
                                                end if;
            when  FRAME_RX_ACK_WAIT_1 =>         if time_out = X"ffff" then 
									            	ns <= IDLE  ;
			                                    elsif udp_tx_ack.data_req = '1' then
                                                    ns <= FRAME_RX_ACK  ;
                                                else
                                                    ns <= FRAME_RX_ACK_WAIT_1 ;
                                                end if; 
            when  FRAME_RX_ACK =>                if send_cnt = conv_integer ( udp_send_length ) - 1 then
                                                    ns <= SEND_END  ;
                                                else
                                                    ns <= FRAME_RX_ACK ;
                                                end if; 											
            when SEND_END =>                    if time_out = X"ffff" then 
									            	ns <= IDLE  ;
			                                    elsif udp_tx_ack.tx_end = '1' then
                                                    ns <= IDLE  ;
                                                else
                                                    ns <= SEND_END ;
                                                end if; 
            when others =>                      ns <= IDLE ;
        end case;
end process;

process ( rst_n , clk )
    begin
        if rst_n = '0' then
            time_out <=  (others=>'0') ;
        elsif rising_edge ( clk ) then
            if (cs /= ns) then 
				time_out <=  (others=>'0') ;
			else
                time_out <= time_out + '1' ; 
			end if ;
        end if;
end process;
--====================================
-- set pa net
--====================================
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            frame_rx_ack_rsp 	<= '0';
        elsif rising_edge ( clk ) then
            if cs = FRAME_RX_ACK_WAIT_0  then 
                frame_rx_ack_rsp <= '1';
			else
				frame_rx_ack_rsp <= '0';
            end if; 
        end if;
end process; 
udp_send_length 	<= UsrRawLength + X"0008" ;
usr_tx_q.len 		<= udp_send_length ;	 
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr_tx_q.req <= '0';
        elsif rising_edge ( clk ) then
            if ( cs = FRAME_RX_ACK_WAIT_0 ) then
                usr_tx_q.req <= '1';
            else
                usr_tx_q.req <= '0';
            end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr_tx_q.rdy <= '0';
        elsif rising_edge ( clk ) then
            if ( cs = FRAME_RX_ACK_WAIT_1 ) then
                usr_tx_q.rdy <= '1';
            else
                usr_tx_q.rdy <= '0';
            end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr_tx_q.en <= '0';
        elsif rising_edge ( clk ) then
            if (  cs =  FRAME_RX_ACK  ) then
                usr_tx_q.en <= '1';
			else 
				usr_tx_q.en <= '0';
            end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            send_cnt <= 0 ;
        elsif rising_edge ( clk ) then
            if (cs =  FRAME_RX_ACK  ) then
                send_cnt <= send_cnt + 1 ;
            else
                send_cnt <= 0 ;
            end if;            
        end if;
end process;
udp_checksum <= X"0000" ;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            usr_tx_q.data <= (others=>'0') ;
        elsif rising_edge ( clk ) then
            if ( cs = FRAME_RX_ACK ) then
                case send_cnt is
                    when   0    => usr_tx_q.data <= Usr4LocalPort (15 downto 8) ;
                    when   1    => usr_tx_q.data <= Usr4LocalPort (7 downto 0) ;
                    when   2    => usr_tx_q.data <= usr_rx.remote_port (15 downto 8);
                    when   3    => usr_tx_q.data <= usr_rx.remote_port(7 downto 0) 	;
                    when   4    => usr_tx_q.data <= udp_send_length (15 downto 8) ;
                    when   5    => usr_tx_q.data <= udp_send_length (7 downto 0) ;
                    when   6    => usr_tx_q.data <= udp_checksum (15 downto 8) ;
                    when   7    => usr_tx_q.data <= udp_checksum (15 downto 8) ;

                    when   8    => usr_tx_q.data <= MEI_TENG (15 downto 8) ;
                    when   9    => usr_tx_q.data <= MEI_TENG (7 downto 0) ;
                    when   10   => usr_tx_q.data <= frame_rx_ack_cmd (15 downto 8) ;
                    when   11   => usr_tx_q.data <= frame_rx_ack_cmd (7 downto 0) ; 
                    when others => usr_tx_q.data <= (others=>'0') ;
                end case;					
            else 
                usr_tx_q.data <= (others=>'0') ;
            end if;
        end if;
end process; 
end ;
