library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.mt_lib.all; 
entity ethernet_top is
    port (
        clk_pll_200                     : in  std_logic ; 
        clk                             : in  std_logic ;  
        rst_n                           : in  std_logic;   
		pa_link_state					: buffer std_logic ;		
		pb_link_state					: buffer std_logic ;		
		pc_link_state					: buffer std_logic ;		
        --ethernet port a                  
        MGT_CLK0_P                      : in  std_logic ;
        MGT_CLK0_N                      : in  std_logic ;               
        MGT_TX0_P                       : out std_logic ;
        MGT_TX0_N                       : out std_logic ;
        MGT_RX0_P                       : in std_logic  ; 
        MGT_RX0_N                       : in std_logic  ;
        MGT_TX0_disable                 : out std_logic ;
        --ethernet port b                         
        MGT_TX1_P                       : out std_logic ;
        MGT_TX1_N                       : out std_logic ;
        MGT_RX1_P                       : in std_logic  ; 
        MGT_RX1_N                       : in std_logic  ;
        MGT_TX1_disable                 : out std_logic ;
        --ethernet port c    
        pa_phy_rx_rst_n                 : in std_logic;
        pb_phy_rx_rst_n                 : in std_logic;
        pc_phy_rx_rst_n                 : in std_logic;
        pa_phy_tx_rst_n                 : in std_logic;
        pb_phy_tx_rst_n                 : in std_logic;
        pc_phy_tx_rst_n                 : in std_logic;
        rgmii_rxc                       : in std_logic;
        rgmii_txd                       : buffer std_logic_vector(3 downto 0);
        rgmii_txctl                     : buffer std_logic;
        rgmii_txc                       : buffer std_logic;
        rgmii_rxd                       : in std_logic_vector(3 downto 0);
        rgmii_rxctl                     : in std_logic; 
        rgmii_reset                     : out std_logic;
        rgmii_phy_mdc     	            : out std_logic;
        rgmii_phy_mdio    	            : inout std_logic; 	 
        -- udp port a
		pa_phy_rx						: buffer phy_rx ;	
		pa_udp_tx_q						: in mac_tx_q ;		
		pa_udp_tx_p						: out mac_tx_p ;		
		pa_mac_tx_ack					: out mac_tx_ack ;		
		pa_local_net					: in net_type ;
        -- udp port b
		pb_phy_rx						: buffer phy_rx ;	
		pb_udp_tx_q						: in mac_tx_q ;		
		pb_udp_tx_p						: out mac_tx_p ;		
		pb_mac_tx_ack					: out mac_tx_ack ;		
		pb_local_net					: in net_type ;
        --udp port c
		pc_phy_rx						: buffer phy_rx ;	
		pc_udp_tx_q						: in mac_tx_q ;		
		pc_udp_tx_p						: out mac_tx_p ;		
		pc_mac_tx_ack					: out mac_tx_ack ;		
		pc_local_net					: in net_type );
end ethernet_top ;
architecture behaviral of ethernet_top is
--====================================
-- component
--====================================
component gig_ethernet_pcs_pma_0
    port(
      -- Transceiver Interface
        gtrefclk_p                  : in  std_logic;                          
        gtrefclk_n                  : in  std_logic;  
        gtrefclk_out                : out std_logic;                    
        gtrefclk_bufg_out           : out std_logic;                    
        txp                         : out std_logic;                    
        txn                         : out std_logic;                    
        rxp                         : in std_logic;                     
        rxn                         : in std_logic;                     
        resetdone                   : out std_logic;                    
        userclk_out                 : out std_logic;                           
        userclk2_out                : out std_logic;                           
        rxuserclk_out               : out std_logic;                         
        rxuserclk2_out              : out std_logic;                         
        pma_reset_out               : out std_logic;                    
       -- recclk_mmcm_locked_out     : out std_logic;
        mmcm_locked_out             : out std_logic;                    
        independent_clock_bufg      : in std_logic;                     
        -- GMII Interface                                               
        gmii_txd                    : in std_logic_vector(7 downto 0);  
        gmii_tx_en                  : in std_logic;                     
        gmii_tx_er                  : in std_logic;                     
        gmii_rxd                    : out std_logic_vector(7 downto 0); 
        gmii_rx_dv                  : out std_logic;                    
        gmii_rx_er                  : out std_logic;                    
        gmii_isolate                : out std_logic;                    
        -- Management: Alternative to MDIO Interface                    
        configuration_vector        : in std_logic_vector(4 downto 0);  
        an_interrupt                : out std_logic;                    
        an_adv_config_vector        : in std_logic_vector(15 downto 0); 
        an_restart_config           : in std_logic;                     
        -- General IO's         
        status_vector               : out std_logic_vector(15 downto 0);
        reset                       : in std_logic;                     
        signal_detect               : in std_logic;                     
        gt0_pll0outclk_out          : out std_logic;
        gt0_pll0outrefclk_out       : out std_logic;
        gt0_pll1outclk_out          : out std_logic;
        gt0_pll1outrefclk_out       : out std_logic;
        gt0_pll0refclklost_out      : out std_logic;
        gt0_pll0lock_out            : out std_logic
    );
end component; 
component gig_ethernet_pcs_pma_1
    port(
      -- Transceiver Interface
      gtrefclk                      : in  std_logic;                   
      gtrefclk_bufg                 : in  std_logic;
      txp                           : out std_logic;                   
      txn                           : out std_logic;                   
      rxp                           : in std_logic;                    
      rxn                           : in std_logic;                    
      resetdone                     : out std_logic;                   
      cplllock                      : out std_logic;                   
      mmcm_reset                    : out std_logic; 
    --  recclk_mmcm_reset             : out std_logic;    
      txoutclk                      : out std_logic;                     
      rxoutclk                      : out std_logic;                     
      userclk                       : in  std_logic;                     
      userclk2                      : in  std_logic;                     
      rxuserclk                     : in  std_logic;                   
      rxuserclk2                    : in  std_logic;                   
      pma_reset                     : in  std_logic;                    
      mmcm_locked                   : in  std_logic;                    
    --  recclk_mmcm_locked            : in std_logic;                   
      independent_clock_bufg        : in std_logic;   
      -- GMII Interface
      gmii_txd                      : in std_logic_vector(7 downto 0);  
      gmii_tx_en                    : in std_logic;                     
      gmii_tx_er                    : in std_logic;                     
      gmii_rxd                      : out std_logic_vector(7 downto 0); 
      gmii_rx_dv                    : out std_logic;                    
      gmii_rx_er                    : out std_logic;                    
      gmii_isolate                  : out std_logic;                    
      -- Management: Alternative to MDIO Interface
      configuration_vector          : in std_logic_vector(4 downto 0);  
      an_interrupt                  : out std_logic;                    
      an_adv_config_vector          : in std_logic_vector(15 downto 0); 
      an_restart_config             : in std_logic;                     
      -- General IO's
      status_vector                 : out std_logic_vector(15 downto 0);
      reset                         : in std_logic;                     
      signal_detect                 : in std_logic;                     
      gt0_pll0outclk_in             : in  std_logic;
      gt0_pll0outrefclk_in          : in  std_logic;
      gt0_pll1outclk_in             : in  std_logic;
      gt0_pll1outrefclk_in          : in  std_logic;
      gt0_pll0refclklost_in         : in  std_logic;
      gt0_pll0lock_in               : in  std_logic;
      gt0_pll0reset_out             : out std_logic

      );
end component;
component util_gmii_to_rgmii
  port (
    rgmii_rxc : in std_logic;
    reset : in std_logic;
    rgmii_td : out std_logic_vector ( 3 downto 0);
    rgmii_tx_ctl : out std_logic;
    rgmii_txc : out std_logic;
    rgmii_rd : in std_logic_vector ( 3 downto 0);
    rgmii_rx_ctl : in std_logic;
    gmii_rx_clk : out std_logic;
    gmii_txd : in std_logic_vector ( 7 downto 0);
    gmii_tx_en : in std_logic;
    gmii_tx_er : in std_logic;
    gmii_tx_clk : out std_logic;
    gmii_crs : out std_logic;
    gmii_col : out std_logic;
    gmii_rxd : out std_logic_vector ( 7 downto 0);
    gmii_rx_dv : out std_logic;
    gmii_rx_er : out std_logic;
    speed_selection : in std_logic_vector ( 1 downto 0);
    duplex_mode : in std_logic
  );
end component;

constant DELAY			            : integer := 20_000_000 ; --400ms @ 50m                     
signal gtrefclk_out                 : std_logic;
signal gtrefclk_bufg_out            : std_logic;
signal userclk_out                  : std_logic;
signal userclk2_out                 : std_logic;
signal rxuserclk_out                : std_logic;     
signal rxuserclk2_out               : std_logic;    
signal pma_reset_out                : std_logic;     
signal mmcm_locked_out              : std_logic;   
signal gt0_pll0outclk_out           : std_logic;
signal gt0_pll0outrefclk_out        : std_logic;
signal gt0_pll1outclk_out           : std_logic;
signal gt0_pll1outrefclk_out        : std_logic;
signal gt0_pll0refclklost_out       : std_logic;
signal gt0_pll0lock_out             : std_logic;
signal pa_gmii_tx                   : gmii_tx ;   
signal pa_gmii_rx                   : gmii_rx ; 
signal pb_gmii_tx                   : gmii_tx ;   
signal pb_gmii_rx                   : gmii_rx ; 
signal pc_gmii_tx                   : gmii_tx ;   
signal pc_gmii_rx                   : gmii_rx ;  
signal pa_phy_mdio                  : std_logic;   
signal pb_phy_mdio                  : std_logic;   
signal reset                        : std_logic;   
signal pc_gmii_tx_clk               : std_logic;   
signal delay_cnt 					: integer range 0 to DELAY + 1 ; 
signal pa_status                    : std_logic_vector(15 downto 0); 
signal pb_status                    : std_logic_vector(15 downto 0);  
begin 
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            delay_cnt <= 0 ;
        elsif rising_edge ( clk ) then
            if ( delay_cnt < DELAY ) then
                delay_cnt <= delay_cnt + 1 ;
            end if;
        end if;
end process;
process ( rst_n , clk )
    begin
        if rst_n = '0' then
            MGT_TX0_disable                 <= '1';
            MGT_TX1_disable                 <= '1';           
        elsif rising_edge ( clk ) then
			if ( delay_cnt < DELAY ) then
                MGT_TX0_disable                 <= '1';
                MGT_TX1_disable                 <= '1';		    
			else
                MGT_TX0_disable                 <= '0';
                MGT_TX1_disable                 <= '0';				    
			end if;              
        end if;
end process;
reset <= not rst_n ;
--====================================
-- gig_ethernet to camera  
--====================================      
pa_ethernet : gig_ethernet_pcs_pma_0 
    port map(
        gtrefclk_p                  => MGT_CLK0_P           ,
        gtrefclk_n                  => MGT_CLK0_N           ,
        gtrefclk_out                => gtrefclk_out         ,
        gtrefclk_bufg_out           => gtrefclk_bufg_out    ,
        txp                         => MGT_TX0_P            ,
        txn                         => MGT_TX0_N            ,
        rxp                         => MGT_RX0_P            ,
        rxn                         => MGT_RX0_N            ,
        resetdone                   => open                 ,
        userclk_out                 => userclk_out          ,
        userclk2_out                => userclk2_out         ,
        rxuserclk_out               => rxuserclk_out        ,
        rxuserclk2_out              => rxuserclk2_out       ,
        pma_reset_out               => pma_reset_out        ,
        mmcm_locked_out             => mmcm_locked_out      , 
        independent_clock_bufg      => clk_pll_200          ,
        -- GMII Interface                                   
        gmii_txd                    => pa_gmii_tx.data      ,    
        gmii_tx_en                  => pa_gmii_tx.en        ,    
        gmii_tx_er                  => pa_gmii_tx.er        ,    
        gmii_rxd                    => pa_gmii_rx.data      ,
        gmii_rx_dv                  => pa_gmii_rx.dv        ,
        gmii_rx_er                  => pa_gmii_rx.er        ,
        gmii_isolate                => open                 ,     
        -- Management: Alternative                          
        configuration_vector        => "00000"              ,     
        an_interrupt                => open                 ,     
        an_adv_config_vector        => X"0020"              ,     
        an_restart_config           => '0'                  ,
        -- General IO's                                     
        status_vector               => pa_status            ,     
        reset                       => reset                ,
        signal_detect               => '1'                  ,
        gt0_pll0outclk_out          => gt0_pll0outclk_out   ,
        gt0_pll0outrefclk_out       => gt0_pll0outrefclk_out,
        gt0_pll1outclk_out          => gt0_pll1outclk_out   ,
        gt0_pll1outrefclk_out       => gt0_pll1outrefclk_out,
        gt0_pll0refclklost_out      => gt0_pll0refclklost_out,
        gt0_pll0lock_out            => gt0_pll0lock_out         
    ); 
    
pb_ethernet : gig_ethernet_pcs_pma_1                                                      
    port map (                                                     
        gtrefclk                    => gtrefclk_out         ,
        gtrefclk_bufg               => gtrefclk_bufg_out    ,
        txp                         => MGT_TX1_P            ,
        txn                         => MGT_TX1_N            ,
        rxp                         => MGT_RX1_P            ,
        rxn                         => MGT_RX1_N            ,
        resetdone                   => open                 ,
        cplllock                    => open                 ,
        mmcm_reset                  => open                 ,
      --  recclk_mmcm_reset           => open                 ,
        txoutclk                    => open                 ,
        rxoutclk                    => open                 ,
        userclk                     => userclk_out          ,
        userclk2                    => userclk2_out         ,
        rxuserclk                   => rxuserclk_out        ,
        rxuserclk2                  => rxuserclk2_out       ,
        pma_reset                   => pma_reset_out        ,
        mmcm_locked                 => mmcm_locked_out      , 
        independent_clock_bufg      => clk_pll_200          ,
        -- GMII Interface                      
        gmii_txd                    => pb_gmii_tx.data      ,    
        gmii_tx_en                  => pb_gmii_tx.en        ,    
        gmii_tx_er                  => pb_gmii_tx.er        ,    
        gmii_rxd                    => pb_gmii_rx.data      ,
        gmii_rx_dv                  => pb_gmii_rx.dv        ,
        gmii_rx_er                  => pb_gmii_rx.er        ,
        gmii_isolate                => open                 ,   
        -- Management: Alternative    
        configuration_vector        =>  "00000"             ,
        an_interrupt                =>  open                ,
        an_adv_config_vector        =>  X"0020"             ,
        an_restart_config           =>  '0'                 ,
        -- General IO's                
        status_vector               => pb_status            ,
        reset                       => reset                ,
        signal_detect               => '1'                  ,
        gt0_pll0outclk_in           => gt0_pll0outclk_out   ,
        gt0_pll0outrefclk_in        => gt0_pll0outrefclk_out,
        gt0_pll1outclk_in           => gt0_pll1outclk_out   ,
        gt0_pll1outrefclk_in        => gt0_pll1outrefclk_out,
        gt0_pll0refclklost_in       => gt0_pll0refclklost_out,
        gt0_pll0lock_in             => gt0_pll0lock_out     ,         
        gt0_pll0reset_out           => open                           
    ); 
pa_link_state       <= pa_status (0) ;
pb_link_state       <= pb_status (0) ;
pa_gmii_rx.clk      <= userclk2_out ; 
pb_gmii_rx.clk      <= userclk2_out ; 
pa_mac_top : entity work.mac_top  port map (
	clk    			        => clk                  ,
	rst_n    			    => rst_n    		    ,

    phy_mdc     	        => open                 ,
    phy_mdio    	        => pa_phy_mdio  	    ,
    phy_link    	        => open  	            ,  

	gmii_tck    			=> userclk2_out    		,
	rst_n_tx    			=> rst_n    	        ,
	rst_n_rx				=> rst_n		        ,
	local_net		        => pa_local_net         ,
    gmii_rx                 => pa_gmii_rx           ,
	gmii_tx			        => pa_gmii_tx		    ,
	phy_rx				    => pa_phy_rx			,
	udp_tx_q		        => pa_udp_tx_q	        ,
	udp_tx_p		        => pa_udp_tx_p		    ,
	mac_tx_ack		        => pa_mac_tx_ack	     ); 

pb_mac_top : entity work.mac_top port map (
	clk    			        => clk                  ,
	rst_n    			    => rst_n    		    ,

    phy_mdc     	        => open                 ,
    phy_mdio    	        => pb_phy_mdio  	    ,
    phy_link    	        => open  	            ,    

	gmii_tck    			=> userclk2_out    		,
	rst_n_tx    			=> rst_n    	        ,
	rst_n_rx				=> rst_n		        ,
	local_net		        => pb_local_net         ,
    gmii_rx                 => pb_gmii_rx           ,
	gmii_tx			        => pb_gmii_tx		    ,
	phy_rx				    => pb_phy_rx			,
	udp_tx_q		        => pb_udp_tx_q	        ,
	udp_tx_p		        => pb_udp_tx_p		    ,
	mac_tx_ack		        => pb_mac_tx_ack	    ); 

pc_mac_top : entity work.mac_top port map (
	clk    			        => clk                  ,
	rst_n    			    => rst_n    		    ,
    
    phy_mdc     	        => rgmii_phy_mdc        ,
    phy_mdio    	        => rgmii_phy_mdio  	    ,
    phy_link    	        => pc_link_state  	    ,  

	gmii_tck    			=> pc_gmii_rx.clk    	,
	rst_n_tx    			=> rst_n    	        ,
	rst_n_rx    			=> rst_n		        ,
	local_net		        => pc_local_net         ,
    gmii_rx                 => pc_gmii_rx           ,
	gmii_tx			        => pc_gmii_tx		    ,
	phy_rx				    => pc_phy_rx			,
	udp_tx_q		        => pc_udp_tx_q	        ,
	udp_tx_p		        => pc_udp_tx_p		    ,
	mac_tx_ack		        => pc_mac_tx_ack	    );  
pc_gmii_to_rgmii :  util_gmii_to_rgmii  port map (
    reset                   => reset                ,
    rgmii_rxc               => rgmii_rxc            ,
    rgmii_td                => rgmii_txd            ,
    rgmii_tx_ctl            => rgmii_txctl          ,
    rgmii_txc               => rgmii_txc            ,
    rgmii_rd                => rgmii_rxd            ,
    rgmii_rx_ctl            => rgmii_rxctl          ,

    gmii_rx_clk             => pc_gmii_rx.clk       ,
    gmii_txd                => pc_gmii_tx.data      ,
    gmii_tx_en              => pc_gmii_tx.en        ,
    gmii_tx_er              => pc_gmii_tx.er        , 
    gmii_tx_clk             => open                 ,
    gmii_crs                => open                 ,
    gmii_col                => open                 ,
    gmii_rxd                => pc_gmii_rx.data      ,
    gmii_rx_dv              => pc_gmii_rx.dv        ,
    gmii_rx_er              => pc_gmii_rx.er        ,
    speed_selection         => "00"                 ,
    duplex_mode             => '0'                  );
    
rgmii_reset <= rst_n ;



end;