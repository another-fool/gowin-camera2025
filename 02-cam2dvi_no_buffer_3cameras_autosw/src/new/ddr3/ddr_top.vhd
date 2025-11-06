-- ddr3 multy arbitration module
-- liuyunfeng
-- 2025-10-17

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.mt_lib.all; 
entity ddr_top is port (   		 		
    rst_n            		    : in std_logic ;  
    --usr wr port 
    usr1_ddr3_wr_q              : in usr_ddr3_wr_q ;
    usr1_ddr3_wr_p              : buffer usr_ddr3_wr_p ;
    usr2_ddr3_wr_q              : in usr_ddr3_wr_q ;
    usr2_ddr3_wr_p              : buffer usr_ddr3_wr_p ;
    usr3_ddr3_wr_q              : in usr_ddr3_wr_q ;
    usr3_ddr3_wr_p              : buffer usr_ddr3_wr_p ;
    usr4_ddr3_wr_q              : in usr_ddr3_wr_q ;
    usr4_ddr3_wr_p              : buffer usr_ddr3_wr_p ;  
    --usr rd port    
    usr1_ddr3_rd_q              : in usr_ddr3_rd_q ;
    usr1_ddr3_rd_p              : buffer usr_ddr3_rd_p ;
    usr2_ddr3_rd_q              : in usr_ddr3_rd_q ;
    usr2_ddr3_rd_p              : buffer usr_ddr3_rd_p ;
    usr3_ddr3_rd_q              : in usr_ddr3_rd_q ;
    usr3_ddr3_rd_p              : buffer usr_ddr3_rd_p ;
    usr4_ddr3_rd_q              : in usr_ddr3_rd_q ;
    usr4_ddr3_rd_p              : buffer usr_ddr3_rd_p ;   
	--ddr io	
	dma_clk                     : in std_logic;
	init_complete               : in std_logic;

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

end ddr_top ;
architecture rtl of ddr_top is  
constant CROSS_DOMAIN_DELAY             : integer := 4 ;

constant INIT                           : std_logic_vector(7 downto 0) := X"01" ;
constant IDLE                           : std_logic_vector(7 downto 0) := X"02" ;
constant USR1_WR_PRE                    : std_logic_vector(7 downto 0) := X"03" ;
constant USR2_WR_PRE                    : std_logic_vector(7 downto 0) := X"04" ;
constant USR3_WR_PRE                    : std_logic_vector(7 downto 0) := X"05" ;
constant USR4_WR_PRE                    : std_logic_vector(7 downto 0) := X"06" ;
constant USR1_WR_REQ                    : std_logic_vector(7 downto 0) := X"07" ;
constant USR1_WR                        : std_logic_vector(7 downto 0) := X"08" ;
constant USR1_WR_END                    : std_logic_vector(7 downto 0) := X"09" ;
constant USR2_WR_REQ                    : std_logic_vector(7 downto 0) := X"0a" ;
constant USR2_WR                        : std_logic_vector(7 downto 0) := X"0b" ;
constant USR2_WR_END                    : std_logic_vector(7 downto 0) := X"0c" ;
constant USR3_WR_REQ                    : std_logic_vector(7 downto 0) := X"0d" ;
constant USR3_WR                        : std_logic_vector(7 downto 0) := X"0e" ;
constant USR3_WR_END                    : std_logic_vector(7 downto 0) := X"0f" ;
constant USR4_WR_REQ                    : std_logic_vector(7 downto 0) := X"10" ;
constant USR4_WR                        : std_logic_vector(7 downto 0) := X"11" ;
constant USR4_WR_END                    : std_logic_vector(7 downto 0) := X"12" ;
constant USR1_RD_PRE                    : std_logic_vector(7 downto 0) := X"13" ;
constant USR1_RD_REQ                    : std_logic_vector(7 downto 0) := X"14" ;
constant USR1_RD                        : std_logic_vector(7 downto 0) := X"15" ;
constant USR1_RD_END                    : std_logic_vector(7 downto 0) := X"16" ;
constant USR2_RD_PRE                    : std_logic_vector(7 downto 0) := X"17" ;
constant USR2_RD_REQ                    : std_logic_vector(7 downto 0) := X"18" ;
constant USR2_RD                        : std_logic_vector(7 downto 0) := X"19" ;
constant USR2_RD_END                    : std_logic_vector(7 downto 0) := X"1a" ;
constant USR3_RD_PRE                    : std_logic_vector(7 downto 0) := X"1b" ;
constant USR3_RD_REQ                    : std_logic_vector(7 downto 0) := X"1c" ;
constant USR3_RD                        : std_logic_vector(7 downto 0) := X"1d" ;
constant USR3_RD_END                    : std_logic_vector(7 downto 0) := X"1e" ;
constant USR4_RD_PRE                    : std_logic_vector(7 downto 0) := X"1f" ;
constant USR4_RD_REQ                    : std_logic_vector(7 downto 0) := X"20" ;
constant USR4_RD                        : std_logic_vector(7 downto 0) := X"21" ;
constant USR4_RD_END                    : std_logic_vector(7 downto 0) := X"22" ;
constant TIMEOUT                        : std_logic_vector(7 downto 0) := X"23" ;  
signal cs                               : std_logic_vector(7 downto 0) := INIT ;
signal ns                               : std_logic_vector(7 downto 0) := INIT ;  
signal ddr3_rd_q				        : ddr3_rd_q ;		
signal ddr3_rd_p				        : ddr3_rd_p ;		
signal ddr3_wr_q				        : ddr3_wr_q ;		
signal ddr3_wr_p				        : ddr3_wr_p ;   
signal time_out                         : std_logic_vector(23 downto 0);  
begin  

mem_burst_0 : entity work.mem_burst (rtl) port map ( 
    clk 			        => dma_clk 				,
    rst_n 			        => rst_n 				,
	ddr3_rd_q				=> ddr3_rd_q	        ,
	ddr3_rd_p				=> ddr3_rd_p		    ,
	ddr3_wr_q				=> ddr3_wr_q	        ,
	ddr3_wr_p				=> ddr3_wr_p	        ,
    rd_data		    	    => rd_data		    	,			   
    rd_data_end	    	    => rd_data_end	    	,
    rd_data_valid		    => rd_data_valid		,
    cmd_ready			    => cmd_ready			,
    wr_data_rdy		        => wr_data_rdy		    ,
    init_calib_complete     => init_complete        ,
    addr 	                => addr 	           ,    
    cmd 	                => cmd 	               ,
    cmd_en 		            => cmd_en 		       ,    
    wr_data                 => wr_data             , 	 
    wr_data_end	            => wr_data_end	       ,    
    wr_data_mask            => wr_data_mask        ,   
    wr_data_en              => wr_data_en          );  


process( rst_n,dma_clk )
    begin
        if rst_n ='0' then
            cs <= IDLE;
        elsif rising_edge( dma_clk ) then
            cs <= ns ;
        end if;
end process;

process( cs,usr1_ddr3_wr_q.req,usr2_ddr3_wr_q.req,usr3_ddr3_wr_q.req,usr4_ddr3_wr_q.req,
         usr1_ddr3_rd_q.req,usr2_ddr3_rd_q.req,usr3_ddr3_rd_q.req,usr4_ddr3_rd_q.req,
         ddr3_wr_p.data_req,ddr3_wr_p.finish,
         ddr3_rd_p.dv,ddr3_rd_p.finish,
         init_complete,time_out )
    begin
        case cs is     
            when INIT                   =>  if ( init_complete = '1' ) then           		--判断ddr初始化是否完成
                                                ns <=  IDLE ;
                                            else
                                                ns <=  INIT ;
                                            end if;
            when IDLE                   =>  
                                               if ( usr1_ddr3_rd_q.req = '1' ) then  ns <= USR1_RD_PRE ; 
                                            elsif ( usr1_ddr3_wr_q.req = '1' ) then  ns <= USR1_WR_PRE ; 
                                            elsif ( usr2_ddr3_wr_q.req = '1' ) then  ns <= USR2_WR_PRE ; 
                                            elsif ( usr3_ddr3_wr_q.req = '1' ) then  ns <= USR3_WR_PRE ; 
                                            elsif ( usr4_ddr3_wr_q.req = '1' ) then  ns <= USR4_WR_PRE ; 
                                            elsif ( usr2_ddr3_rd_q.req = '1' ) then  ns <= USR2_RD_PRE ; 
                                            elsif ( usr3_ddr3_rd_q.req = '1' ) then  ns <= USR3_RD_PRE ; 
                                            elsif ( usr4_ddr3_rd_q.req = '1' ) then  ns <= USR4_RD_PRE ; 
                                            else                                     ns <= IDLE        ;   end if; 

            when USR1_WR_PRE            =>  if time_out >= CROSS_DOMAIN_DELAY then   ns <= USR1_WR_REQ ; 
                                            else                                     ns <= USR1_WR_PRE ;   end if;
            when USR2_WR_PRE            =>  if time_out >= CROSS_DOMAIN_DELAY then   ns <= USR2_WR_REQ ; 
                                            else                                     ns <= USR2_WR_PRE ;   end if;   
            when USR3_WR_PRE            =>  if time_out >= CROSS_DOMAIN_DELAY then   ns <= USR3_WR_REQ ; 
                                            else                                     ns <= USR3_WR_PRE ;   end if;      
            when USR4_WR_PRE            =>  if time_out >= CROSS_DOMAIN_DELAY then   ns <= USR4_WR_REQ ;
                                            else                                     ns <= USR4_WR_PRE ;   end if;  

            when USR1_WR_REQ            =>  if time_out >= X"00ff" then              ns <= TIMEOUT     ;
                                            elsif ( ddr3_wr_p.data_req = '1' ) then  ns <= USR1_WR     ;
                                            else                                     ns <= USR1_WR_REQ ;  end if ;
            when USR1_WR                =>  if time_out >= X"0fff" then 			 ns <= TIMEOUT     ;
                                            elsif ( ddr3_wr_p.finish = '1' ) then    ns <= USR1_WR_END ;
                                            else                                     ns <= USR1_WR     ;  end if ;
            when USR1_WR_END            =>  if time_out >= CROSS_DOMAIN_DELAY then   ns <= IDLE ;
                                            else                                     ns <= USR1_WR_END ;   end if;      
            when USR2_WR_REQ            =>  if time_out >= X"00ff" then              ns <= TIMEOUT     ;
                                            elsif ( ddr3_wr_p.data_req = '1' ) then  ns <= USR2_WR     ;
                                            else                                     ns <= USR2_WR_REQ ;  end if ;
            when USR2_WR                =>  if time_out >= X"0fff" then 			 ns <= TIMEOUT     ;
                                            elsif ( ddr3_wr_p.finish = '1' ) then    ns <= USR2_WR_END ;
                                            else                                     ns <= USR2_WR     ;  end if ;
            when USR2_WR_END            =>  if time_out >= CROSS_DOMAIN_DELAY then   ns <= IDLE ;
                                            else                                     ns <= USR2_WR_END ;   end if;  
            when USR3_WR_REQ            =>  if time_out >= X"00ff" then              ns <= TIMEOUT     ;
                                            elsif ( ddr3_wr_p.data_req = '1' ) then  ns <= USR3_WR     ;
                                            else                                     ns <= USR3_WR_REQ ;  end if ;
            when USR3_WR                =>  if time_out >= X"0fff" then 			 ns <= TIMEOUT     ;
                                            elsif ( ddr3_wr_p.finish = '1' ) then    ns <= USR3_WR_END ;
                                            else                                     ns <= USR3_WR     ;  end if ;
            when USR3_WR_END            =>  if time_out >= CROSS_DOMAIN_DELAY then   ns <= IDLE ;
                                            else                                     ns <= USR3_WR_END ;   end if; 
            when USR4_WR_REQ            =>  if time_out >= X"00ff" then              ns <= TIMEOUT     ;
                                            elsif ( ddr3_wr_p.data_req = '1' ) then  ns <= USR4_WR     ;
                                            else                                     ns <= USR4_WR_REQ ;  end if ;
            when USR4_WR                =>  if time_out >= X"0fff" then 			 ns <= TIMEOUT     ;
                                            elsif ( ddr3_wr_p.finish = '1' ) then    ns <= USR4_WR_END ;
                                            else                                     ns <= USR4_WR     ;  end if ;
            when USR4_WR_END            =>  if time_out >= CROSS_DOMAIN_DELAY then   ns <= IDLE ;
                                            else                                     ns <= USR4_WR_END ;   end if; 
            when USR1_RD_PRE            =>  if time_out >= CROSS_DOMAIN_DELAY then   ns <= USR1_RD_REQ ; 
                                            else                                     ns <= USR1_RD_PRE ;   end if;    
            when USR1_RD_REQ            =>  if time_out >= X"00ff" then              ns <= TIMEOUT     ;
                                            elsif ( ddr3_rd_p.dv = '1' ) then        ns <= USR1_RD     ;
                                            else                                     ns <= USR1_RD_REQ ;  end if ;
            when USR1_RD                =>  if time_out >= X"0fff" then 			 ns <= TIMEOUT     ;
                                            elsif ( ddr3_rd_p.finish = '1' ) then    ns <= USR1_RD_END ;
                                            else                                     ns <= USR1_RD     ;  end if ;
            when USR1_RD_END            =>  if time_out >= CROSS_DOMAIN_DELAY then   ns <= IDLE ;
                                            else                                     ns <= USR1_RD_END ;   end if; 
            when USR2_RD_PRE            =>  if time_out >= CROSS_DOMAIN_DELAY then   ns <= USR2_RD_REQ ; 
                                            else                                     ns <= USR2_RD_PRE ;   end if;       
            when USR2_RD_REQ            =>  if time_out >= X"00ff" then              ns <= TIMEOUT     ;
                                            elsif ( ddr3_rd_p.dv = '1' ) then        ns <= USR2_RD     ;
                                            else                                     ns <= USR2_RD_REQ ;  end if ;
            when USR2_RD                =>  if time_out >= X"0fff" then 			 ns <= TIMEOUT     ;
                                            elsif ( ddr3_rd_p.finish = '1' ) then    ns <= USR2_RD_END ;
                                            else                                     ns <= USR2_RD     ;  end if ;
            when USR2_RD_END            =>  if time_out >= CROSS_DOMAIN_DELAY then   ns <= IDLE ;
                                            else                                     ns <= USR2_RD_END ;   end if; 
            when USR3_RD_PRE            =>  if time_out >= CROSS_DOMAIN_DELAY then   ns <= USR3_RD_REQ ; 
                                            else                                     ns <= USR3_RD_PRE ;   end if;    
            when USR3_RD_REQ            =>  if time_out >= X"00ff" then              ns <= TIMEOUT     ;
                                            elsif ( ddr3_rd_p.dv = '1' ) then        ns <= USR3_RD     ;
                                            else                                     ns <= USR3_RD_REQ ;  end if ;
            when USR3_RD                =>  if time_out >= X"0fff" then 			 ns <= TIMEOUT     ;
                                            elsif ( ddr3_rd_p.finish = '1' ) then    ns <= USR3_RD_END ;
                                            else                                     ns <= USR3_RD     ;  end if ;
            when USR3_RD_END            =>  if time_out >= CROSS_DOMAIN_DELAY then   ns <= IDLE ;
                                            else                                     ns <= USR3_RD_END ;   end if; 
            when USR4_RD_PRE            =>  if time_out >= CROSS_DOMAIN_DELAY then   ns <= USR4_RD_REQ ; 
                                            else                                     ns <= USR4_RD_PRE ;   end if;      
            when USR4_RD_REQ            =>  if time_out >= X"00ff" then              ns <= TIMEOUT     ;
                                            elsif ( ddr3_rd_p.dv = '1' ) then        ns <= USR4_RD     ;
                                            else                                     ns <= USR4_RD_REQ ;  end if ;
            when USR4_RD                =>  if time_out >= X"0fff" then 			 ns <= TIMEOUT     ;
                                            elsif ( ddr3_rd_p.finish = '1' ) then    ns <= USR4_RD_END ;
                                            else                                     ns <= USR4_RD     ;  end if ;
            when USR4_RD_END            =>  if time_out >= CROSS_DOMAIN_DELAY then   ns <= IDLE ;
                                            else                                     ns <= USR4_RD_END ;   end if; 
            when TIMEOUT                =>      ns <= IDLE ;
            when others                 =>      ns <= IDLE ;                                        
        end case;
end process;

process( rst_n,dma_clk )
    begin
        if rst_n ='0' then
             time_out <= ( others => '0' ) ;
             ddr3_wr_q.req        <= '0' ; 
             ddr3_rd_q.req        <= '0' ; 
        elsif rising_edge( dma_clk ) then
             if ( cs /= ns ) then  time_out <= ( others => '0' ) ; else time_out <= time_out + 1 ; end if;
             if ( cs = USR1_WR_REQ or  cs = USR2_WR_REQ or  cs = USR3_WR_REQ or  cs = USR4_WR_REQ ) then
                ddr3_wr_q.req        <= '1' ;   else ddr3_wr_q.req        <= '0' ;    end if;
             if ( cs = USR1_RD_REQ or  cs = USR2_RD_REQ or  cs = USR3_RD_REQ or  cs = USR4_RD_REQ ) then
                ddr3_rd_q.req        <= '1' ;    else ddr3_rd_q.req        <= '0' ;    end if;
        end if;
end process;

process( rst_n,dma_clk )
    begin
        if rst_n ='0' then
            ddr3_wr_q.addr       <= ( others => '0' ) ;
            ddr3_wr_q.len        <= ( others => '0' ) ; 
        elsif rising_edge( dma_clk ) then
             case cs is     
                when USR1_WR_REQ | USR1_WR  =>  ddr3_wr_q.addr   <= usr1_ddr3_wr_q.addr ; ddr3_wr_q.len    <= usr1_ddr3_wr_q.len  ; 
                when USR2_WR_REQ | USR2_WR  =>  ddr3_wr_q.addr   <= usr2_ddr3_wr_q.addr ; ddr3_wr_q.len    <= usr2_ddr3_wr_q.len  ; 
                when USR3_WR_REQ | USR3_WR  =>  ddr3_wr_q.addr   <= usr3_ddr3_wr_q.addr ; ddr3_wr_q.len    <= usr3_ddr3_wr_q.len  ; 
                when USR4_WR_REQ | USR4_WR  =>  ddr3_wr_q.addr   <= usr4_ddr3_wr_q.addr ; ddr3_wr_q.len    <= usr4_ddr3_wr_q.len  ; 
                when others                 =>  null ;
             end case;
        end if;
end process;
process( rst_n,dma_clk )
    begin
        if rst_n ='0' then
            ddr3_rd_q.addr       <= ( others => '0' ) ;
            ddr3_rd_q.len        <= ( others => '0' ) ;
        elsif rising_edge( dma_clk ) then
             case cs is     
                when USR1_RD_REQ | USR1_RD  =>  ddr3_rd_q.addr   <= usr1_ddr3_rd_q.addr ; ddr3_rd_q.len    <= usr1_ddr3_rd_q.len  ;
                when USR2_RD_REQ | USR2_RD  =>  ddr3_rd_q.addr   <= usr2_ddr3_rd_q.addr ; ddr3_rd_q.len    <= usr2_ddr3_rd_q.len  ;
                when USR3_RD_REQ | USR3_RD  =>  ddr3_rd_q.addr   <= usr3_ddr3_rd_q.addr ; ddr3_rd_q.len    <= usr3_ddr3_rd_q.len  ;
                when USR4_RD_REQ | USR4_RD  =>  ddr3_rd_q.addr   <= usr4_ddr3_rd_q.addr ; ddr3_rd_q.len    <= usr4_ddr3_rd_q.len  ;
                when others                 =>  null ;
             end case;
        end if;
end process; 
-- arbitration write data_req  read dv read data
ddr3_wr_q.data          <=  usr1_ddr3_wr_q.data     when ( cs = USR1_WR_REQ or cs = USR1_WR ) else
                            usr2_ddr3_wr_q.data     when ( cs = USR2_WR_REQ or cs = USR2_WR ) else
                            usr3_ddr3_wr_q.data     when ( cs = USR3_WR_REQ or cs = USR3_WR ) else
                            usr4_ddr3_wr_q.data     when ( cs = USR4_WR_REQ or cs = USR4_WR ) else  ( others => '0' ) ;    
usr1_ddr3_wr_p.data_req <=  ddr3_wr_p.data_req      when ( cs = USR1_WR_REQ or cs = USR1_WR ) else '0' ;
usr2_ddr3_wr_p.data_req <=  ddr3_wr_p.data_req      when ( cs = USR2_WR_REQ or cs = USR2_WR ) else '0' ;
usr3_ddr3_wr_p.data_req <=  ddr3_wr_p.data_req      when ( cs = USR3_WR_REQ or cs = USR3_WR ) else '0' ;
usr4_ddr3_wr_p.data_req <=  ddr3_wr_p.data_req      when ( cs = USR4_WR_REQ or cs = USR4_WR ) else '0' ;
usr1_ddr3_rd_p.data     <=  ddr3_rd_p.data          when ( cs = USR1_RD_REQ or cs = USR1_RD ) else ( others => '0' ) ;
usr1_ddr3_rd_p.dv       <=  ddr3_rd_p.dv            when ( cs = USR1_RD_REQ or cs = USR1_RD ) else '0' ;
usr2_ddr3_rd_p.data     <=  ddr3_rd_p.data          when ( cs = USR2_RD_REQ or cs = USR2_RD ) else ( others => '0' ) ;
usr2_ddr3_rd_p.dv       <=  ddr3_rd_p.dv            when ( cs = USR2_RD_REQ or cs = USR2_RD ) else '0' ;
usr3_ddr3_rd_p.data     <=  ddr3_rd_p.data          when ( cs = USR3_RD_REQ or cs = USR3_RD ) else ( others => '0' ) ;
usr3_ddr3_rd_p.dv       <=  ddr3_rd_p.dv            when ( cs = USR3_RD_REQ or cs = USR3_RD ) else '0' ;
usr4_ddr3_rd_p.data     <=  ddr3_rd_p.data          when ( cs = USR4_RD_REQ or cs = USR4_RD ) else ( others => '0' ) ;
usr4_ddr3_rd_p.dv       <=  ddr3_rd_p.dv            when ( cs = USR4_RD_REQ or cs = USR4_RD ) else '0' ;    
-- gen finish 
process( rst_n,dma_clk )
    begin
        if rst_n ='0' then
            usr1_ddr3_wr_p.finish    <= '0' ;  usr2_ddr3_wr_p.finish    <= '0' ;  usr3_ddr3_wr_p.finish    <= '0' ;  usr4_ddr3_wr_p.finish    <= '0' ; 
            usr1_ddr3_rd_p.finish    <= '0' ;  usr2_ddr3_rd_p.finish    <= '0' ;  usr3_ddr3_rd_p.finish    <= '0' ;  usr4_ddr3_rd_p.finish    <= '0' ; 
        elsif rising_edge( dma_clk ) then
            if ( cs = USR1_WR_END ) then usr1_ddr3_wr_p.finish    <= '1' ;  else usr1_ddr3_wr_p.finish    <= '0' ;  end if; 
            if ( cs = USR2_WR_END ) then usr2_ddr3_wr_p.finish    <= '1' ;  else usr2_ddr3_wr_p.finish    <= '0' ;  end if; 
            if ( cs = USR3_WR_END ) then usr3_ddr3_wr_p.finish    <= '1' ;  else usr3_ddr3_wr_p.finish    <= '0' ;  end if; 
            if ( cs = USR4_WR_END ) then usr4_ddr3_wr_p.finish    <= '1' ;  else usr4_ddr3_wr_p.finish    <= '0' ;  end if; 
            if ( cs = USR1_RD_END ) then usr1_ddr3_rd_p.finish    <= '1' ;  else usr1_ddr3_rd_p.finish    <= '0' ;  end if; 
            if ( cs = USR2_RD_END ) then usr2_ddr3_rd_p.finish    <= '1' ;  else usr2_ddr3_rd_p.finish    <= '0' ;  end if; 
            if ( cs = USR3_RD_END ) then usr3_ddr3_rd_p.finish    <= '1' ;  else usr3_ddr3_rd_p.finish    <= '0' ;  end if; 
            if ( cs = USR4_RD_END ) then usr4_ddr3_rd_p.finish    <= '1' ;  else usr4_ddr3_rd_p.finish    <= '0' ;  end if; 
        end if;
end process;
--***************************************************************
-- gen ack
--***************************************************************
process( rst_n,dma_clk )
    begin
        if rst_n ='0' then
            usr1_ddr3_wr_p.ack    <= '0' ;  usr2_ddr3_wr_p.ack    <= '0' ;  usr3_ddr3_wr_p.ack    <= '0' ;  usr4_ddr3_wr_p.ack    <= '0' ; 
            usr1_ddr3_rd_p.ack    <= '0' ;  usr2_ddr3_rd_p.ack    <= '0' ;  usr3_ddr3_rd_p.ack    <= '0' ;  usr4_ddr3_rd_p.ack    <= '0' ; 
        elsif rising_edge( dma_clk ) then
            if ( cs = USR1_WR_PRE ) then usr1_ddr3_wr_p.ack    <= '1' ;  else usr1_ddr3_wr_p.ack    <= '0' ;  end if; 
            if ( cs = USR2_WR_PRE ) then usr2_ddr3_wr_p.ack    <= '1' ;  else usr2_ddr3_wr_p.ack    <= '0' ;  end if; 
            if ( cs = USR3_WR_PRE ) then usr3_ddr3_wr_p.ack    <= '1' ;  else usr3_ddr3_wr_p.ack    <= '0' ;  end if; 
            if ( cs = USR4_WR_PRE ) then usr4_ddr3_wr_p.ack    <= '1' ;  else usr4_ddr3_wr_p.ack    <= '0' ;  end if; 
            if ( cs = USR1_RD_PRE ) then usr1_ddr3_rd_p.ack    <= '1' ;  else usr1_ddr3_rd_p.ack    <= '0' ;  end if; 
            if ( cs = USR2_RD_PRE ) then usr2_ddr3_rd_p.ack    <= '1' ;  else usr2_ddr3_rd_p.ack    <= '0' ;  end if; 
            if ( cs = USR3_RD_PRE ) then usr3_ddr3_rd_p.ack    <= '1' ;  else usr3_ddr3_rd_p.ack    <= '0' ;  end if; 
            if ( cs = USR4_RD_PRE ) then usr4_ddr3_rd_p.ack    <= '1' ;  else usr4_ddr3_rd_p.ack    <= '0' ;  end if; 
        end if;
end process; 
 
end rtl ;