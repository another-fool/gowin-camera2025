
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.mt_lib.all;  
entity mux_top is port (   		
    clk             		    : in std_logic ;		
    rst_n            		    : in std_logic ; 
    check            		    : out std_logic ; 
    --uart
    rxp                         : in std_logic ;  
    -- hdmi io 
    video_clk                   : in std_logic ;  
    syn_off0_vs                 : in std_logic ; 
    syn_off0_hs                 : in std_logic ; 
    out_de                      : in std_logic ; 
    off0_syn_data               : out std_logic_vector(15 downto 0);
    off0_syn_de                 : out std_logic ; 
    --sensor io
    cmos_scl                    : inout std_logic;
    cmos_sda                    : inout std_logic;
    i2c_sel                     : out std_logic_vector (2 downto 0); 
              
    cmos0_vsync                 : in std_logic;
    cmos0_href                  : in std_logic;
    cmos0_pclk                  : in std_logic; 
    cmos0_db                    : in std_logic_vector (7 downto 0); 
              
    cmos1_vsync                 : in std_logic;
    cmos1_href                  : in std_logic;
    cmos1_pclk                  : in std_logic; 
    cmos1_db                    : in std_logic_vector (7 downto 0); 
              
    cmos2_vsync                 : in std_logic;
    cmos2_href                  : in std_logic;
    cmos2_pclk                  : in std_logic; 
    cmos2_db                    : in std_logic_vector (7 downto 0);  
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

end mux_top ;
architecture rtl of mux_top is   
constant IDLE                       : std_logic_vector(7 downto 0) := X"01"; 
constant WR_PRE                     : std_logic_vector(7 downto 0) := X"03";
constant WR_REQ                     : std_logic_vector(7 downto 0) := X"04";
constant WR                         : std_logic_vector(7 downto 0) := X"05";
constant WR_END   				    : std_logic_vector(7 downto 0) := X"06"; 
constant RD_PRE                     : std_logic_vector(7 downto 0) := X"07";
constant RD_REQ                     : std_logic_vector(7 downto 0) := X"08";
constant RD                         : std_logic_vector(7 downto 0) := X"09";
constant RD_END   				    : std_logic_vector(7 downto 0) := X"0a"; 
constant CHECK_FIFO                 : std_logic_vector(7 downto 0) := X"0b";
constant CONTINUE_WR                : std_logic_vector(7 downto 0) := X"0c";
constant TIMEOUT                    : std_logic_vector(7 downto 0) := X"0d";
constant FRAME_BUFFER_END           : std_logic_vector(7 downto 0) := X"0e";
signal cs                           : std_logic_vector(7 downto 0) := IDLE;
signal ns                           : std_logic_vector(7 downto 0) := IDLE;

constant time_1s                    : integer := 50_000_000 ;
constant time_5s                    : integer := time_1s * 5 ;
signal cnt_5s                       : integer range 0 to time_5s + 1 ;  

signal usr1_ddr3_wr_q               : usr_ddr3_wr_q;
signal usr1_ddr3_wr_p               : usr_ddr3_wr_p;
signal usr2_ddr3_wr_q               : usr_ddr3_wr_q;
signal usr2_ddr3_wr_p               : usr_ddr3_wr_p;
signal usr3_ddr3_wr_q               : usr_ddr3_wr_q;
signal usr3_ddr3_wr_p               : usr_ddr3_wr_p;
signal usr4_ddr3_wr_q               : usr_ddr3_wr_q;
signal usr4_ddr3_wr_p               : usr_ddr3_wr_p;
signal usr1_ddr3_rd_q               : usr_ddr3_rd_q;
signal usr1_ddr3_rd_p               : usr_ddr3_rd_p;
signal usr2_ddr3_rd_q               : usr_ddr3_rd_q;
signal usr2_ddr3_rd_p               : usr_ddr3_rd_p;
signal usr3_ddr3_rd_q               : usr_ddr3_rd_q;
signal usr3_ddr3_rd_p               : usr_ddr3_rd_p;
signal usr4_ddr3_rd_q               : usr_ddr3_rd_q;
signal usr4_ddr3_rd_p               : usr_ddr3_rd_p;   
signal time_out                     : std_logic_vector(23 downto 0); 
signal cnt_led                      : std_logic_vector(23 downto 0); 
signal coms0_wr_area                : std_logic;
signal coms1_wr_area                : std_logic;
signal coms2_wr_area                : std_logic; 
signal mode                         : std_logic_vector(7 downto 0);
signal current_buffer_addr          : std_logic_vector(27 downto 0);
begin 
 
-- usr1_ddr3_wr_q.req <= '0'; 
-- usr2_ddr3_wr_q.req <= '0'; 
-- usr3_ddr3_wr_q.req <= '0'; 
-- usr4_ddr3_wr_q.req <= '0'; 
-- usr1_ddr3_rd_q.req <= '0';
-- usr2_ddr3_rd_q.req <= '0';
usr3_ddr3_rd_q.req <= '0';
usr4_ddr3_rd_q.req <= '0'; 
process( rst_n,clk )
    begin
        if rst_n ='0' then
             cnt_5s <= 0 ;
        elsif rising_edge( clk ) then
            if ( cnt_5s >= time_5s - 1 ) then
                cnt_5s <= 0 ;
            else
                cnt_5s <= cnt_5s + 1 ;
            end if; 
        end if;
end process;
process( rst_n,clk )
    begin
        if rst_n ='0' then
            mode <= X"01" ;
        elsif rising_edge( clk ) then
             if ( cnt_5s >= time_5s - 1 ) then
                if mode = X"01" then 
                    mode <= X"02" ;
                elsif mode = X"02" then 
                    mode <= X"03" ;
                else
                    mode <= X"01" ;
                end if ;    
             end if;
        end if;
end process;
-- mode <= X"02" ;
sensor_top_inst : entity work.sensor_top  port map (
    clk            => clk           ,
    rst_n          => rst_n         ,
    dma_clk        => dma_clk       ,
    cmos_scl       => cmos_scl      ,
    cmos_sda       => cmos_sda      ,
    i2c_sel        => i2c_sel       ,
    cmos0_vsync    => cmos0_vsync   ,
    cmos0_href     => cmos0_href    ,
    cmos0_pclk     => cmos0_pclk    ,
    cmos0_db       => cmos0_db      ,
    cmos1_vsync    => cmos1_vsync   ,
    cmos1_href     => cmos1_href    ,
    cmos1_pclk     => cmos1_pclk    ,
    cmos1_db       => cmos1_db      ,
    cmos2_vsync    => cmos2_vsync   ,
    cmos2_href     => cmos2_href    ,
    cmos2_pclk     => cmos2_pclk    ,
    cmos2_db       => cmos2_db      ,
    coms0_wr_area  => coms0_wr_area ,
    coms1_wr_area  => coms1_wr_area ,
    coms2_wr_area  => coms2_wr_area ,
    usr1_ddr3_wr_q => usr3_ddr3_wr_q,
    usr1_ddr3_wr_p => usr3_ddr3_wr_p,
    usr2_ddr3_wr_q => usr2_ddr3_wr_q,
    usr2_ddr3_wr_p => usr2_ddr3_wr_p,
    usr3_ddr3_wr_q => usr1_ddr3_wr_q,
    usr3_ddr3_wr_p => usr1_ddr3_wr_p );
algorithm_top_inst : entity work.algorithm_top
  generic map (
    coms0_addra => X"0000000",
    coms0_addrb => X"0040000",
    coms1_addra => X"0080000",
    coms1_addrb => X"00c0000",
    coms2_addra => X"0100000",
    coms2_addrb => X"0140000" )
  port map (
    clk                 => dma_clk             ,
    rst_n               => rst_n               ,
    syn_off0_vs         => syn_off0_vs         ,
    coms0_wr_area       => coms0_wr_area       ,
    coms1_wr_area       => coms1_wr_area       ,
    coms2_wr_area       => coms2_wr_area       ,
    current_buffer_addr => current_buffer_addr ,
    usr_ddr3_wr_q       => usr4_ddr3_wr_q      ,
    usr_ddr3_wr_p       => usr4_ddr3_wr_p      ,
    usr_ddr3_rd_q       => usr2_ddr3_rd_q      ,
    usr_ddr3_rd_p       => usr2_ddr3_rd_p      );

hdmi_rd_inst : entity work.hdmi_rd 
  generic map (
    coms0_addra => X"0000000",
    coms0_addrb => X"0040000",
    coms1_addra => X"0080000",
    coms1_addrb => X"00c0000",
    coms2_addra => X"0100000",
    coms2_addrb => X"0140000" )
  port map (
    rst_n               => rst_n              ,
    coms0_wr_area       => coms0_wr_area       ,
    coms1_wr_area       => coms1_wr_area       ,
    coms2_wr_area       => coms2_wr_area       ,
    current_buffer_addr => current_buffer_addr,
    mode                => mode               ,
    video_clk           => video_clk          ,
    syn_off0_hs         => syn_off0_hs        ,
    syn_off0_vs         => syn_off0_vs        ,
    out_de              => out_de             ,
    off0_syn_data       => off0_syn_data      ,
    off0_syn_de         => off0_syn_de        ,
    ddr_clk             => dma_clk            ,
    usr_ddr3_rd_q       => usr1_ddr3_rd_q     ,
    usr_ddr3_rd_p       => usr1_ddr3_rd_p     );

ddr_top_inst : entity work.ddr_top port map ( 
    rst_n          => rst_n         ,
    usr1_ddr3_wr_q => usr1_ddr3_wr_q,
    usr1_ddr3_wr_p => usr1_ddr3_wr_p,
    usr2_ddr3_wr_q => usr2_ddr3_wr_q,
    usr2_ddr3_wr_p => usr2_ddr3_wr_p,
    usr3_ddr3_wr_q => usr3_ddr3_wr_q,
    usr3_ddr3_wr_p => usr3_ddr3_wr_p,
    usr4_ddr3_wr_q => usr4_ddr3_wr_q,
    usr4_ddr3_wr_p => usr4_ddr3_wr_p,
    usr1_ddr3_rd_q => usr1_ddr3_rd_q,
    usr1_ddr3_rd_p => usr1_ddr3_rd_p,
    usr2_ddr3_rd_q => usr2_ddr3_rd_q,
    usr2_ddr3_rd_p => usr2_ddr3_rd_p,
    usr3_ddr3_rd_q => usr3_ddr3_rd_q,
    usr3_ddr3_rd_p => usr3_ddr3_rd_p,
    usr4_ddr3_rd_q => usr4_ddr3_rd_q,
    usr4_ddr3_rd_p => usr4_ddr3_rd_p,
    dma_clk        => dma_clk       ,
    init_complete  => init_complete ,
    cmd_ready      => cmd_ready     ,
    cmd            => cmd           ,
    cmd_en         => cmd_en        ,
    addr           => addr          ,
    wr_data_rdy    => wr_data_rdy   ,
    wr_data        => wr_data       ,
    wr_data_en     => wr_data_en    ,
    wr_data_end    => wr_data_end   ,
    wr_data_mask   => wr_data_mask  ,
    rd_data        => rd_data       ,
    rd_data_valid  => rd_data_valid ,
    rd_data_end    => rd_data_end );

end rtl ;