library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.mt_lib.all; 
entity sensor_top is
    port (
    clk                 : in std_logic;
    rst_n               : in std_logic; 
    dma_clk             : in std_logic;  
    --sensor      
    cmos_scl            : inout std_logic;
    cmos_sda            : inout std_logic;
    i2c_sel             : out std_logic_vector (2 downto 0); 
      
    cmos0_vsync         : in std_logic;
    cmos0_href          : in std_logic;
    cmos0_pclk          : in std_logic; 
    cmos0_db            : in std_logic_vector (7 downto 0); 
      
    cmos1_vsync         : in std_logic;
    cmos1_href          : in std_logic;
    cmos1_pclk          : in std_logic; 
    cmos1_db            : in std_logic_vector (7 downto 0); 
      
    cmos2_vsync         : in std_logic;
    cmos2_href          : in std_logic;
    cmos2_pclk          : in std_logic; 
    cmos2_db            : in std_logic_vector (7 downto 0);
    
    coms0_wr_area       : out std_logic;
    coms1_wr_area       : out std_logic;
    coms2_wr_area       : out std_logic;
    --to ddr3
    usr1_ddr3_wr_q      : buffer usr_ddr3_wr_q ;
    usr1_ddr3_wr_p      : in usr_ddr3_wr_p ; 
    usr2_ddr3_wr_q      : buffer usr_ddr3_wr_q ;
    usr2_ddr3_wr_p      : in usr_ddr3_wr_p ;
    usr3_ddr3_wr_q      : buffer usr_ddr3_wr_q ;
    usr3_ddr3_wr_p      : in usr_ddr3_wr_p );  
end sensor_top ;
architecture rtl of sensor_top is
component i2c_config_top
  port (
    clk : in std_logic;
    rst_n : in std_logic;
    cmos_scl : inout std_logic;
    cmos_sda : inout std_logic;
    i2c_sel : out std_logic_vector (2 downto 0)
  );
end component;
begin
i2c_config_top_inst :  i2c_config_top port map (
    clk                  => clk               ,
    rst_n                => rst_n             ,
    cmos_scl             => cmos_scl          ,
    cmos_sda             => cmos_sda          ,
    i2c_sel              => i2c_sel           );
ov5640_ctl_0 : entity work.ov5640_ctl 
generic map (
    ddr3_start_addra     => X"0000000"         ,
    ddr3_start_addrb     => X"0040000"         )
port map ( 
    rst_n                => rst_n              ,
    cmos_vsync           => cmos0_vsync         ,
    cmos_href            => cmos0_href          ,
    cmos_pclk            => cmos0_pclk          ,
    cmos_db              => cmos0_db            ,
    ddr_clk              => dma_clk             ,
    coms_wr_area         => coms0_wr_area       , 
    usr_ddr3_wr_q        => usr1_ddr3_wr_q      ,
    usr_ddr3_wr_p        => usr1_ddr3_wr_p       ); 
ov5640_ctl_1 : entity work.ov5640_ctl 
generic map (
    ddr3_start_addra     => X"0080000"         ,
    ddr3_start_addrb     => X"00c0000"         )
port map ( 
    rst_n                => rst_n              ,
    cmos_vsync           => cmos1_vsync         ,
    cmos_href            => cmos1_href          ,
    cmos_pclk            => cmos1_pclk          ,
    cmos_db              => cmos1_db            ,
    ddr_clk              => dma_clk             ,
    coms_wr_area         => coms1_wr_area       ,
    usr_ddr3_wr_q        => usr2_ddr3_wr_q      ,
    usr_ddr3_wr_p        => usr2_ddr3_wr_p       );
ov5640_ctl_2 : entity work.ov5640_ctl 
generic map (
    ddr3_start_addra     => X"0100000"         ,
    ddr3_start_addrb     => X"0140000"         )
port map ( 
    rst_n                => rst_n              ,
    cmos_vsync           => cmos2_vsync         ,
    cmos_href            => cmos2_href          ,
    cmos_pclk            => cmos2_pclk          ,
    cmos_db              => cmos2_db            ,
    ddr_clk              => dma_clk             ,
    coms_wr_area         => coms2_wr_area       ,
    usr_ddr3_wr_q        => usr3_ddr3_wr_q      ,
    usr_ddr3_wr_p        => usr3_ddr3_wr_p       );

end rtl; 