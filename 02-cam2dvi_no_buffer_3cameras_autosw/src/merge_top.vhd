library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity merge_top is
  port (
    clk          : in std_logic;
    rst_n        : in std_logic;
    state_led    : out std_logic_vector (4 downto 0);
    --sensor
    cmos_scl     : inout std_logic;
    cmos_sda     : inout std_logic;
    i2c_sel      : out std_logic_vector (2 downto 0); 
    cmos0_vsync   : in std_logic;
    cmos0_href    : in std_logic;
    cmos0_pclk    : in std_logic; 
    cmos0_db      : in std_logic_vector (7 downto 0); 

    cmos1_vsync   : in std_logic;
    cmos1_href    : in std_logic;
    cmos1_pclk    : in std_logic; 
    cmos1_db      : in std_logic_vector (7 downto 0); 

    cmos2_vsync   : in std_logic;
    cmos2_href    : in std_logic;
    cmos2_pclk    : in std_logic; 
    cmos2_db      : in std_logic_vector (7 downto 0); 
    
    --ddr3
    ddr_addr     : out std_logic_vector (16-1 downto 0);
    ddr_bank     : out std_logic_vector (3-1 downto 0);
    ddr_cs       : out std_logic;
    ddr_ras      : out std_logic;
    ddr_cas      : out std_logic;
    ddr_we       : out std_logic;
    ddr_ck       : out std_logic;
    ddr_ck_n     : out std_logic;
    ddr_cke      : out std_logic;
    ddr_odt      : out std_logic;
    ddr_reset_n  : out std_logic;
    ddr_dm       : out std_logic_vector (4-1 downto 0);
    ddr_dq       : inout std_logic_vector (32-1 downto 0);
    ddr_dqs      : inout std_logic_vector (4-1 downto 0);
    ddr_dqs_n    : inout std_logic_vector (4-1 downto 0);
    --hdmi
    tmds_clk_n_0 : out std_logic;
    tmds_clk_p_0 : out std_logic;
    tmds_d_n_0   : out std_logic_vector (2 downto 0);
    tmds_d_p_0   : out std_logic_vector (2 downto 0);
    tmds_clk_n_1 : out std_logic;
    tmds_clk_p_1 : out std_logic;
    tmds_d_n_1   : out std_logic_vector (2 downto 0);
    tmds_d_p_1   : out std_logic_vector (2 downto 0);
    --uart
    rxp          : in std_logic 
  );
end merge_top ;

architecture rtl of merge_top is

begin
  top_inst (
    .clk(clk),
    .rst_n(rst_n),
    .cmos_scl(cmos_scl),
    .cmos_sda(cmos_sda),
    .cmos_vsync(cmos_vsync),
    .cmos_href(cmos_href),
    .cmos_pclk(cmos_pclk),
    .cmos_xclk(cmos_xclk),
    .cmos_db(cmos_db),
    .cmos_rst_n(cmos_rst_n),
    .cmos_pwdn(cmos_pwdn),
    .state_led(state_led),
    .i2c_sel(i2c_sel),
    .ddr_addr(ddr_addr),
    .ddr_bank(ddr_bank),
    .ddr_cs(ddr_cs),
    .ddr_ras(ddr_ras),
    .ddr_cas(ddr_cas),
    .ddr_we(ddr_we),
    .ddr_ck(ddr_ck),
    .ddr_ck_n(ddr_ck_n),
    .ddr_cke(ddr_cke),
    .ddr_odt(ddr_odt),
    .ddr_reset_n(ddr_reset_n),
    .ddr_dm(ddr_dm),
    .ddr_dq(ddr_dq),
    .ddr_dqs(ddr_dqs),
    .ddr_dqs_n(ddr_dqs_n),
    .tmds_clk_n_0(tmds_clk_n_0),
    .tmds_clk_p_0(tmds_clk_p_0),
    .tmds_d_n_0(tmds_d_n_0),
    .tmds_d_p_0(tmds_d_p_0),
    .tmds_clk_n_1(tmds_clk_n_1),
    .tmds_clk_p_1(tmds_clk_p_1),
    .tmds_d_n_1(tmds_d_n_1),
    .tmds_d_p_1(tmds_d_p_1)
  );
end rtl; 