library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use IEEE.math_real.ceil;
use IEEE.math_real.log2; 
package mt_lib is
--====================================
-- net define 
--==================================== 
 

constant InterframeGap 					: integer := 12 ; 
constant Preamble 						: std_logic_vector(55 downto 0) := X"55555555555555";
constant Sfd 							: std_logic_vector(7 downto 0)  := X"d5";
--mac type                                                                 
constant Ipv4Type    	   		        : std_logic_vector(15 downto 0) := X"0800";
constant ArpType    	   		        : std_logic_vector(15 downto 0) := X"0806";
--ip type                                                                  
constant UdpProtocol 		            : std_logic_vector(7 downto 0)  := X"11";
constant IcmpProtocol 		            : std_logic_vector(7 downto 0)  := X"01";
constant IpTtl 		            		: std_logic_vector(7 downto 0)  := X"ff"; --255
constant IcmpTtl 		            	: std_logic_vector(7 downto 0)  := X"40"; --64
constant DefaultFlags           		: std_logic_vector(2 downto 0)  := (others=>'0') ;
constant DefaultFragment           		: std_logic_vector(12 downto 0) := (others=>'0') ;
constant IpVersion  		            : std_logic_vector(3 downto 0)  := X"4"; --ipv4
constant IpLength 		                : std_logic_vector(3 downto 0)  := X"5"; --长度20
--arp define                                                               
constant HardwareType    	   	        : std_logic_vector(15 downto 0) := X"0001";
constant ProtocolType    	   	        : std_logic_vector(15 downto 0) := X"0800";
constant ArpMaclength    	   		    : std_logic_vector(7 downto 0)  := X"06";
constant ArpIpLength    	   		    : std_logic_vector(7 downto 0)  := X"04";
constant ArpRequestCode      	        : std_logic_vector(15 downto 0) := X"0001";
constant ArpReplyCode      	   		    : std_logic_vector(15 downto 0) := X"0002";
constant ArpPadding 			        : std_logic_vector(7 downto 0)  := X"00";
constant ArpRequest 	                : std_logic_vector(15 downto 0) := X"0001";
--icmp define
constant IcmpTypePingRequest 		    : std_logic_vector(7 downto 0)  := X"08";
constant IcmpTypePingReply 		       	: std_logic_vector(7 downto 0)  := X"00";
constant IcmpTypeDestinationUnreachable : std_logic_vector(7 downto 0)  := X"03";   
type gmii_rx is record
    clk     	                        : std_logic;
    data                                : std_logic_vector(7 downto 0);
    dv      	                        : std_logic;
    er      	                        : std_logic;
end record gmii_rx ; 
type gmii_tx is record
    clk       	                        : std_logic;
    data                                : std_logic_vector(7 downto 0);
    en       	                        : std_logic;
    er        	                        : std_logic;
    rst       	                        : std_logic;
end record gmii_tx ;   
type phy_rx is record
    clk        				            : std_logic;
	dv		        		            : std_logic;		
	data		        		        : std_logic_vector(7 downto 0);
end record phy_rx ;                     
type phy_tx is record                   
	en		        	                : std_logic;	
	data		        		        : std_logic_vector(7 downto 0);
end record phy_tx ;
type sys is record
    clk        				            : std_logic;
	rst_n		        		        : std_logic;	
end record sys ;   
type ddrsys is record
    clk        				            : std_logic;
	rst_n		        		        : std_logic;	
end record ddrsys ;                          
type rmii_in is record                  
    clk        				            : std_logic;
	crs		        		            : std_logic;
	rxd		        		            : std_logic_vector(1 downto 0);
end record rmii_in ;                    
type rmii_out is record                 
	tx_en		        	            : std_logic;	
	txd		        		            : std_logic_vector(1 downto 0);
end record rmii_out ;
type mac_tx_ack is record       
	data_req		                	: std_logic;                            
    mac_end   		                	: std_logic;	
end record mac_tx_ack ;	
type udp_tx_ack is record       
	data_req		                	: std_logic; 	                           
    tx_end   		                	: std_logic;	
end record udp_tx_ack ;			
type mac_tx_p is record       	
    ack   		                		: std_logic;	
end record mac_tx_p ;			
type mac_tx_q is record
	tx_end			                	: std_logic;	
	req			                		: std_logic;                           
	ready		                		: std_logic;                           
	data		                    	: std_logic_vector(7 downto 0);         
    en   		                		: std_logic;	 	
end record mac_tx_q ;
type net_type is record
	mac			                	    : std_logic_vector(47 downto 0);      
	ip			            			: std_logic_vector(31 downto 0);  	
end record net_type ;
type port_type is record
	local_port			                : std_logic_vector(15 downto 0);      
	remote_port			            	: std_logic_vector(15 downto 0);  	
end record port_type ;

type usr_rx is record
	remote_mac    		        	    : std_logic_vector(47 downto 0);	
   	remote_ip	    	        	    : std_logic_vector(31 downto 0);			
	remote_port        				    : std_logic_vector(15 downto 0);	
    data   						        : std_logic_vector(7 downto 0);
    dv      				        	: std_logic;	 	
end record usr_rx ;	

type usr_tx_q is record 
	dst_mac    		                    : std_logic_vector(47 downto 0);		
   	dst_ip	    		                : std_logic_vector(31 downto 0); 										
    req      		            	    : std_logic;
	rdy      		            	    : std_logic;
	data		                	    : std_logic_vector(7 downto 0);         
    en   		                	    : std_logic;		
	len		            	    		: std_logic_vector(15 downto 0);		
	frg_len		        	    		: std_logic_vector(15 downto 0);	
	frg_en		            	    	: std_logic;		
end record usr_tx_q ;		
type usr_tx_p is record
	ack                     			: std_logic;	
end record usr_tx_p ;	
--***************************************************************
-- eeprom type record
--***************************************************************
type e2p_wr_q is record
  	req			    			        : std_logic;
    addr      		   			        : std_logic_vector(23 downto 0); 
    len                			        : std_logic_vector(15 downto 0); 
	rdy			    		        	: std_logic;       		
    data               			        : std_logic_vector (7 downto 0);
end record e2p_wr_q ;	
type e2p_wr_p is record
	ack			                    	: std_logic;
	ram_addr		                    : std_logic_vector(15 downto 0); 
	finish         	                    : std_logic ;  
	check_error 	                    : std_logic ;
end record e2p_wr_p ;	
type e2p_rd_q is record
	req			    	            	: std_logic;
    addr                                : std_logic_vector(23 downto 0);        
    len                                 : std_logic_vector(15 downto 0); 
	rdy			                    	: std_logic;	
end record e2p_rd_q ;
type e2p_rd_p is record
	ack			    	            	: std_logic;	
    data               	            	: std_logic_vector (7 downto 0);
	dv 	 	    	            		: std_logic; 
	finish         	    	            : std_logic;
end record e2p_rd_p ;	


type w25qxx_rd_q is record
        req                           	: std_logic;
        addr                          	: std_logic_vector(23 downto 0);         	 
        len                           	: std_logic_vector(15 downto 0);  
end record w25qxx_rd_q ;
type w25qxx_rd_p is record
        data                     	  	: std_logic_vector(7 downto 0); 	
        dv               			  	: std_logic ;
        finish                   	  	: std_logic ; 
end record w25qxx_rd_p ;	
type w25qxx_wr_q is record
        req                             : std_logic;
        addr                            : std_logic_vector(23 downto 0);          
        len                             : std_logic_vector(15 downto 0);             
        data                            : std_logic_vector(7 downto 0); 
end record w25qxx_wr_q ;
type w25qxx_wr_p is record
        finish                          : std_logic ;
        data_req                        : std_logic ;
end record w25qxx_wr_p ;

--====================================
-- ddr3 type record
--==================================== 
constant DDR_NUM          		    	: integer := 2	; 		--板卡上DDR的数量
constant ROW_WIDTH                      : integer := 14 ;		--ddr芯片参数
constant COL_WIDTH                      : integer := 10 ;		--ddr芯片参数
constant BANK_WIDTH                     : integer := 3 ;		--ddr芯片参数
constant RANK_WIDTH                     : integer := DDR_NUM / 2 ;		--ddr芯片参数
constant DQ_WIDTH                       : integer := 16 ;		--ddr芯片参数
constant nCK_PER_CLK                    : integer := 4 ;		--与IP 配置一致

constant ADDR_WIDTH                     : integer := 28 ; 
constant APP_DATA_WIDTH                 : integer := 256 ;				-- 用户数据宽度		
constant APP_MASK_WIDTH                 : integer :=  32 ;
 
type ddr3_rd_q is record
        req                           	: std_logic;
        addr                          	: std_logic_vector( 28 downto 0 );         	 
        len                           	: std_logic_vector( 15 downto 0 );  
end record ddr3_rd_q ;
type ddr3_rd_p is record
        data                     	  	: std_logic_vector( 255 downto 0); 	
        dv               			  	: std_logic ;
        finish                   	  	: std_logic ; 
end record ddr3_rd_p ;	
type ddr3_wr_q is record
        req                             : std_logic;
        addr                            : std_logic_vector( 28 downto 0);          
        len                             : std_logic_vector( 15 downto 0);             
        data                            : std_logic_vector( 255 downto 0); 
end record ddr3_wr_q ;
type ddr3_wr_p is record
        finish                          : std_logic ;
        data_req                        : std_logic ;
end record ddr3_wr_p ;	
 	
 
type usr_ddr3_rd_q is record
        req                           	: std_logic;
        addr                          	: std_logic_vector( 28 downto 0 );         	 
        len                           	: std_logic_vector( 15 downto 0 );  
end record usr_ddr3_rd_q ;
type usr_ddr3_rd_p is record
        data                     	  	: std_logic_vector( 255 downto 0); 	
        ack               			  	: std_logic ;
        dv               			  	: std_logic ;
        finish                   	  	: std_logic ; 
end record usr_ddr3_rd_p ;	
type usr_ddr3_wr_q is record
        req                             : std_logic;
        addr                            : std_logic_vector( 28 downto 0);          
        len                             : std_logic_vector( 15 downto 0);             
        data                            : std_logic_vector( 255 downto 0); 
end record usr_ddr3_wr_q ;
type usr_ddr3_wr_p is record
        finish                          : std_logic ;
        ack                             : std_logic ;
        data_req                        : std_logic ;
end record usr_ddr3_wr_p ;	

type ddr3_app_q is record
        addr 			                : std_logic_vector( 28 downto 0);
        cmd 			                : std_logic_vector(2 downto 0);		
        en 			         	        : std_logic;		
        wdf_data		                : std_logic_vector( 255 downto 0);	
        wdf_end		         	        : std_logic;		
        wdf_mask		                : std_logic_vector( 31 downto 0);			
        wdf_wren		                : std_logic;	
end record ddr3_app_q ;
type ddr3_app_p is record
        rd_data		         	        : std_logic_vector( 255 downto 0);	 	
        rd_data_end	         	        : std_logic;		
        rd_data_valid	                : std_logic;	
        rdy			         	        : std_logic;		
        wdf_rdy		         	        : std_logic;  	  			
        init_complete         	        : std_logic;
end record ddr3_app_p ;	
--=====================================================================================================================================
-- function define
--=====================================================================================================================================
function icmp_checksum_func
   ( data  			: std_logic_vector(31 downto 0))
    return std_logic_vector;
function ip_checksum_func
   ( local_ip       : in std_logic_vector (31 downto 0);
    remote_ip       : in std_logic_vector (31 downto 0);
    ip_length       : in std_logic_vector (15 downto 0);
    ip_id           : in std_logic_vector (15 downto 0);
    ip_version 	    : in std_logic_vector (15 downto 0);
    ip_fragment 	: in std_logic_vector (15 downto 0);
    ip_ttl          : in std_logic_vector (15 downto 0))
    return std_logic_vector;
 
--====================================
-- procedure define
--====================================
procedure re ( signal input 			: in std_logic ;
               signal rise 				: out std_logic ;
               signal r 				: inout std_logic;
               signal rr 				: inout std_logic);
procedure fe ( signal input 			: in std_logic ; 
               signal fall 				: out std_logic ;
               signal r 				: inout std_logic;
               signal rr 				: inout std_logic);
procedure de ( signal input 			: in std_logic ;
               signal rise 				: out std_logic ;
               signal fall 				: out std_logic ; 
               signal r 				: inout std_logic;
               signal rr 				: inout std_logic);
procedure cnt     ( signal counter 			: inout integer ;
                    signal en 				: in std_logic );			   
procedure cntloop ( signal counter 			: inout integer ;
                    constant higher_boundary 	: in integer  );
procedure cntonce ( signal counter 			: inout integer ;
                    constant higher_boundary 	: in integer  );
procedure cntimg (  signal cnt_x 			    : inout integer ;
                    signal cnt_y 			    : inout integer ;
                    signal img_en 				: in std_logic ;			
                    constant img_width 			: in integer  ;					
                    constant img_height 		: in integer  );
	
procedure broaden4 ( signal input 			: in std_logic ;		
                     signal output 			: out std_logic ; 
                     signal br4_array 		: inout std_logic_vector(3 downto 0)); 
procedure broaden16 ( signal input 			: in std_logic ;		
                     signal output 			: out std_logic ; 
                     signal br16_array 		: inout std_logic_vector(15 downto 0));			
end package  mt_lib ;
package body mt_lib is

--====================================
-- function discribe
--====================================
function icmp_checksum_func
    ( data 			: in std_logic_vector (31 downto 0))
    return std_logic_vector is
    variable a      : std_logic_vector(16 downto 0);
    variable b      : std_logic_vector(15 downto 0);
    begin
    	a           := '0' & X"0000" + data (31 downto 16) + data (15 downto 0);
    	b           := not ( a (16) + a (15 downto 0)) ;
    	return b ;
    end icmp_checksum_func ;
function ip_checksum_func
    ( local_ip 		: in std_logic_vector (31 downto 0);
      remote_ip 	: in std_logic_vector (31 downto 0);
      ip_length 	: in std_logic_vector (15 downto 0);
      ip_id 		: in std_logic_vector (15 downto 0);
      ip_version 	: in std_logic_vector (15 downto 0);
      ip_fragment 	: in std_logic_vector (15 downto 0);
      ip_ttl 		: in std_logic_vector (15 downto 0))
    return std_logic_vector is
    variable a      : std_logic_vector(31 downto 0);
    variable b      : std_logic_vector(15 downto 0);
    begin
    	a           := X"00000000" + local_ip (31 downto 16) + local_ip (15 downto 0) + remote_ip (31 downto 16) + remote_ip (15 downto 0)+ ip_length + ip_id + ip_version + ip_fragment + ip_ttl ;
    	b           := not ( a (31 downto 16) + a (15 downto 0)) ;
    	return b ;
    end ip_checksum_func ; 
 
--====================================
-- procedure discribe
--====================================
procedure re (
    signal input 			: in std_logic ;
    signal rise 			: out std_logic ;
    signal r 				: inout std_logic;
    signal rr 				: inout std_logic ) is
    begin
        r 	                <= input ;
        rr 	                <= r ;
        rise 		        <= r and ( not rr );
    end re ;
	
procedure fe (
    signal input 			: in std_logic ;
    signal fall 			: out std_logic ;
    signal r 				: inout std_logic ;
    signal rr 				: inout std_logic ) is
    begin
        r 				    <= input ;
        rr 				    <= r ;
        fall			    <= rr and ( not r );
    end fe ;
	
procedure de (
    signal input 			: in std_logic ;
    signal rise 			: out std_logic ;
    signal fall 			: out std_logic ;
    signal r 				: inout std_logic;
    signal rr 				: inout std_logic  )is
    begin
        r 	                <= input ;
        rr 	                <= r ;
        rise		        <= r and ( not rr );
        fall		        <= rr and ( not r );
    end de ;
 
procedure cnt ( signal counter 			: inout integer ;
                signal en 				: in std_logic )is
    begin
        if ( en = '1' ) then
            counter <= counter + 1 ;
        else
            counter <= 0 ;
        end if;
    end cnt ;	
	
procedure cntloop ( signal    counter 					: inout integer ;
                    constant  higher_boundary 			: in integer )is
    begin
        if ( counter < higher_boundary ) then
            counter <= counter + 1 ;
        else
            counter <= 0 ;
        end if;
    end cntloop ;	
	
procedure cntonce ( signal    counter 					: inout integer ;
                    constant 	  higher_boundary 		: in integer )is
    begin
        if ( counter < higher_boundary ) then
            counter <= counter + 1 ;
        end if;
    end cntonce ;			
procedure cntimg (  signal cnt_x 			    : inout integer ;
                    signal cnt_y 			    : inout integer ;
                    signal img_en 				: in std_logic ;
                    constant img_width 			: in integer  ;		
                    constant img_height 		: in integer  ) is 
    begin
        if ( img_en = '1' ) then
            if cnt_x < img_width - 1  then 
				cnt_x <= cnt_x + 1 ;
			else 
				cnt_x <= 0 ;
			end if ;
			if cnt_x = img_width - 1 then 
				if cnt_y < img_height - 1 then 
					cnt_y <= cnt_y + 1 ;
				end if ;
			end if ;
        else
            cnt_x <= 0 ; cnt_y <= 0 ;
        end if;
    end cntimg ;
procedure broaden4 ( signal input 			: in std_logic ;	
                     signal output 			: out std_logic ;   	
                     signal br4_array 		: inout std_logic_vector(3 downto 0) ) is 
    begin
            br4_array 	<= br4_array(2 downto 0) &   input ; 
			output 		<= br4_array(3) or br4_array(2) or br4_array(1) or br4_array(0) or input ;
    end broaden4 ;

procedure broaden16 ( signal input 			: in std_logic ;	
                     signal output 			: out std_logic ;  
                     signal br16_array 		: inout std_logic_vector(15 downto 0) ) is 
    begin
            br16_array <= br16_array(14 downto 0) & input ; 
			output 	   <= br16_array(15) or br16_array(14) or br16_array(13) or br16_array(12) or br16_array(11) or br16_array(10) 
			           or br16_array(9 ) or br16_array(8 ) or br16_array(7 ) or br16_array(6 ) or br16_array(5 ) or br16_array(4 ) 
					   or br16_array(3 ) or br16_array(2 ) or br16_array(1 ) or br16_array(0 ) or input ;
    end broaden16 ;	
end mt_lib ;