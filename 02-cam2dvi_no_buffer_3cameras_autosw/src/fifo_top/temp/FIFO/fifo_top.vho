--
--Written by GowinSynthesis
--Tool Version "V1.9.12 (64-bit)"
--Sat Nov  1 17:54:22 2025

--Source file index table:
--file0 "\D:/FPGA/03-outsourced proj/05-panoramic_camera/cam2dvi_no_buffer/src/fifo_top/temp/FIFO/fifo_define.v"
--file1 "\D:/FPGA/03-outsourced proj/05-panoramic_camera/cam2dvi_no_buffer/src/fifo_top/temp/FIFO/fifo_parameter.v"
--file2 "\C:/Gowin/Gowin_V1.9.12_x64/IDE/ipcore/FIFO/data/edc.v"
--file3 "\C:/Gowin/Gowin_V1.9.12_x64/IDE/ipcore/FIFO/data/fifo.v"
--file4 "\C:/Gowin/Gowin_V1.9.12_x64/IDE/ipcore/FIFO/data/fifo_top.v"
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library gw5a;
use gw5a.components.all;

entity fifo_256x512_16x8192 is
port(
  Data :  in std_logic_vector(255 downto 0);
  Reset :  in std_logic;
  WrClk :  in std_logic;
  RdClk :  in std_logic;
  WrEn :  in std_logic;
  RdEn :  in std_logic;
  Wnum :  out std_logic_vector(9 downto 0);
  Rnum :  out std_logic_vector(13 downto 0);
  Almost_Full :  out std_logic;
  Q :  out std_logic_vector(15 downto 0);
  Empty :  out std_logic;
  Full :  out std_logic);
end fifo_256x512_16x8192;
architecture beh of fifo_256x512_16x8192 is
  signal fifo_inst_rcnt_sub_1 : std_logic ;
  signal fifo_inst_rcnt_sub_2 : std_logic ;
  signal fifo_inst_rcnt_sub_3 : std_logic ;
  signal fifo_inst_rcnt_sub_4 : std_logic ;
  signal fifo_inst_rcnt_sub_5 : std_logic ;
  signal fifo_inst_rcnt_sub_6 : std_logic ;
  signal fifo_inst_rcnt_sub_7 : std_logic ;
  signal fifo_inst_rcnt_sub_8 : std_logic ;
  signal fifo_inst_rcnt_sub_9 : std_logic ;
  signal fifo_inst_rcnt_sub_10 : std_logic ;
  signal fifo_inst_rcnt_sub_11 : std_logic ;
  signal fifo_inst_rcnt_sub_12 : std_logic ;
  signal fifo_inst_rcnt_sub_13 : std_logic ;
  signal fifo_inst_wcnt_sub_0 : std_logic ;
  signal fifo_inst_wcnt_sub_1 : std_logic ;
  signal fifo_inst_wcnt_sub_2 : std_logic ;
  signal fifo_inst_wcnt_sub_3 : std_logic ;
  signal fifo_inst_wcnt_sub_4 : std_logic ;
  signal fifo_inst_wcnt_sub_5 : std_logic ;
  signal fifo_inst_wcnt_sub_6 : std_logic ;
  signal fifo_inst_wcnt_sub_7 : std_logic ;
  signal fifo_inst_wcnt_sub_8 : std_logic ;
  signal fifo_inst_wcnt_sub_9 : std_logic ;
  signal fifo_inst_n1014 : std_logic ;
  signal fifo_inst_n1014_3 : std_logic ;
  signal fifo_inst_n1015 : std_logic ;
  signal fifo_inst_n1015_3 : std_logic ;
  signal fifo_inst_n1016 : std_logic ;
  signal fifo_inst_n1016_3 : std_logic ;
  signal fifo_inst_n1017 : std_logic ;
  signal fifo_inst_n1017_3 : std_logic ;
  signal fifo_inst_n1018 : std_logic ;
  signal fifo_inst_n1018_3 : std_logic ;
  signal fifo_inst_n1019 : std_logic ;
  signal fifo_inst_n1019_3 : std_logic ;
  signal fifo_inst_n1020 : std_logic ;
  signal fifo_inst_n1020_3 : std_logic ;
  signal fifo_inst_n1021 : std_logic ;
  signal fifo_inst_n1021_3 : std_logic ;
  signal fifo_inst_n1022 : std_logic ;
  signal fifo_inst_n1022_3 : std_logic ;
  signal fifo_inst_n32 : std_logic ;
  signal fifo_inst_n36 : std_logic ;
  signal fifo_inst_n1049 : std_logic ;
  signal fifo_inst_wfull_val : std_logic ;
  signal fifo_inst_n1133 : std_logic ;
  signal fifo_inst_n1247 : std_logic ;
  signal \fifo_inst_Small.rgraynext_2\ : std_logic ;
  signal \fifo_inst_Small.rgraynext_4\ : std_logic ;
  signal \fifo_inst_Small.rgraynext_5\ : std_logic ;
  signal \fifo_inst_Small.rgraynext_6\ : std_logic ;
  signal \fifo_inst_Small.rgraynext_7\ : std_logic ;
  signal \fifo_inst_Small.wgraynext_1\ : std_logic ;
  signal \fifo_inst_Small.wgraynext_2\ : std_logic ;
  signal \fifo_inst_Small.wgraynext_4\ : std_logic ;
  signal \fifo_inst_Small.wgraynext_6\ : std_logic ;
  signal \fifo_inst_Small.wgraynext_7\ : std_logic ;
  signal \fifo_inst_Small.wgraynext_8\ : std_logic ;
  signal fifo_inst_wfull_val_4 : std_logic ;
  signal fifo_inst_wfull_val_5 : std_logic ;
  signal fifo_inst_wfull_val_6 : std_logic ;
  signal fifo_inst_wfull_val_7 : std_logic ;
  signal \fifo_inst_Small.rcount_w_2\ : std_logic ;
  signal fifo_inst_n1247_4 : std_logic ;
  signal fifo_inst_Almost_Full : std_logic ;
  signal fifo_inst_Almost_Full_7 : std_logic ;
  signal \fifo_inst_Small.wdata_q_15\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_15_23\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_15_24\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_15_25\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_14\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_14_23\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_13\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_13_23\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_13_24\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_13_25\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_12\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_12_23\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_12_24\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_12_25\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_11\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_11_23\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_10\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_10_23\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_9\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_9_23\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_8\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_8_23\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_7\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_7_23\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_6\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_6_23\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_6_24\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_6_25\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_5\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_5_23\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_5_24\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_5_25\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_4\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_4_23\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_4_24\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_4_25\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_3\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_3_23\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_2\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_2_23\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_1\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_1_23\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_1_24\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_1_25\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_0\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_0_23\ : std_logic ;
  signal \fifo_inst_Small.wbinnext_7\ : std_logic ;
  signal \fifo_inst_Small.wbinnext_8\ : std_logic ;
  signal fifo_inst_rbin_num_next_4 : std_logic ;
  signal \fifo_inst_Small.wgraynext_6_5\ : std_logic ;
  signal \fifo_inst_Small.wgraynext_7_5\ : std_logic ;
  signal fifo_inst_wfull_val_8 : std_logic ;
  signal fifo_inst_wfull_val_9 : std_logic ;
  signal fifo_inst_wfull_val_10 : std_logic ;
  signal fifo_inst_wfull_val_11 : std_logic ;
  signal fifo_inst_wfull_val_12 : std_logic ;
  signal fifo_inst_wfull_val_13 : std_logic ;
  signal fifo_inst_wfull_val_14 : std_logic ;
  signal fifo_inst_n1247_5 : std_logic ;
  signal fifo_inst_Almost_Full_8 : std_logic ;
  signal \fifo_inst_Small.wdata_q_15_26\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_15_27\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_15_28\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_15_29\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_15_30\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_15_31\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_15_32\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_15_33\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_15_34\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_15_35\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_15_36\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_14_24\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_14_25\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_14_26\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_14_27\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_14_28\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_14_29\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_14_30\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_14_31\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_13_26\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_13_27\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_13_28\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_13_29\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_13_30\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_13_31\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_13_32\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_13_33\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_12_26\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_12_27\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_12_28\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_12_29\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_12_30\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_12_31\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_12_32\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_12_33\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_12_34\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_11_24\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_11_25\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_11_26\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_11_27\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_11_28\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_11_29\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_11_30\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_11_31\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_10_24\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_10_25\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_10_26\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_10_27\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_10_28\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_10_29\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_10_30\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_10_31\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_9_24\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_9_25\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_9_26\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_9_27\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_9_28\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_9_29\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_9_30\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_9_31\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_8_24\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_8_25\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_8_26\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_8_27\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_8_28\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_8_29\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_8_30\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_8_31\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_7_24\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_7_25\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_7_26\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_7_27\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_7_28\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_7_29\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_7_30\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_7_31\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_6_26\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_6_27\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_6_28\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_6_29\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_6_30\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_6_31\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_6_32\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_6_33\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_5_26\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_5_27\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_5_28\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_5_29\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_5_30\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_5_31\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_5_32\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_4_26\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_4_27\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_4_28\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_4_29\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_4_30\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_4_31\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_3_24\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_3_25\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_3_26\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_3_27\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_3_28\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_3_29\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_3_30\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_3_31\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_2_24\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_2_25\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_2_26\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_2_27\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_2_28\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_2_29\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_2_30\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_2_31\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_1_26\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_1_27\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_1_28\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_1_29\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_1_30\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_1_31\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_0_24\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_0_25\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_0_26\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_0_27\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_0_28\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_0_29\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_0_30\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_0_31\ : std_logic ;
  signal \fifo_inst_Small.wbinnext_8_9\ : std_logic ;
  signal fifo_inst_wfull_val_15 : std_logic ;
  signal fifo_inst_wfull_val_16 : std_logic ;
  signal \fifo_inst_Small.wdata_q_15_37\ : std_logic ;
  signal \fifo_inst_Small.wdata_q_15_38\ : std_logic ;
  signal fifo_inst_Almost_Full_10 : std_logic ;
  signal \fifo_inst_Small.wbinnext_5\ : std_logic ;
  signal \fifo_inst_Small.wbinnext_0\ : std_logic ;
  signal fifo_inst_rbin_num_next_2 : std_logic ;
  signal fifo_inst_rbin_num_next_0 : std_logic ;
  signal fifo_inst_rempty_val : std_logic ;
  signal fifo_inst_n4 : std_logic ;
  signal fifo_inst_n9 : std_logic ;
  signal fifo_inst_rcnt_sub_0 : std_logic ;
  signal GND_0 : std_logic ;
  signal VCC_0 : std_logic ;
  signal \fifo_inst/reset_r\ : std_logic_vector(1 downto 0);
  signal \fifo_inst/reset_w\ : std_logic_vector(1 downto 0);
  signal \fifo_inst/rbin_num\ : std_logic_vector(13 downto 0);
  signal \fifo_inst/Small.wq1_rptr\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/Small.wq2_rptr\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/Small.rq1_wptr\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/Small.rq2_wptr\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/Small.rptr\ : std_logic_vector(8 downto 0);
  signal \fifo_inst/Small.wptr\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/Small.wbin\ : std_logic_vector(8 downto 0);
  signal \fifo_inst/Small.wdata\ : std_logic_vector(255 downto 0);
  signal \fifo_inst/rcnt_sub\ : std_logic_vector(13 downto 1);
  signal \fifo_inst/wcnt_sub\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/Small.rgraynext\ : std_logic_vector(8 downto 0);
  signal \fifo_inst/Small.wcount_r_1\ : std_logic_vector(12 downto 4);
  signal \fifo_inst/Small.wgraynext\ : std_logic_vector(8 downto 0);
  signal \fifo_inst/Small.rcount_w\ : std_logic_vector(8 downto 0);
  signal \fifo_inst/Small.wdata_q\ : std_logic_vector(15 downto 0);
  signal \fifo_inst/Small.wbinnext\ : std_logic_vector(9 downto 1);
  signal \fifo_inst/rbin_num_next\ : std_logic_vector(13 downto 1);
  signal NN : std_logic;
  signal NN_0 : std_logic;
begin
\fifo_inst/reset_r_0_s0\: DFFPE
port map (
  Q => \fifo_inst/reset_r\(0),
  D => GND_0,
  CLK => fifo_inst_n4,
  PRESET => Reset,
  CE => VCC_0);
\fifo_inst/reset_w_1_s0\: DFFPE
port map (
  Q => \fifo_inst/reset_w\(1),
  D => \fifo_inst/reset_w\(0),
  CLK => fifo_inst_n9,
  PRESET => Reset,
  CE => VCC_0);
\fifo_inst/reset_w_0_s0\: DFFPE
port map (
  Q => \fifo_inst/reset_w\(0),
  D => GND_0,
  CLK => fifo_inst_n9,
  PRESET => Reset,
  CE => VCC_0);
\fifo_inst/rbin_num_13_s0\: DFFCE
port map (
  Q => \fifo_inst/rbin_num\(13),
  D => \fifo_inst/rbin_num_next\(13),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/rbin_num_12_s0\: DFFCE
port map (
  Q => \fifo_inst/rbin_num\(12),
  D => \fifo_inst/rbin_num_next\(12),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/rbin_num_11_s0\: DFFCE
port map (
  Q => \fifo_inst/rbin_num\(11),
  D => \fifo_inst/rbin_num_next\(11),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/rbin_num_10_s0\: DFFCE
port map (
  Q => \fifo_inst/rbin_num\(10),
  D => \fifo_inst/rbin_num_next\(10),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/rbin_num_9_s0\: DFFCE
port map (
  Q => \fifo_inst/rbin_num\(9),
  D => \fifo_inst/rbin_num_next\(9),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/rbin_num_8_s0\: DFFCE
port map (
  Q => \fifo_inst/rbin_num\(8),
  D => \fifo_inst/rbin_num_next\(8),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/rbin_num_7_s0\: DFFCE
port map (
  Q => \fifo_inst/rbin_num\(7),
  D => \fifo_inst/rbin_num_next\(7),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/rbin_num_6_s0\: DFFCE
port map (
  Q => \fifo_inst/rbin_num\(6),
  D => \fifo_inst/rbin_num_next\(6),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/rbin_num_5_s0\: DFFCE
port map (
  Q => \fifo_inst/rbin_num\(5),
  D => \fifo_inst/rbin_num_next\(5),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/rbin_num_4_s0\: DFFCE
port map (
  Q => \fifo_inst/rbin_num\(4),
  D => \fifo_inst/rbin_num_next\(4),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/rbin_num_3_s0\: DFFCE
port map (
  Q => \fifo_inst/rbin_num\(3),
  D => \fifo_inst/rbin_num_next\(3),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/rbin_num_2_s0\: DFFCE
port map (
  Q => \fifo_inst/rbin_num\(2),
  D => \fifo_inst/rbin_num_next\(2),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/rbin_num_1_s0\: DFFCE
port map (
  Q => \fifo_inst/rbin_num\(1),
  D => \fifo_inst/rbin_num_next\(1),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/rbin_num_0_s0\: DFFCE
port map (
  Q => \fifo_inst/rbin_num\(0),
  D => fifo_inst_rbin_num_next_0,
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wdata_q_r_15_s0\: DFFCE
port map (
  Q => Q(15),
  D => \fifo_inst/Small.wdata_q\(15),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wdata_q_r_14_s0\: DFFCE
port map (
  Q => Q(14),
  D => \fifo_inst/Small.wdata_q\(14),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wdata_q_r_13_s0\: DFFCE
port map (
  Q => Q(13),
  D => \fifo_inst/Small.wdata_q\(13),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wdata_q_r_12_s0\: DFFCE
port map (
  Q => Q(12),
  D => \fifo_inst/Small.wdata_q\(12),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wdata_q_r_11_s0\: DFFCE
port map (
  Q => Q(11),
  D => \fifo_inst/Small.wdata_q\(11),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wdata_q_r_10_s0\: DFFCE
port map (
  Q => Q(10),
  D => \fifo_inst/Small.wdata_q\(10),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wdata_q_r_9_s0\: DFFCE
port map (
  Q => Q(9),
  D => \fifo_inst/Small.wdata_q\(9),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wdata_q_r_8_s0\: DFFCE
port map (
  Q => Q(8),
  D => \fifo_inst/Small.wdata_q\(8),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wdata_q_r_7_s0\: DFFCE
port map (
  Q => Q(7),
  D => \fifo_inst/Small.wdata_q\(7),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wdata_q_r_6_s0\: DFFCE
port map (
  Q => Q(6),
  D => \fifo_inst/Small.wdata_q\(6),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wdata_q_r_5_s0\: DFFCE
port map (
  Q => Q(5),
  D => \fifo_inst/Small.wdata_q\(5),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wdata_q_r_4_s0\: DFFCE
port map (
  Q => Q(4),
  D => \fifo_inst/Small.wdata_q\(4),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wdata_q_r_3_s0\: DFFCE
port map (
  Q => Q(3),
  D => \fifo_inst/Small.wdata_q\(3),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wdata_q_r_2_s0\: DFFCE
port map (
  Q => Q(2),
  D => \fifo_inst/Small.wdata_q\(2),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wdata_q_r_1_s0\: DFFCE
port map (
  Q => Q(1),
  D => \fifo_inst/Small.wdata_q\(1),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wdata_q_r_0_s0\: DFFCE
port map (
  Q => Q(0),
  D => \fifo_inst/Small.wdata_q\(0),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wq1_rptr_9_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq1_rptr\(9),
  D => \fifo_inst/rbin_num\(13),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq1_rptr_8_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq1_rptr\(8),
  D => \fifo_inst/Small.rptr\(8),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq1_rptr_7_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq1_rptr\(7),
  D => \fifo_inst/Small.rptr\(7),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq1_rptr_6_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq1_rptr\(6),
  D => \fifo_inst/Small.rptr\(6),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq1_rptr_5_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq1_rptr\(5),
  D => \fifo_inst/Small.rptr\(5),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq1_rptr_4_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq1_rptr\(4),
  D => \fifo_inst/Small.rptr\(4),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq1_rptr_3_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq1_rptr\(3),
  D => \fifo_inst/Small.rptr\(3),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq1_rptr_2_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq1_rptr\(2),
  D => \fifo_inst/Small.rptr\(2),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq1_rptr_1_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq1_rptr\(1),
  D => \fifo_inst/Small.rptr\(1),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq1_rptr_0_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq1_rptr\(0),
  D => \fifo_inst/Small.rptr\(0),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq2_rptr_9_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq2_rptr\(9),
  D => \fifo_inst/Small.wq1_rptr\(9),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq2_rptr_8_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq2_rptr\(8),
  D => \fifo_inst/Small.wq1_rptr\(8),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq2_rptr_7_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq2_rptr\(7),
  D => \fifo_inst/Small.wq1_rptr\(7),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq2_rptr_6_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq2_rptr\(6),
  D => \fifo_inst/Small.wq1_rptr\(6),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq2_rptr_5_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq2_rptr\(5),
  D => \fifo_inst/Small.wq1_rptr\(5),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq2_rptr_4_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq2_rptr\(4),
  D => \fifo_inst/Small.wq1_rptr\(4),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq2_rptr_3_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq2_rptr\(3),
  D => \fifo_inst/Small.wq1_rptr\(3),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq2_rptr_2_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq2_rptr\(2),
  D => \fifo_inst/Small.wq1_rptr\(2),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq2_rptr_1_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq2_rptr\(1),
  D => \fifo_inst/Small.wq1_rptr\(1),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wq2_rptr_0_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wq2_rptr\(0),
  D => \fifo_inst/Small.wq1_rptr\(0),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.rq1_wptr_9_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq1_wptr\(9),
  D => \fifo_inst/Small.wptr\(9),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq1_wptr_8_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq1_wptr\(8),
  D => \fifo_inst/Small.wptr\(8),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq1_wptr_7_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq1_wptr\(7),
  D => \fifo_inst/Small.wptr\(7),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq1_wptr_6_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq1_wptr\(6),
  D => \fifo_inst/Small.wptr\(6),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq1_wptr_5_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq1_wptr\(5),
  D => \fifo_inst/Small.wptr\(5),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq1_wptr_4_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq1_wptr\(4),
  D => \fifo_inst/Small.wptr\(4),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq1_wptr_3_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq1_wptr\(3),
  D => \fifo_inst/Small.wptr\(3),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq1_wptr_2_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq1_wptr\(2),
  D => \fifo_inst/Small.wptr\(2),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq1_wptr_1_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq1_wptr\(1),
  D => \fifo_inst/Small.wptr\(1),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq1_wptr_0_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq1_wptr\(0),
  D => \fifo_inst/Small.wptr\(0),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq2_wptr_9_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq2_wptr\(9),
  D => \fifo_inst/Small.rq1_wptr\(9),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq2_wptr_8_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq2_wptr\(8),
  D => \fifo_inst/Small.rq1_wptr\(8),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq2_wptr_7_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq2_wptr\(7),
  D => \fifo_inst/Small.rq1_wptr\(7),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq2_wptr_6_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq2_wptr\(6),
  D => \fifo_inst/Small.rq1_wptr\(6),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq2_wptr_5_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq2_wptr\(5),
  D => \fifo_inst/Small.rq1_wptr\(5),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq2_wptr_4_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq2_wptr\(4),
  D => \fifo_inst/Small.rq1_wptr\(4),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq2_wptr_3_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq2_wptr\(3),
  D => \fifo_inst/Small.rq1_wptr\(3),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq2_wptr_2_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq2_wptr\(2),
  D => \fifo_inst/Small.rq1_wptr\(2),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq2_wptr_1_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq2_wptr\(1),
  D => \fifo_inst/Small.rq1_wptr\(1),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rq2_wptr_0_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rq2_wptr\(0),
  D => \fifo_inst/Small.rq1_wptr\(0),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rptr_8_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rptr\(8),
  D => \fifo_inst/Small.rgraynext\(8),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rptr_7_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rptr\(7),
  D => \fifo_inst/Small.rgraynext\(7),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rptr_6_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rptr\(6),
  D => \fifo_inst/Small.rgraynext\(6),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rptr_5_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rptr\(5),
  D => \fifo_inst/Small.rgraynext\(5),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rptr_4_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rptr\(4),
  D => \fifo_inst/Small.rgraynext\(4),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rptr_3_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rptr\(3),
  D => \fifo_inst/Small.rgraynext\(3),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rptr_2_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rptr\(2),
  D => \fifo_inst/Small.rgraynext\(2),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rptr_1_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rptr\(1),
  D => \fifo_inst/Small.rgraynext\(1),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.rptr_0_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.rptr\(0),
  D => \fifo_inst/Small.rgraynext\(0),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Small.wptr_9_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wptr\(9),
  D => \fifo_inst/Small.wbinnext\(9),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wptr_8_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wptr\(8),
  D => \fifo_inst/Small.wgraynext\(8),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wptr_7_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wptr\(7),
  D => \fifo_inst/Small.wgraynext\(7),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wptr_6_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wptr\(6),
  D => \fifo_inst/Small.wgraynext\(6),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wptr_5_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wptr\(5),
  D => \fifo_inst/Small.wgraynext\(5),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wptr_4_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wptr\(4),
  D => \fifo_inst/Small.wgraynext\(4),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wptr_3_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wptr\(3),
  D => \fifo_inst/Small.wgraynext\(3),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wptr_2_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wptr\(2),
  D => \fifo_inst/Small.wgraynext\(2),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wptr_1_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wptr\(1),
  D => \fifo_inst/Small.wgraynext\(1),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wptr_0_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wptr\(0),
  D => \fifo_inst/Small.wgraynext\(0),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wbin_8_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wbin\(8),
  D => \fifo_inst/Small.wbinnext\(8),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wbin_7_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wbin\(7),
  D => \fifo_inst/Small.wbinnext\(7),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wbin_6_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wbin\(6),
  D => \fifo_inst/Small.wbinnext\(6),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wbin_5_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wbin\(5),
  D => \fifo_inst/Small.wbinnext\(5),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wbin_4_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wbin\(4),
  D => \fifo_inst/Small.wbinnext\(4),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wbin_3_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wbin\(3),
  D => \fifo_inst/Small.wbinnext\(3),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wbin_2_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wbin\(2),
  D => \fifo_inst/Small.wbinnext\(2),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wbin_1_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wbin\(1),
  D => \fifo_inst/Small.wbinnext\(1),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Small.wbin_0_s0\: DFFCE
port map (
  Q => \fifo_inst/Small.wbin\(0),
  D => \fifo_inst_Small.wbinnext_0\,
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Empty_s0\: DFFPE
port map (
  Q => NN,
  D => fifo_inst_rempty_val,
  CLK => RdClk,
  PRESET => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Full_s0\: DFFCE
port map (
  Q => NN_0,
  D => fifo_inst_wfull_val,
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Wnum_9_s0\: DFFCE
port map (
  Q => Wnum(9),
  D => \fifo_inst/wcnt_sub\(9),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Wnum_8_s0\: DFFCE
port map (
  Q => Wnum(8),
  D => \fifo_inst/wcnt_sub\(8),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Wnum_7_s0\: DFFCE
port map (
  Q => Wnum(7),
  D => \fifo_inst/wcnt_sub\(7),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Wnum_6_s0\: DFFCE
port map (
  Q => Wnum(6),
  D => \fifo_inst/wcnt_sub\(6),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Wnum_5_s0\: DFFCE
port map (
  Q => Wnum(5),
  D => \fifo_inst/wcnt_sub\(5),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Wnum_4_s0\: DFFCE
port map (
  Q => Wnum(4),
  D => \fifo_inst/wcnt_sub\(4),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Wnum_3_s0\: DFFCE
port map (
  Q => Wnum(3),
  D => \fifo_inst/wcnt_sub\(3),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Wnum_2_s0\: DFFCE
port map (
  Q => Wnum(2),
  D => \fifo_inst/wcnt_sub\(2),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Wnum_1_s0\: DFFCE
port map (
  Q => Wnum(1),
  D => \fifo_inst/wcnt_sub\(1),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Wnum_0_s0\: DFFCE
port map (
  Q => Wnum(0),
  D => \fifo_inst/wcnt_sub\(0),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Rnum_13_s0\: DFFCE
port map (
  Q => Rnum(13),
  D => \fifo_inst/rcnt_sub\(13),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Rnum_12_s0\: DFFCE
port map (
  Q => Rnum(12),
  D => \fifo_inst/rcnt_sub\(12),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Rnum_11_s0\: DFFCE
port map (
  Q => Rnum(11),
  D => \fifo_inst/rcnt_sub\(11),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Rnum_10_s0\: DFFCE
port map (
  Q => Rnum(10),
  D => \fifo_inst/rcnt_sub\(10),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Rnum_9_s0\: DFFCE
port map (
  Q => Rnum(9),
  D => \fifo_inst/rcnt_sub\(9),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Rnum_8_s0\: DFFCE
port map (
  Q => Rnum(8),
  D => \fifo_inst/rcnt_sub\(8),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Rnum_7_s0\: DFFCE
port map (
  Q => Rnum(7),
  D => \fifo_inst/rcnt_sub\(7),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Rnum_6_s0\: DFFCE
port map (
  Q => Rnum(6),
  D => \fifo_inst/rcnt_sub\(6),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Rnum_5_s0\: DFFCE
port map (
  Q => Rnum(5),
  D => \fifo_inst/rcnt_sub\(5),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Rnum_4_s0\: DFFCE
port map (
  Q => Rnum(4),
  D => \fifo_inst/rcnt_sub\(4),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Rnum_3_s0\: DFFCE
port map (
  Q => Rnum(3),
  D => \fifo_inst/rcnt_sub\(3),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Rnum_2_s0\: DFFCE
port map (
  Q => Rnum(2),
  D => \fifo_inst/rcnt_sub\(2),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Rnum_1_s0\: DFFCE
port map (
  Q => Rnum(1),
  D => \fifo_inst/rcnt_sub\(1),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Rnum_0_s0\: DFFCE
port map (
  Q => Rnum(0),
  D => \fifo_inst/rbin_num\(0),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/reset_r_1_s0\: DFFPE
port map (
  Q => \fifo_inst/reset_r\(1),
  D => \fifo_inst/reset_r\(0),
  CLK => fifo_inst_n4,
  PRESET => Reset,
  CE => VCC_0);
\fifo_inst/Almost_Full_s1\: DFFCE
generic map (
  INIT => '0'
)
port map (
  Q => Almost_Full,
  D => fifo_inst_n1247,
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => fifo_inst_Almost_Full_10);
\fifo_inst/Small.mem_Small.mem_0_0_s\: SDPB
generic map (
  BIT_WIDTH_0 => 32,
  BIT_WIDTH_1 => 32,
  READ_MODE => '0',
  RESET_MODE => "ASYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31 downto 0) => \fifo_inst/Small.wdata\(31 downto 0),
  CLKA => WrClk,
  CEA => fifo_inst_n32,
  CLKB => RdClk,
  CEB => fifo_inst_n36,
  OCE => GND_0,
  RESET => \fifo_inst/reset_r\(1),
  ADA(13 downto 5) => \fifo_inst/Small.wbin\(8 downto 0),
  ADA(4) => GND_0,
  ADA(3) => VCC_0,
  ADA(2) => VCC_0,
  ADA(1) => VCC_0,
  ADA(0) => VCC_0,
  ADB(13 downto 5) => \fifo_inst/rbin_num\(12 downto 4),
  ADB(4) => GND_0,
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  DI(31 downto 0) => Data(31 downto 0),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0);
\fifo_inst/Small.mem_Small.mem_0_1_s\: SDPB
generic map (
  BIT_WIDTH_0 => 32,
  BIT_WIDTH_1 => 32,
  READ_MODE => '0',
  RESET_MODE => "ASYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31 downto 0) => \fifo_inst/Small.wdata\(63 downto 32),
  CLKA => WrClk,
  CEA => fifo_inst_n32,
  CLKB => RdClk,
  CEB => fifo_inst_n36,
  OCE => GND_0,
  RESET => \fifo_inst/reset_r\(1),
  ADA(13 downto 5) => \fifo_inst/Small.wbin\(8 downto 0),
  ADA(4) => GND_0,
  ADA(3) => VCC_0,
  ADA(2) => VCC_0,
  ADA(1) => VCC_0,
  ADA(0) => VCC_0,
  ADB(13 downto 5) => \fifo_inst/rbin_num\(12 downto 4),
  ADB(4) => GND_0,
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  DI(31 downto 0) => Data(63 downto 32),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0);
\fifo_inst/Small.mem_Small.mem_0_2_s\: SDPB
generic map (
  BIT_WIDTH_0 => 32,
  BIT_WIDTH_1 => 32,
  READ_MODE => '0',
  RESET_MODE => "ASYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31 downto 0) => \fifo_inst/Small.wdata\(95 downto 64),
  CLKA => WrClk,
  CEA => fifo_inst_n32,
  CLKB => RdClk,
  CEB => fifo_inst_n36,
  OCE => GND_0,
  RESET => \fifo_inst/reset_r\(1),
  ADA(13 downto 5) => \fifo_inst/Small.wbin\(8 downto 0),
  ADA(4) => GND_0,
  ADA(3) => VCC_0,
  ADA(2) => VCC_0,
  ADA(1) => VCC_0,
  ADA(0) => VCC_0,
  ADB(13 downto 5) => \fifo_inst/rbin_num\(12 downto 4),
  ADB(4) => GND_0,
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  DI(31 downto 0) => Data(95 downto 64),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0);
\fifo_inst/Small.mem_Small.mem_0_3_s\: SDPB
generic map (
  BIT_WIDTH_0 => 32,
  BIT_WIDTH_1 => 32,
  READ_MODE => '0',
  RESET_MODE => "ASYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31 downto 0) => \fifo_inst/Small.wdata\(127 downto 96),
  CLKA => WrClk,
  CEA => fifo_inst_n32,
  CLKB => RdClk,
  CEB => fifo_inst_n36,
  OCE => GND_0,
  RESET => \fifo_inst/reset_r\(1),
  ADA(13 downto 5) => \fifo_inst/Small.wbin\(8 downto 0),
  ADA(4) => GND_0,
  ADA(3) => VCC_0,
  ADA(2) => VCC_0,
  ADA(1) => VCC_0,
  ADA(0) => VCC_0,
  ADB(13 downto 5) => \fifo_inst/rbin_num\(12 downto 4),
  ADB(4) => GND_0,
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  DI(31 downto 0) => Data(127 downto 96),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0);
\fifo_inst/Small.mem_Small.mem_0_4_s\: SDPB
generic map (
  BIT_WIDTH_0 => 32,
  BIT_WIDTH_1 => 32,
  READ_MODE => '0',
  RESET_MODE => "ASYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31 downto 0) => \fifo_inst/Small.wdata\(159 downto 128),
  CLKA => WrClk,
  CEA => fifo_inst_n32,
  CLKB => RdClk,
  CEB => fifo_inst_n36,
  OCE => GND_0,
  RESET => \fifo_inst/reset_r\(1),
  ADA(13 downto 5) => \fifo_inst/Small.wbin\(8 downto 0),
  ADA(4) => GND_0,
  ADA(3) => VCC_0,
  ADA(2) => VCC_0,
  ADA(1) => VCC_0,
  ADA(0) => VCC_0,
  ADB(13 downto 5) => \fifo_inst/rbin_num\(12 downto 4),
  ADB(4) => GND_0,
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  DI(31 downto 0) => Data(159 downto 128),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0);
\fifo_inst/Small.mem_Small.mem_0_5_s\: SDPB
generic map (
  BIT_WIDTH_0 => 32,
  BIT_WIDTH_1 => 32,
  READ_MODE => '0',
  RESET_MODE => "ASYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31 downto 0) => \fifo_inst/Small.wdata\(191 downto 160),
  CLKA => WrClk,
  CEA => fifo_inst_n32,
  CLKB => RdClk,
  CEB => fifo_inst_n36,
  OCE => GND_0,
  RESET => \fifo_inst/reset_r\(1),
  ADA(13 downto 5) => \fifo_inst/Small.wbin\(8 downto 0),
  ADA(4) => GND_0,
  ADA(3) => VCC_0,
  ADA(2) => VCC_0,
  ADA(1) => VCC_0,
  ADA(0) => VCC_0,
  ADB(13 downto 5) => \fifo_inst/rbin_num\(12 downto 4),
  ADB(4) => GND_0,
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  DI(31 downto 0) => Data(191 downto 160),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0);
\fifo_inst/Small.mem_Small.mem_0_6_s\: SDPB
generic map (
  BIT_WIDTH_0 => 32,
  BIT_WIDTH_1 => 32,
  READ_MODE => '0',
  RESET_MODE => "ASYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31 downto 0) => \fifo_inst/Small.wdata\(223 downto 192),
  CLKA => WrClk,
  CEA => fifo_inst_n32,
  CLKB => RdClk,
  CEB => fifo_inst_n36,
  OCE => GND_0,
  RESET => \fifo_inst/reset_r\(1),
  ADA(13 downto 5) => \fifo_inst/Small.wbin\(8 downto 0),
  ADA(4) => GND_0,
  ADA(3) => VCC_0,
  ADA(2) => VCC_0,
  ADA(1) => VCC_0,
  ADA(0) => VCC_0,
  ADB(13 downto 5) => \fifo_inst/rbin_num\(12 downto 4),
  ADB(4) => GND_0,
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  DI(31 downto 0) => Data(223 downto 192),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0);
\fifo_inst/Small.mem_Small.mem_0_7_s\: SDPB
generic map (
  BIT_WIDTH_0 => 32,
  BIT_WIDTH_1 => 32,
  READ_MODE => '0',
  RESET_MODE => "ASYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31 downto 0) => \fifo_inst/Small.wdata\(255 downto 224),
  CLKA => WrClk,
  CEA => fifo_inst_n32,
  CLKB => RdClk,
  CEB => fifo_inst_n36,
  OCE => GND_0,
  RESET => \fifo_inst/reset_r\(1),
  ADA(13 downto 5) => \fifo_inst/Small.wbin\(8 downto 0),
  ADA(4) => GND_0,
  ADA(3) => VCC_0,
  ADA(2) => VCC_0,
  ADA(1) => VCC_0,
  ADA(0) => VCC_0,
  ADB(13 downto 5) => \fifo_inst/rbin_num\(12 downto 4),
  ADB(4) => GND_0,
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  DI(31 downto 0) => Data(255 downto 224),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0);
\fifo_inst/rcnt_sub_1_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(1),
  COUT => fifo_inst_rcnt_sub_1,
  I0 => GND_0,
  I1 => \fifo_inst/rbin_num\(1),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_0);
\fifo_inst/rcnt_sub_2_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(2),
  COUT => fifo_inst_rcnt_sub_2,
  I0 => GND_0,
  I1 => \fifo_inst/rbin_num\(2),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_1);
\fifo_inst/rcnt_sub_3_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(3),
  COUT => fifo_inst_rcnt_sub_3,
  I0 => GND_0,
  I1 => \fifo_inst/rbin_num\(3),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_2);
\fifo_inst/rcnt_sub_4_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(4),
  COUT => fifo_inst_rcnt_sub_4,
  I0 => \fifo_inst/Small.wcount_r_1\(4),
  I1 => \fifo_inst/rbin_num\(4),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_3);
\fifo_inst/rcnt_sub_5_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(5),
  COUT => fifo_inst_rcnt_sub_5,
  I0 => \fifo_inst/Small.wcount_r_1\(5),
  I1 => \fifo_inst/rbin_num\(5),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_4);
\fifo_inst/rcnt_sub_6_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(6),
  COUT => fifo_inst_rcnt_sub_6,
  I0 => \fifo_inst/Small.wcount_r_1\(6),
  I1 => \fifo_inst/rbin_num\(6),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_5);
\fifo_inst/rcnt_sub_7_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(7),
  COUT => fifo_inst_rcnt_sub_7,
  I0 => \fifo_inst/Small.wcount_r_1\(7),
  I1 => \fifo_inst/rbin_num\(7),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_6);
\fifo_inst/rcnt_sub_8_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(8),
  COUT => fifo_inst_rcnt_sub_8,
  I0 => \fifo_inst/Small.wcount_r_1\(8),
  I1 => \fifo_inst/rbin_num\(8),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_7);
\fifo_inst/rcnt_sub_9_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(9),
  COUT => fifo_inst_rcnt_sub_9,
  I0 => \fifo_inst/Small.wcount_r_1\(9),
  I1 => \fifo_inst/rbin_num\(9),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_8);
\fifo_inst/rcnt_sub_10_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(10),
  COUT => fifo_inst_rcnt_sub_10,
  I0 => \fifo_inst/Small.wcount_r_1\(10),
  I1 => \fifo_inst/rbin_num\(10),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_9);
\fifo_inst/rcnt_sub_11_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(11),
  COUT => fifo_inst_rcnt_sub_11,
  I0 => \fifo_inst/Small.wcount_r_1\(11),
  I1 => \fifo_inst/rbin_num\(11),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_10);
\fifo_inst/rcnt_sub_12_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(12),
  COUT => fifo_inst_rcnt_sub_12,
  I0 => \fifo_inst/Small.wcount_r_1\(12),
  I1 => \fifo_inst/rbin_num\(12),
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_11);
\fifo_inst/rcnt_sub_13_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(13),
  COUT => fifo_inst_rcnt_sub_13,
  I0 => fifo_inst_n1049,
  I1 => GND_0,
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_12);
\fifo_inst/wcnt_sub_0_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/wcnt_sub\(0),
  COUT => fifo_inst_wcnt_sub_0,
  I0 => \fifo_inst/Small.wbin\(0),
  I1 => \fifo_inst/Small.rcount_w\(0),
  I3 => GND_0,
  CIN => VCC_0);
\fifo_inst/wcnt_sub_1_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/wcnt_sub\(1),
  COUT => fifo_inst_wcnt_sub_1,
  I0 => \fifo_inst/Small.wbin\(1),
  I1 => \fifo_inst/Small.rcount_w\(1),
  I3 => GND_0,
  CIN => fifo_inst_wcnt_sub_0);
\fifo_inst/wcnt_sub_2_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/wcnt_sub\(2),
  COUT => fifo_inst_wcnt_sub_2,
  I0 => \fifo_inst/Small.wbin\(2),
  I1 => \fifo_inst/Small.rcount_w\(2),
  I3 => GND_0,
  CIN => fifo_inst_wcnt_sub_1);
\fifo_inst/wcnt_sub_3_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/wcnt_sub\(3),
  COUT => fifo_inst_wcnt_sub_3,
  I0 => \fifo_inst/Small.wbin\(3),
  I1 => \fifo_inst/Small.rcount_w\(3),
  I3 => GND_0,
  CIN => fifo_inst_wcnt_sub_2);
\fifo_inst/wcnt_sub_4_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/wcnt_sub\(4),
  COUT => fifo_inst_wcnt_sub_4,
  I0 => \fifo_inst/Small.wbin\(4),
  I1 => \fifo_inst/Small.rcount_w\(4),
  I3 => GND_0,
  CIN => fifo_inst_wcnt_sub_3);
\fifo_inst/wcnt_sub_5_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/wcnt_sub\(5),
  COUT => fifo_inst_wcnt_sub_5,
  I0 => \fifo_inst/Small.wbin\(5),
  I1 => \fifo_inst/Small.rcount_w\(5),
  I3 => GND_0,
  CIN => fifo_inst_wcnt_sub_4);
\fifo_inst/wcnt_sub_6_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/wcnt_sub\(6),
  COUT => fifo_inst_wcnt_sub_6,
  I0 => \fifo_inst/Small.wbin\(6),
  I1 => \fifo_inst/Small.rcount_w\(6),
  I3 => GND_0,
  CIN => fifo_inst_wcnt_sub_5);
\fifo_inst/wcnt_sub_7_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/wcnt_sub\(7),
  COUT => fifo_inst_wcnt_sub_7,
  I0 => \fifo_inst/Small.wbin\(7),
  I1 => \fifo_inst/Small.rcount_w\(7),
  I3 => GND_0,
  CIN => fifo_inst_wcnt_sub_6);
\fifo_inst/wcnt_sub_8_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/wcnt_sub\(8),
  COUT => fifo_inst_wcnt_sub_8,
  I0 => \fifo_inst/Small.wbin\(8),
  I1 => \fifo_inst/Small.rcount_w\(8),
  I3 => GND_0,
  CIN => fifo_inst_wcnt_sub_7);
\fifo_inst/wcnt_sub_9_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/wcnt_sub\(9),
  COUT => fifo_inst_wcnt_sub_9,
  I0 => fifo_inst_n1133,
  I1 => GND_0,
  I3 => GND_0,
  CIN => fifo_inst_wcnt_sub_8);
\fifo_inst/n1014_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1014,
  COUT => fifo_inst_n1014_3,
  I0 => \fifo_inst/Small.rgraynext\(0),
  I1 => \fifo_inst/Small.rq2_wptr\(0),
  I3 => GND_0,
  CIN => GND_0);
\fifo_inst/n1015_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1015,
  COUT => fifo_inst_n1015_3,
  I0 => \fifo_inst/Small.rgraynext\(1),
  I1 => \fifo_inst/Small.rq2_wptr\(1),
  I3 => GND_0,
  CIN => fifo_inst_n1014_3);
\fifo_inst/n1016_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1016,
  COUT => fifo_inst_n1016_3,
  I0 => \fifo_inst/Small.rgraynext\(2),
  I1 => \fifo_inst/Small.rq2_wptr\(2),
  I3 => GND_0,
  CIN => fifo_inst_n1015_3);
\fifo_inst/n1017_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1017,
  COUT => fifo_inst_n1017_3,
  I0 => \fifo_inst/Small.rgraynext\(3),
  I1 => \fifo_inst/Small.rq2_wptr\(3),
  I3 => GND_0,
  CIN => fifo_inst_n1016_3);
\fifo_inst/n1018_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1018,
  COUT => fifo_inst_n1018_3,
  I0 => \fifo_inst/Small.rgraynext\(4),
  I1 => \fifo_inst/Small.rq2_wptr\(4),
  I3 => GND_0,
  CIN => fifo_inst_n1017_3);
\fifo_inst/n1019_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1019,
  COUT => fifo_inst_n1019_3,
  I0 => \fifo_inst/Small.rgraynext\(5),
  I1 => \fifo_inst/Small.rq2_wptr\(5),
  I3 => GND_0,
  CIN => fifo_inst_n1018_3);
\fifo_inst/n1020_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1020,
  COUT => fifo_inst_n1020_3,
  I0 => \fifo_inst/Small.rgraynext\(6),
  I1 => \fifo_inst/Small.rq2_wptr\(6),
  I3 => GND_0,
  CIN => fifo_inst_n1019_3);
\fifo_inst/n1021_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1021,
  COUT => fifo_inst_n1021_3,
  I0 => \fifo_inst/Small.rgraynext\(7),
  I1 => \fifo_inst/Small.rq2_wptr\(7),
  I3 => GND_0,
  CIN => fifo_inst_n1020_3);
\fifo_inst/n1022_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1022,
  COUT => fifo_inst_n1022_3,
  I0 => \fifo_inst/Small.rgraynext\(8),
  I1 => \fifo_inst/Small.rq2_wptr\(8),
  I3 => GND_0,
  CIN => fifo_inst_n1021_3);
\fifo_inst/n32_s1\: LUT2
generic map (
  INIT => X"4"
)
port map (
  F => fifo_inst_n32,
  I0 => NN_0,
  I1 => WrEn);
\fifo_inst/n36_s0\: LUT2
generic map (
  INIT => X"4"
)
port map (
  F => fifo_inst_n36,
  I0 => NN,
  I1 => RdEn);
\fifo_inst/Small.rgraynext_0_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Small.rgraynext\(0),
  I0 => \fifo_inst/rbin_num_next\(4),
  I1 => \fifo_inst/rbin_num_next\(5));
\fifo_inst/Small.rgraynext_2_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Small.rgraynext\(2),
  I0 => \fifo_inst_Small.rgraynext_2\,
  I1 => \fifo_inst/rbin_num\(6),
  I2 => \fifo_inst/rbin_num\(7));
\fifo_inst/Small.rgraynext_3_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Small.rgraynext\(3),
  I0 => \fifo_inst_Small.rgraynext_2\,
  I1 => \fifo_inst/rbin_num\(6),
  I2 => \fifo_inst/rbin_num\(7),
  I3 => \fifo_inst/rbin_num\(8));
\fifo_inst/Small.rgraynext_4_s0\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => \fifo_inst/Small.rgraynext\(4),
  I0 => \fifo_inst_Small.rgraynext_4\,
  I1 => \fifo_inst/rbin_num\(9));
\fifo_inst/Small.rgraynext_5_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Small.rgraynext\(5),
  I0 => \fifo_inst_Small.rgraynext_5\,
  I1 => \fifo_inst/rbin_num\(9),
  I2 => \fifo_inst/rbin_num\(10));
\fifo_inst/Small.rgraynext_6_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Small.rgraynext\(6),
  I0 => \fifo_inst_Small.rgraynext_2\,
  I1 => \fifo_inst_Small.rgraynext_6\,
  I2 => \fifo_inst/rbin_num\(10),
  I3 => \fifo_inst/rbin_num\(11));
\fifo_inst/Small.rgraynext_7_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Small.rgraynext\(7),
  I0 => \fifo_inst_Small.rgraynext_7\,
  I1 => \fifo_inst/rbin_num\(11),
  I2 => \fifo_inst/rbin_num\(12));
\fifo_inst/Small.rgraynext_8_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Small.rgraynext\(8),
  I0 => \fifo_inst_Small.rgraynext_7\,
  I1 => \fifo_inst/rbin_num\(11),
  I2 => \fifo_inst/rbin_num\(12),
  I3 => \fifo_inst/rbin_num\(13));
\fifo_inst/Small.wcount_r_1_12_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Small.wcount_r_1\(12),
  I0 => \fifo_inst/Small.rq2_wptr\(9),
  I1 => \fifo_inst/Small.rq2_wptr\(8));
\fifo_inst/Small.wcount_r_1_9_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Small.wcount_r_1\(9),
  I0 => \fifo_inst/Small.wcount_r_1\(10),
  I1 => \fifo_inst/Small.rq2_wptr\(5));
\fifo_inst/Small.wcount_r_1_7_s0\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => \fifo_inst/Small.wcount_r_1\(7),
  I0 => \fifo_inst/Small.wcount_r_1\(10),
  I1 => \fifo_inst/Small.rq2_wptr\(5),
  I2 => \fifo_inst/Small.rq2_wptr\(4),
  I3 => \fifo_inst/Small.rq2_wptr\(3));
\fifo_inst/Small.wcount_r_1_6_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Small.wcount_r_1\(6),
  I0 => \fifo_inst/Small.wcount_r_1\(7),
  I1 => \fifo_inst/Small.rq2_wptr\(2));
\fifo_inst/Small.wcount_r_1_5_s0\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Small.wcount_r_1\(5),
  I0 => \fifo_inst/Small.wcount_r_1\(7),
  I1 => \fifo_inst/Small.rq2_wptr\(2),
  I2 => \fifo_inst/Small.rq2_wptr\(1));
\fifo_inst/Small.wcount_r_1_4_s0\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => \fifo_inst/Small.wcount_r_1\(4),
  I0 => \fifo_inst/Small.wcount_r_1\(7),
  I1 => \fifo_inst/Small.rq2_wptr\(2),
  I2 => \fifo_inst/Small.rq2_wptr\(1),
  I3 => \fifo_inst/Small.rq2_wptr\(0));
\fifo_inst/n1049_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => fifo_inst_n1049,
  I0 => \fifo_inst/Small.rq2_wptr\(9),
  I1 => \fifo_inst/rbin_num\(13));
\fifo_inst/Small.wgraynext_0_s0\: LUT4
generic map (
  INIT => X"0DF2"
)
port map (
  F => \fifo_inst/Small.wgraynext\(0),
  I0 => WrEn,
  I1 => NN_0,
  I2 => \fifo_inst/Small.wbin\(0),
  I3 => \fifo_inst/Small.wbin\(1));
\fifo_inst/Small.wgraynext_1_s0\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => \fifo_inst/Small.wgraynext\(1),
  I0 => \fifo_inst_Small.wgraynext_1\,
  I1 => \fifo_inst/Small.wbin\(2));
\fifo_inst/Small.wgraynext_2_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Small.wgraynext\(2),
  I0 => \fifo_inst_Small.wgraynext_2\,
  I1 => \fifo_inst/Small.wbin\(2),
  I2 => \fifo_inst/Small.wbin\(3));
\fifo_inst/Small.wgraynext_3_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Small.wgraynext\(3),
  I0 => \fifo_inst_Small.wgraynext_2\,
  I1 => \fifo_inst/Small.wbin\(2),
  I2 => \fifo_inst/Small.wbin\(3),
  I3 => \fifo_inst/Small.wbin\(4));
\fifo_inst/Small.wgraynext_4_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Small.wgraynext\(4),
  I0 => \fifo_inst_Small.wgraynext_4\,
  I1 => \fifo_inst/Small.wbin\(4),
  I2 => \fifo_inst/Small.wbin\(5));
\fifo_inst/Small.wgraynext_6_s0\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => \fifo_inst/Small.wgraynext\(6),
  I0 => \fifo_inst_Small.wgraynext_6\,
  I1 => \fifo_inst/Small.wbin\(7));
\fifo_inst/Small.wgraynext_7_s0\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => \fifo_inst/Small.wgraynext\(7),
  I0 => \fifo_inst_Small.wgraynext_7\,
  I1 => \fifo_inst/Small.wbin\(8));
\fifo_inst/Small.wgraynext_8_s0\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => \fifo_inst/Small.wgraynext\(8),
  I0 => \fifo_inst_Small.wgraynext_8\,
  I1 => \fifo_inst/Small.wptr\(9));
\fifo_inst/wfull_val_s0\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => fifo_inst_wfull_val,
  I0 => fifo_inst_wfull_val_4,
  I1 => fifo_inst_wfull_val_5,
  I2 => fifo_inst_wfull_val_6,
  I3 => fifo_inst_wfull_val_7);
\fifo_inst/Small.rcount_w_8_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Small.rcount_w\(8),
  I0 => \fifo_inst/Small.wq2_rptr\(9),
  I1 => \fifo_inst/Small.wq2_rptr\(8));
\fifo_inst/Small.rcount_w_5_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Small.rcount_w\(5),
  I0 => \fifo_inst/Small.rcount_w\(6),
  I1 => \fifo_inst/Small.wq2_rptr\(5));
\fifo_inst/Small.rcount_w_2_s0\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => \fifo_inst/Small.rcount_w\(2),
  I0 => \fifo_inst/Small.rcount_w\(6),
  I1 => \fifo_inst_Small.rcount_w_2\);
\fifo_inst/Small.rcount_w_1_s0\: LUT3
generic map (
  INIT => X"69"
)
port map (
  F => \fifo_inst/Small.rcount_w\(1),
  I0 => \fifo_inst/Small.rcount_w\(6),
  I1 => \fifo_inst_Small.rcount_w_2\,
  I2 => \fifo_inst/Small.wq2_rptr\(1));
\fifo_inst/n1133_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => fifo_inst_n1133,
  I0 => \fifo_inst/Small.wq2_rptr\(9),
  I1 => \fifo_inst/Small.wptr\(9));
\fifo_inst/n1247_s0\: LUT4
generic map (
  INIT => X"FFFE"
)
port map (
  F => fifo_inst_n1247,
  I0 => fifo_inst_n1247_4,
  I1 => \fifo_inst/wcnt_sub\(7),
  I2 => \fifo_inst/wcnt_sub\(8),
  I3 => \fifo_inst/wcnt_sub\(9));
\fifo_inst/Small.wdata_q_15_s17\: LUT4
generic map (
  INIT => X"7FFF"
)
port map (
  F => \fifo_inst/Small.wdata_q\(15),
  I0 => \fifo_inst_Small.wdata_q_15\,
  I1 => \fifo_inst_Small.wdata_q_15_23\,
  I2 => \fifo_inst_Small.wdata_q_15_24\,
  I3 => \fifo_inst_Small.wdata_q_15_25\);
\fifo_inst/Small.wdata_q_14_s17\: LUT2
generic map (
  INIT => X"7"
)
port map (
  F => \fifo_inst/Small.wdata_q\(14),
  I0 => \fifo_inst_Small.wdata_q_14\,
  I1 => \fifo_inst_Small.wdata_q_14_23\);
\fifo_inst/Small.wdata_q_13_s17\: LUT4
generic map (
  INIT => X"7FFF"
)
port map (
  F => \fifo_inst/Small.wdata_q\(13),
  I0 => \fifo_inst_Small.wdata_q_13\,
  I1 => \fifo_inst_Small.wdata_q_13_23\,
  I2 => \fifo_inst_Small.wdata_q_13_24\,
  I3 => \fifo_inst_Small.wdata_q_13_25\);
\fifo_inst/Small.wdata_q_12_s17\: LUT4
generic map (
  INIT => X"7FFF"
)
port map (
  F => \fifo_inst/Small.wdata_q\(12),
  I0 => \fifo_inst_Small.wdata_q_12\,
  I1 => \fifo_inst_Small.wdata_q_12_23\,
  I2 => \fifo_inst_Small.wdata_q_12_24\,
  I3 => \fifo_inst_Small.wdata_q_12_25\);
\fifo_inst/Small.wdata_q_11_s17\: LUT2
generic map (
  INIT => X"7"
)
port map (
  F => \fifo_inst/Small.wdata_q\(11),
  I0 => \fifo_inst_Small.wdata_q_11\,
  I1 => \fifo_inst_Small.wdata_q_11_23\);
\fifo_inst/Small.wdata_q_10_s17\: LUT2
generic map (
  INIT => X"7"
)
port map (
  F => \fifo_inst/Small.wdata_q\(10),
  I0 => \fifo_inst_Small.wdata_q_10\,
  I1 => \fifo_inst_Small.wdata_q_10_23\);
\fifo_inst/Small.wdata_q_9_s17\: LUT2
generic map (
  INIT => X"7"
)
port map (
  F => \fifo_inst/Small.wdata_q\(9),
  I0 => \fifo_inst_Small.wdata_q_9\,
  I1 => \fifo_inst_Small.wdata_q_9_23\);
\fifo_inst/Small.wdata_q_8_s17\: LUT2
generic map (
  INIT => X"7"
)
port map (
  F => \fifo_inst/Small.wdata_q\(8),
  I0 => \fifo_inst_Small.wdata_q_8\,
  I1 => \fifo_inst_Small.wdata_q_8_23\);
\fifo_inst/Small.wdata_q_7_s17\: LUT2
generic map (
  INIT => X"7"
)
port map (
  F => \fifo_inst/Small.wdata_q\(7),
  I0 => \fifo_inst_Small.wdata_q_7\,
  I1 => \fifo_inst_Small.wdata_q_7_23\);
\fifo_inst/Small.wdata_q_6_s17\: LUT4
generic map (
  INIT => X"7FFF"
)
port map (
  F => \fifo_inst/Small.wdata_q\(6),
  I0 => \fifo_inst_Small.wdata_q_6\,
  I1 => \fifo_inst_Small.wdata_q_6_23\,
  I2 => \fifo_inst_Small.wdata_q_6_24\,
  I3 => \fifo_inst_Small.wdata_q_6_25\);
\fifo_inst/Small.wdata_q_5_s17\: LUT4
generic map (
  INIT => X"7FFF"
)
port map (
  F => \fifo_inst/Small.wdata_q\(5),
  I0 => \fifo_inst_Small.wdata_q_5\,
  I1 => \fifo_inst_Small.wdata_q_5_23\,
  I2 => \fifo_inst_Small.wdata_q_5_24\,
  I3 => \fifo_inst_Small.wdata_q_5_25\);
\fifo_inst/Small.wdata_q_4_s17\: LUT4
generic map (
  INIT => X"7FFF"
)
port map (
  F => \fifo_inst/Small.wdata_q\(4),
  I0 => \fifo_inst_Small.wdata_q_4\,
  I1 => \fifo_inst_Small.wdata_q_4_23\,
  I2 => \fifo_inst_Small.wdata_q_4_24\,
  I3 => \fifo_inst_Small.wdata_q_4_25\);
\fifo_inst/Small.wdata_q_3_s17\: LUT2
generic map (
  INIT => X"7"
)
port map (
  F => \fifo_inst/Small.wdata_q\(3),
  I0 => \fifo_inst_Small.wdata_q_3\,
  I1 => \fifo_inst_Small.wdata_q_3_23\);
\fifo_inst/Small.wdata_q_2_s17\: LUT2
generic map (
  INIT => X"7"
)
port map (
  F => \fifo_inst/Small.wdata_q\(2),
  I0 => \fifo_inst_Small.wdata_q_2\,
  I1 => \fifo_inst_Small.wdata_q_2_23\);
\fifo_inst/Small.wdata_q_1_s17\: LUT4
generic map (
  INIT => X"7FFF"
)
port map (
  F => \fifo_inst/Small.wdata_q\(1),
  I0 => \fifo_inst_Small.wdata_q_1\,
  I1 => \fifo_inst_Small.wdata_q_1_23\,
  I2 => \fifo_inst_Small.wdata_q_1_24\,
  I3 => \fifo_inst_Small.wdata_q_1_25\);
\fifo_inst/Small.wdata_q_0_s17\: LUT2
generic map (
  INIT => X"7"
)
port map (
  F => \fifo_inst/Small.wdata_q\(0),
  I0 => \fifo_inst_Small.wdata_q_0\,
  I1 => \fifo_inst_Small.wdata_q_0_23\);
\fifo_inst/Small.wbinnext_1_s3\: LUT2
generic map (
  INIT => X"1"
)
port map (
  F => \fifo_inst/Small.wbinnext\(1),
  I0 => \fifo_inst_Small.wgraynext_1\,
  I1 => \fifo_inst_Small.wgraynext_2\);
\fifo_inst/Small.wbinnext_2_s3\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Small.wbinnext\(2),
  I0 => \fifo_inst_Small.wgraynext_2\,
  I1 => \fifo_inst/Small.wbin\(2));
\fifo_inst/Small.wbinnext_3_s3\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/Small.wbinnext\(3),
  I0 => \fifo_inst_Small.wgraynext_2\,
  I1 => \fifo_inst/Small.wbin\(2),
  I2 => \fifo_inst/Small.wbin\(3));
\fifo_inst/Small.wbinnext_5_s3\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Small.wbinnext\(5),
  I0 => \fifo_inst_Small.wbinnext_5\,
  I1 => \fifo_inst/Small.wbin\(5));
\fifo_inst/Small.wbinnext_6_s3\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/Small.wbinnext\(6),
  I0 => \fifo_inst_Small.wbinnext_5\,
  I1 => \fifo_inst/Small.wbin\(5),
  I2 => \fifo_inst/Small.wbin\(6));
\fifo_inst/Small.wbinnext_7_s3\: LUT3
generic map (
  INIT => X"07"
)
port map (
  F => \fifo_inst/Small.wbinnext\(7),
  I0 => \fifo_inst_Small.wbinnext_7\,
  I1 => \fifo_inst_Small.wbinnext_5\,
  I2 => \fifo_inst_Small.wgraynext_7\);
\fifo_inst/rbin_num_next_2_s3\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/rbin_num_next\(2),
  I0 => fifo_inst_rbin_num_next_2,
  I1 => \fifo_inst/rbin_num\(2));
\fifo_inst/rbin_num_next_3_s3\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/rbin_num_next\(3),
  I0 => fifo_inst_rbin_num_next_2,
  I1 => \fifo_inst/rbin_num\(2),
  I2 => \fifo_inst/rbin_num\(3));
\fifo_inst/rbin_num_next_5_s3\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/rbin_num_next\(5),
  I0 => fifo_inst_n36,
  I1 => fifo_inst_rbin_num_next_4,
  I2 => \fifo_inst/rbin_num\(4),
  I3 => \fifo_inst/rbin_num\(5));
\fifo_inst/rbin_num_next_6_s3\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/rbin_num_next\(6),
  I0 => \fifo_inst_Small.rgraynext_2\,
  I1 => \fifo_inst/rbin_num\(6));
\fifo_inst/rbin_num_next_7_s3\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/rbin_num_next\(7),
  I0 => \fifo_inst_Small.rgraynext_2\,
  I1 => \fifo_inst/rbin_num\(6),
  I2 => \fifo_inst/rbin_num\(7));
\fifo_inst/rbin_num_next_8_s3\: LUT2
generic map (
  INIT => X"1"
)
port map (
  F => \fifo_inst/rbin_num_next\(8),
  I0 => \fifo_inst_Small.rgraynext_4\,
  I1 => \fifo_inst_Small.rgraynext_5\);
\fifo_inst/rbin_num_next_9_s3\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/rbin_num_next\(9),
  I0 => \fifo_inst_Small.rgraynext_5\,
  I1 => \fifo_inst/rbin_num\(9));
\fifo_inst/rbin_num_next_10_s3\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/rbin_num_next\(10),
  I0 => \fifo_inst_Small.rgraynext_2\,
  I1 => \fifo_inst_Small.rgraynext_6\,
  I2 => \fifo_inst/rbin_num\(10));
\fifo_inst/rbin_num_next_12_s3\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/rbin_num_next\(12),
  I0 => \fifo_inst_Small.rgraynext_7\,
  I1 => \fifo_inst/rbin_num\(11),
  I2 => \fifo_inst/rbin_num\(12));
\fifo_inst/rbin_num_next_13_s2\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/rbin_num_next\(13),
  I0 => \fifo_inst_Small.rgraynext_7\,
  I1 => \fifo_inst/rbin_num\(11),
  I2 => \fifo_inst/rbin_num\(12),
  I3 => \fifo_inst/rbin_num\(13));
\fifo_inst/Small.rgraynext_2_s1\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.rgraynext_2\,
  I0 => fifo_inst_n36,
  I1 => fifo_inst_rbin_num_next_4,
  I2 => \fifo_inst/rbin_num\(4),
  I3 => \fifo_inst/rbin_num\(5));
\fifo_inst/Small.rgraynext_4_s1\: LUT4
generic map (
  INIT => X"007F"
)
port map (
  F => \fifo_inst_Small.rgraynext_4\,
  I0 => \fifo_inst/rbin_num\(6),
  I1 => \fifo_inst/rbin_num\(7),
  I2 => \fifo_inst_Small.rgraynext_2\,
  I3 => \fifo_inst/rbin_num\(8));
\fifo_inst/Small.rgraynext_5_s1\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.rgraynext_5\,
  I0 => \fifo_inst_Small.rgraynext_2\,
  I1 => \fifo_inst/rbin_num\(6),
  I2 => \fifo_inst/rbin_num\(7),
  I3 => \fifo_inst/rbin_num\(8));
\fifo_inst/Small.rgraynext_6_s1\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.rgraynext_6\,
  I0 => \fifo_inst/rbin_num\(6),
  I1 => \fifo_inst/rbin_num\(7),
  I2 => \fifo_inst/rbin_num\(8),
  I3 => \fifo_inst/rbin_num\(9));
\fifo_inst/Small.rgraynext_7_s1\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => \fifo_inst_Small.rgraynext_7\,
  I0 => \fifo_inst_Small.rgraynext_2\,
  I1 => \fifo_inst_Small.rgraynext_6\,
  I2 => \fifo_inst/rbin_num\(10));
\fifo_inst/Small.wgraynext_1_s1\: LUT4
generic map (
  INIT => X"00BF"
)
port map (
  F => \fifo_inst_Small.wgraynext_1\,
  I0 => NN_0,
  I1 => \fifo_inst/Small.wbin\(0),
  I2 => WrEn,
  I3 => \fifo_inst/Small.wbin\(1));
\fifo_inst/Small.wgraynext_2_s1\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => \fifo_inst_Small.wgraynext_2\,
  I0 => NN_0,
  I1 => WrEn,
  I2 => \fifo_inst/Small.wbin\(0),
  I3 => \fifo_inst/Small.wbin\(1));
\fifo_inst/Small.wgraynext_4_s1\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => \fifo_inst_Small.wgraynext_4\,
  I0 => \fifo_inst_Small.wgraynext_2\,
  I1 => \fifo_inst/Small.wbin\(2),
  I2 => \fifo_inst/Small.wbin\(3));
\fifo_inst/Small.wgraynext_6_s1\: LUT4
generic map (
  INIT => X"007F"
)
port map (
  F => \fifo_inst_Small.wgraynext_6\,
  I0 => \fifo_inst_Small.wgraynext_6_5\,
  I1 => \fifo_inst/Small.wbin\(5),
  I2 => \fifo_inst_Small.wgraynext_2\,
  I3 => \fifo_inst/Small.wbin\(6));
\fifo_inst/Small.wgraynext_7_s1\: LUT4
generic map (
  INIT => X"007F"
)
port map (
  F => \fifo_inst_Small.wgraynext_7\,
  I0 => \fifo_inst_Small.wgraynext_6_5\,
  I1 => \fifo_inst_Small.wgraynext_7_5\,
  I2 => \fifo_inst_Small.wgraynext_2\,
  I3 => \fifo_inst/Small.wbin\(7));
\fifo_inst/Small.wgraynext_8_s1\: LUT4
generic map (
  INIT => X"007F"
)
port map (
  F => \fifo_inst_Small.wgraynext_8\,
  I0 => \fifo_inst_Small.wgraynext_6_5\,
  I1 => \fifo_inst_Small.wbinnext_7\,
  I2 => \fifo_inst_Small.wgraynext_2\,
  I3 => \fifo_inst/Small.wbin\(8));
\fifo_inst/wfull_val_s1\: LUT4
generic map (
  INIT => X"FBC7"
)
port map (
  F => fifo_inst_wfull_val_4,
  I0 => \fifo_inst_Small.wgraynext_4\,
  I1 => fifo_inst_wfull_val_8,
  I2 => \fifo_inst/Small.wbin\(4),
  I3 => fifo_inst_wfull_val_9);
\fifo_inst/wfull_val_s2\: LUT4
generic map (
  INIT => X"6900"
)
port map (
  F => fifo_inst_wfull_val_5,
  I0 => \fifo_inst_Small.wgraynext_8\,
  I1 => \fifo_inst/Small.wq2_rptr\(8),
  I2 => \fifo_inst/Small.wptr\(9),
  I3 => fifo_inst_wfull_val_10);
\fifo_inst/wfull_val_s3\: LUT4
generic map (
  INIT => X"0880"
)
port map (
  F => fifo_inst_wfull_val_6,
  I0 => fifo_inst_wfull_val_11,
  I1 => fifo_inst_wfull_val_12,
  I2 => \fifo_inst_Small.wbinnext_8\,
  I3 => fifo_inst_n1133);
\fifo_inst/wfull_val_s4\: LUT4
generic map (
  INIT => X"8241"
)
port map (
  F => fifo_inst_wfull_val_7,
  I0 => \fifo_inst_Small.wgraynext_6\,
  I1 => \fifo_inst_Small.wgraynext_7\,
  I2 => fifo_inst_wfull_val_13,
  I3 => fifo_inst_wfull_val_14);
\fifo_inst/Small.rcount_w_2_s1\: LUT4
generic map (
  INIT => X"9669"
)
port map (
  F => \fifo_inst_Small.rcount_w_2\,
  I0 => \fifo_inst/Small.wq2_rptr\(2),
  I1 => \fifo_inst/Small.wq2_rptr\(3),
  I2 => \fifo_inst/Small.wq2_rptr\(4),
  I3 => \fifo_inst/Small.wq2_rptr\(5));
\fifo_inst/n1247_s1\: LUT4
generic map (
  INIT => X"8F00"
)
port map (
  F => fifo_inst_n1247_4,
  I0 => fifo_inst_n1247_5,
  I1 => \fifo_inst/wcnt_sub\(2),
  I2 => fifo_inst_Almost_Full_7,
  I3 => \fifo_inst/wcnt_sub\(6));
\fifo_inst/Almost_Full_s4\: LUT3
generic map (
  INIT => X"10"
)
port map (
  F => fifo_inst_Almost_Full,
  I0 => WrEn,
  I1 => \fifo_inst/wcnt_sub\(0),
  I2 => fifo_inst_Almost_Full_8);
\fifo_inst/Almost_Full_s5\: LUT2
generic map (
  INIT => X"1"
)
port map (
  F => fifo_inst_Almost_Full_7,
  I0 => \fifo_inst/wcnt_sub\(4),
  I1 => \fifo_inst/wcnt_sub\(5));
\fifo_inst/Small.wdata_q_15_s18\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_15\,
  I0 => \fifo_inst_Small.wdata_q_15_26\,
  I1 => \fifo_inst_Small.wdata_q_15_27\,
  I2 => \fifo_inst_Small.wdata_q_15_28\,
  I3 => \fifo_inst_Small.wdata_q_15_29\);
\fifo_inst/Small.wdata_q_15_s19\: LUT4
generic map (
  INIT => X"0700"
)
port map (
  F => \fifo_inst_Small.wdata_q_15_23\,
  I0 => \fifo_inst/Small.wdata\(127),
  I1 => \fifo_inst_Small.wdata_q_15_30\,
  I2 => \fifo_inst_Small.wdata_q_15_31\,
  I3 => \fifo_inst_Small.wdata_q_15_32\);
\fifo_inst/Small.wdata_q_15_s20\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_15_24\,
  I0 => \fifo_inst/Small.wdata\(175),
  I1 => \fifo_inst_Small.wdata_q_15_33\,
  I2 => \fifo_inst_Small.wdata_q_15_34\,
  I3 => \fifo_inst/Small.wdata\(223));
\fifo_inst/Small.wdata_q_15_s21\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_15_25\,
  I0 => \fifo_inst_Small.wdata_q_15_35\,
  I1 => \fifo_inst/Small.wdata\(111),
  I2 => \fifo_inst_Small.wdata_q_15_36\,
  I3 => \fifo_inst/Small.wdata\(15));
\fifo_inst/Small.wdata_q_14_s18\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_14\,
  I0 => \fifo_inst_Small.wdata_q_14_24\,
  I1 => \fifo_inst_Small.wdata_q_14_25\,
  I2 => \fifo_inst_Small.wdata_q_14_26\,
  I3 => \fifo_inst_Small.wdata_q_14_27\);
\fifo_inst/Small.wdata_q_14_s19\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_14_23\,
  I0 => \fifo_inst_Small.wdata_q_14_28\,
  I1 => \fifo_inst_Small.wdata_q_14_29\,
  I2 => \fifo_inst_Small.wdata_q_14_30\,
  I3 => \fifo_inst_Small.wdata_q_14_31\);
\fifo_inst/Small.wdata_q_13_s18\: LUT4
generic map (
  INIT => X"0700"
)
port map (
  F => \fifo_inst_Small.wdata_q_13\,
  I0 => \fifo_inst/Small.wdata\(109),
  I1 => \fifo_inst_Small.wdata_q_15_35\,
  I2 => \fifo_inst_Small.wdata_q_13_26\,
  I3 => \fifo_inst_Small.wdata_q_13_27\);
\fifo_inst/Small.wdata_q_13_s19\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_13_23\,
  I0 => \fifo_inst_Small.wdata_q_13_28\,
  I1 => \fifo_inst_Small.wdata_q_13_29\,
  I2 => \fifo_inst_Small.wdata_q_13_30\,
  I3 => \fifo_inst_Small.wdata_q_13_31\);
\fifo_inst/Small.wdata_q_13_s20\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_13_24\,
  I0 => \fifo_inst_Small.wdata_q_15_33\,
  I1 => \fifo_inst/Small.wdata\(173),
  I2 => \fifo_inst_Small.wdata_q_13_32\,
  I3 => \fifo_inst/Small.wdata\(45));
\fifo_inst/Small.wdata_q_13_s21\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_13_25\,
  I0 => \fifo_inst/Small.wdata\(13),
  I1 => \fifo_inst_Small.wdata_q_15_36\,
  I2 => \fifo_inst_Small.wdata_q_13_33\,
  I3 => \fifo_inst/Small.wdata\(77));
\fifo_inst/Small.wdata_q_12_s18\: LUT4
generic map (
  INIT => X"0700"
)
port map (
  F => \fifo_inst_Small.wdata_q_12\,
  I0 => \fifo_inst/Small.wdata\(124),
  I1 => \fifo_inst_Small.wdata_q_15_30\,
  I2 => \fifo_inst_Small.wdata_q_12_26\,
  I3 => \fifo_inst_Small.wdata_q_12_27\);
\fifo_inst/Small.wdata_q_12_s19\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_12_23\,
  I0 => \fifo_inst_Small.wdata_q_12_28\,
  I1 => \fifo_inst_Small.wdata_q_12_29\,
  I2 => \fifo_inst_Small.wdata_q_12_30\,
  I3 => \fifo_inst_Small.wdata_q_12_31\);
\fifo_inst/Small.wdata_q_12_s20\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_12_24\,
  I0 => \fifo_inst_Small.wdata_q_12_32\,
  I1 => \fifo_inst/Small.wdata\(204),
  I2 => \fifo_inst_Small.wdata_q_12_33\,
  I3 => \fifo_inst/Small.wdata\(140));
\fifo_inst/Small.wdata_q_12_s21\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_12_25\,
  I0 => \fifo_inst_Small.wdata_q_15_33\,
  I1 => \fifo_inst/Small.wdata\(172),
  I2 => \fifo_inst_Small.wdata_q_12_34\,
  I3 => \fifo_inst/Small.wdata\(156));
\fifo_inst/Small.wdata_q_11_s18\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_11\,
  I0 => \fifo_inst_Small.wdata_q_11_24\,
  I1 => \fifo_inst_Small.wdata_q_11_25\,
  I2 => \fifo_inst_Small.wdata_q_11_26\,
  I3 => \fifo_inst_Small.wdata_q_11_27\);
\fifo_inst/Small.wdata_q_11_s19\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_11_23\,
  I0 => \fifo_inst_Small.wdata_q_11_28\,
  I1 => \fifo_inst_Small.wdata_q_11_29\,
  I2 => \fifo_inst_Small.wdata_q_11_30\,
  I3 => \fifo_inst_Small.wdata_q_11_31\);
\fifo_inst/Small.wdata_q_10_s18\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_10\,
  I0 => \fifo_inst_Small.wdata_q_10_24\,
  I1 => \fifo_inst_Small.wdata_q_10_25\,
  I2 => \fifo_inst_Small.wdata_q_10_26\,
  I3 => \fifo_inst_Small.wdata_q_10_27\);
\fifo_inst/Small.wdata_q_10_s19\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_10_23\,
  I0 => \fifo_inst_Small.wdata_q_10_28\,
  I1 => \fifo_inst_Small.wdata_q_10_29\,
  I2 => \fifo_inst_Small.wdata_q_10_30\,
  I3 => \fifo_inst_Small.wdata_q_10_31\);
\fifo_inst/Small.wdata_q_9_s18\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_9\,
  I0 => \fifo_inst_Small.wdata_q_9_24\,
  I1 => \fifo_inst_Small.wdata_q_9_25\,
  I2 => \fifo_inst_Small.wdata_q_9_26\,
  I3 => \fifo_inst_Small.wdata_q_9_27\);
\fifo_inst/Small.wdata_q_9_s19\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_9_23\,
  I0 => \fifo_inst_Small.wdata_q_9_28\,
  I1 => \fifo_inst_Small.wdata_q_9_29\,
  I2 => \fifo_inst_Small.wdata_q_9_30\,
  I3 => \fifo_inst_Small.wdata_q_9_31\);
\fifo_inst/Small.wdata_q_8_s18\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_8\,
  I0 => \fifo_inst_Small.wdata_q_8_24\,
  I1 => \fifo_inst_Small.wdata_q_8_25\,
  I2 => \fifo_inst_Small.wdata_q_8_26\,
  I3 => \fifo_inst_Small.wdata_q_8_27\);
\fifo_inst/Small.wdata_q_8_s19\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_8_23\,
  I0 => \fifo_inst_Small.wdata_q_8_28\,
  I1 => \fifo_inst_Small.wdata_q_8_29\,
  I2 => \fifo_inst_Small.wdata_q_8_30\,
  I3 => \fifo_inst_Small.wdata_q_8_31\);
\fifo_inst/Small.wdata_q_7_s18\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_7\,
  I0 => \fifo_inst_Small.wdata_q_7_24\,
  I1 => \fifo_inst_Small.wdata_q_7_25\,
  I2 => \fifo_inst_Small.wdata_q_7_26\,
  I3 => \fifo_inst_Small.wdata_q_7_27\);
\fifo_inst/Small.wdata_q_7_s19\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_7_23\,
  I0 => \fifo_inst_Small.wdata_q_7_28\,
  I1 => \fifo_inst_Small.wdata_q_7_29\,
  I2 => \fifo_inst_Small.wdata_q_7_30\,
  I3 => \fifo_inst_Small.wdata_q_7_31\);
\fifo_inst/Small.wdata_q_6_s18\: LUT4
generic map (
  INIT => X"0700"
)
port map (
  F => \fifo_inst_Small.wdata_q_6\,
  I0 => \fifo_inst/Small.wdata\(214),
  I1 => \fifo_inst_Small.wdata_q_15_34\,
  I2 => \fifo_inst_Small.wdata_q_6_26\,
  I3 => \fifo_inst_Small.wdata_q_6_27\);
\fifo_inst/Small.wdata_q_6_s19\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_6_23\,
  I0 => \fifo_inst_Small.wdata_q_6_28\,
  I1 => \fifo_inst_Small.wdata_q_6_29\,
  I2 => \fifo_inst_Small.wdata_q_6_30\,
  I3 => \fifo_inst_Small.wdata_q_6_31\);
\fifo_inst/Small.wdata_q_6_s20\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_6_24\,
  I0 => \fifo_inst/Small.wdata\(54),
  I1 => \fifo_inst_Small.wdata_q_6_32\,
  I2 => \fifo_inst_Small.wdata_q_12_33\,
  I3 => \fifo_inst/Small.wdata\(134));
\fifo_inst/Small.wdata_q_6_s21\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_6_25\,
  I0 => \fifo_inst/Small.wdata\(150),
  I1 => \fifo_inst_Small.wdata_q_12_34\,
  I2 => \fifo_inst_Small.wdata_q_6_33\,
  I3 => \fifo_inst/Small.wdata\(182));
\fifo_inst/Small.wdata_q_5_s18\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_5\,
  I0 => \fifo_inst_Small.wdata_q_5_26\,
  I1 => \fifo_inst_Small.wdata_q_5_27\,
  I2 => \fifo_inst_Small.wdata_q_5_28\,
  I3 => \fifo_inst_Small.wdata_q_5_29\);
\fifo_inst/Small.wdata_q_5_s19\: LUT4
generic map (
  INIT => X"0700"
)
port map (
  F => \fifo_inst_Small.wdata_q_5_23\,
  I0 => \fifo_inst/Small.wdata\(149),
  I1 => \fifo_inst_Small.wdata_q_12_34\,
  I2 => \fifo_inst_Small.wdata_q_5_30\,
  I3 => \fifo_inst_Small.wdata_q_5_31\);
\fifo_inst/Small.wdata_q_5_s20\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_5_24\,
  I0 => \fifo_inst_Small.wdata_q_15_35\,
  I1 => \fifo_inst/Small.wdata\(101),
  I2 => \fifo_inst_Small.wdata_q_15_36\,
  I3 => \fifo_inst/Small.wdata\(5));
\fifo_inst/Small.wdata_q_5_s21\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_5_25\,
  I0 => \fifo_inst_Small.wdata_q_5_32\,
  I1 => \fifo_inst/Small.wdata\(85),
  I2 => \fifo_inst_Small.wdata_q_13_33\,
  I3 => \fifo_inst/Small.wdata\(69));
\fifo_inst/Small.wdata_q_4_s18\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_4\,
  I0 => \fifo_inst_Small.wdata_q_4_26\,
  I1 => \fifo_inst_Small.wdata_q_4_27\,
  I2 => \fifo_inst_Small.wdata_q_4_28\,
  I3 => \fifo_inst_Small.wdata_q_4_29\);
\fifo_inst/Small.wdata_q_4_s19\: LUT4
generic map (
  INIT => X"0700"
)
port map (
  F => \fifo_inst_Small.wdata_q_4_23\,
  I0 => \fifo_inst/Small.wdata\(228),
  I1 => fifo_inst_rbin_num_next_4,
  I2 => \fifo_inst_Small.wdata_q_4_30\,
  I3 => \fifo_inst_Small.wdata_q_4_31\);
\fifo_inst/Small.wdata_q_4_s20\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_4_24\,
  I0 => \fifo_inst_Small.wdata_q_12_34\,
  I1 => \fifo_inst/Small.wdata\(148),
  I2 => \fifo_inst_Small.wdata_q_12_33\,
  I3 => \fifo_inst/Small.wdata\(132));
\fifo_inst/Small.wdata_q_4_s21\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_4_25\,
  I0 => \fifo_inst_Small.wdata_q_15_30\,
  I1 => \fifo_inst/Small.wdata\(116),
  I2 => \fifo_inst_Small.wdata_q_15_36\,
  I3 => \fifo_inst/Small.wdata\(4));
\fifo_inst/Small.wdata_q_3_s18\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_3\,
  I0 => \fifo_inst_Small.wdata_q_3_24\,
  I1 => \fifo_inst_Small.wdata_q_3_25\,
  I2 => \fifo_inst_Small.wdata_q_3_26\,
  I3 => \fifo_inst_Small.wdata_q_3_27\);
\fifo_inst/Small.wdata_q_3_s19\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_3_23\,
  I0 => \fifo_inst_Small.wdata_q_3_28\,
  I1 => \fifo_inst_Small.wdata_q_3_29\,
  I2 => \fifo_inst_Small.wdata_q_3_30\,
  I3 => \fifo_inst_Small.wdata_q_3_31\);
\fifo_inst/Small.wdata_q_2_s18\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_2\,
  I0 => \fifo_inst_Small.wdata_q_2_24\,
  I1 => \fifo_inst_Small.wdata_q_2_25\,
  I2 => \fifo_inst_Small.wdata_q_2_26\,
  I3 => \fifo_inst_Small.wdata_q_2_27\);
\fifo_inst/Small.wdata_q_2_s19\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_2_23\,
  I0 => \fifo_inst_Small.wdata_q_2_28\,
  I1 => \fifo_inst_Small.wdata_q_2_29\,
  I2 => \fifo_inst_Small.wdata_q_2_30\,
  I3 => \fifo_inst_Small.wdata_q_2_31\);
\fifo_inst/Small.wdata_q_1_s18\: LUT4
generic map (
  INIT => X"0700"
)
port map (
  F => \fifo_inst_Small.wdata_q_1\,
  I0 => \fifo_inst/Small.wdata\(1),
  I1 => \fifo_inst_Small.wdata_q_15_36\,
  I2 => \fifo_inst_Small.wdata_q_1_26\,
  I3 => \fifo_inst_Small.wdata_q_1_27\);
\fifo_inst/Small.wdata_q_1_s19\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_1_23\,
  I0 => \fifo_inst_Small.wdata_q_1_28\,
  I1 => \fifo_inst_Small.wdata_q_1_29\,
  I2 => \fifo_inst_Small.wdata_q_1_30\,
  I3 => \fifo_inst_Small.wdata_q_1_31\);
\fifo_inst/Small.wdata_q_1_s20\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_1_24\,
  I0 => \fifo_inst/Small.wdata\(113),
  I1 => \fifo_inst_Small.wdata_q_15_30\,
  I2 => \fifo_inst_Small.wdata_q_6_33\,
  I3 => \fifo_inst/Small.wdata\(177));
\fifo_inst/Small.wdata_q_1_s21\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_1_25\,
  I0 => \fifo_inst_Small.wdata_q_6_32\,
  I1 => \fifo_inst/Small.wdata\(49),
  I2 => \fifo_inst_Small.wdata_q_13_32\,
  I3 => \fifo_inst/Small.wdata\(33));
\fifo_inst/Small.wdata_q_0_s18\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_0\,
  I0 => \fifo_inst_Small.wdata_q_0_24\,
  I1 => \fifo_inst_Small.wdata_q_0_25\,
  I2 => \fifo_inst_Small.wdata_q_0_26\,
  I3 => \fifo_inst_Small.wdata_q_0_27\);
\fifo_inst/Small.wdata_q_0_s19\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wdata_q_0_23\,
  I0 => \fifo_inst_Small.wdata_q_0_28\,
  I1 => \fifo_inst_Small.wdata_q_0_29\,
  I2 => \fifo_inst_Small.wdata_q_0_30\,
  I3 => \fifo_inst_Small.wdata_q_0_31\);
\fifo_inst/Small.wbinnext_7_s4\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => \fifo_inst_Small.wbinnext_7\,
  I0 => \fifo_inst/Small.wbin\(5),
  I1 => \fifo_inst/Small.wbin\(6),
  I2 => \fifo_inst/Small.wbin\(7));
\fifo_inst/Small.wbinnext_8_s4\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => \fifo_inst_Small.wbinnext_8\,
  I0 => \fifo_inst_Small.wgraynext_2\,
  I1 => \fifo_inst_Small.wgraynext_6_5\,
  I2 => \fifo_inst_Small.wbinnext_8_9\);
\fifo_inst/rbin_num_next_4_s4\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => fifo_inst_rbin_num_next_4,
  I0 => \fifo_inst/rbin_num\(0),
  I1 => \fifo_inst/rbin_num\(1),
  I2 => \fifo_inst/rbin_num\(2),
  I3 => \fifo_inst/rbin_num\(3));
\fifo_inst/Small.wgraynext_6_s2\: LUT3
generic map (
  INIT => X"80"
)
port map (
  F => \fifo_inst_Small.wgraynext_6_5\,
  I0 => \fifo_inst/Small.wbin\(2),
  I1 => \fifo_inst/Small.wbin\(3),
  I2 => \fifo_inst/Small.wbin\(4));
\fifo_inst/Small.wgraynext_7_s2\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Small.wgraynext_7_5\,
  I0 => \fifo_inst/Small.wbin\(5),
  I1 => \fifo_inst/Small.wbin\(6));
\fifo_inst/wfull_val_s5\: LUT4
generic map (
  INIT => X"F807"
)
port map (
  F => fifo_inst_wfull_val_8,
  I0 => \fifo_inst_Small.wgraynext_2\,
  I1 => \fifo_inst/Small.wbin\(2),
  I2 => \fifo_inst/Small.wbin\(3),
  I3 => \fifo_inst/Small.wq2_rptr\(3));
\fifo_inst/wfull_val_s6\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => fifo_inst_wfull_val_9,
  I0 => \fifo_inst/Small.wq2_rptr\(4),
  I1 => \fifo_inst/Small.wbin\(5));
\fifo_inst/wfull_val_s7\: LUT4
generic map (
  INIT => X"9009"
)
port map (
  F => fifo_inst_wfull_val_10,
  I0 => \fifo_inst/Small.wgraynext\(0),
  I1 => \fifo_inst/Small.wq2_rptr\(0),
  I2 => \fifo_inst_Small.wgraynext_1\,
  I3 => fifo_inst_wfull_val_15);
\fifo_inst/wfull_val_s8\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => fifo_inst_wfull_val_11,
  I0 => \fifo_inst_Small.wgraynext_2\,
  I1 => \fifo_inst_Small.wgraynext_6_5\,
  I2 => \fifo_inst/Small.wbin\(5),
  I3 => fifo_inst_wfull_val_16);
\fifo_inst/wfull_val_s9\: LUT4
generic map (
  INIT => X"1EE1"
)
port map (
  F => fifo_inst_wfull_val_12,
  I0 => \fifo_inst_Small.wgraynext_2\,
  I1 => \fifo_inst/Small.wbin\(2),
  I2 => \fifo_inst/Small.wq2_rptr\(2),
  I3 => \fifo_inst/Small.wbin\(3));
\fifo_inst/wfull_val_s10\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => fifo_inst_wfull_val_13,
  I0 => \fifo_inst/Small.wq2_rptr\(7),
  I1 => \fifo_inst/Small.wbin\(8));
\fifo_inst/wfull_val_s11\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => fifo_inst_wfull_val_14,
  I0 => \fifo_inst/Small.wq2_rptr\(6),
  I1 => \fifo_inst/Small.wbin\(7));
\fifo_inst/n1247_s2\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => fifo_inst_n1247_5,
  I0 => WrEn,
  I1 => \fifo_inst/wcnt_sub\(0),
  I2 => \fifo_inst/wcnt_sub\(1),
  I3 => \fifo_inst/wcnt_sub\(3));
\fifo_inst/Almost_Full_s6\: LUT4
generic map (
  INIT => X"0001"
)
port map (
  F => fifo_inst_Almost_Full_8,
  I0 => \fifo_inst/wcnt_sub\(1),
  I1 => \fifo_inst/wcnt_sub\(2),
  I2 => \fifo_inst/wcnt_sub\(3),
  I3 => \fifo_inst/wcnt_sub\(6));
\fifo_inst/Small.wdata_q_15_s22\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_15_26\,
  I0 => \fifo_inst_Small.wdata_q_6_33\,
  I1 => \fifo_inst/Small.wdata\(191),
  I2 => \fifo_inst_Small.wdata_q_12_33\,
  I3 => \fifo_inst/Small.wdata\(143));
\fifo_inst/Small.wdata_q_15_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_15_27\,
  I0 => \fifo_inst/Small.wdata\(47),
  I1 => \fifo_inst_Small.wdata_q_13_32\,
  I2 => \fifo_inst_Small.wdata_q_12_32\,
  I3 => \fifo_inst/Small.wdata\(207));
\fifo_inst/Small.wdata_q_15_s24\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_15_28\,
  I0 => \fifo_inst/Small.wdata\(63),
  I1 => \fifo_inst_Small.wdata_q_6_32\,
  I2 => \fifo_inst_Small.wdata_q_13_33\,
  I3 => \fifo_inst/Small.wdata\(79));
\fifo_inst/Small.wdata_q_15_s25\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_15_29\,
  I0 => \fifo_inst_Small.wdata_q_12_34\,
  I1 => \fifo_inst/Small.wdata\(159),
  I2 => \fifo_inst_Small.wdata_q_5_32\,
  I3 => \fifo_inst/Small.wdata\(95));
\fifo_inst/Small.wdata_q_15_s26\: LUT4
generic map (
  INIT => X"0100"
)
port map (
  F => \fifo_inst_Small.wdata_q_15_30\,
  I0 => \fifo_inst/rbin_num\(0),
  I1 => \fifo_inst/rbin_num\(1),
  I2 => \fifo_inst/rbin_num\(2),
  I3 => \fifo_inst/rbin_num\(3));
\fifo_inst/Small.wdata_q_15_s27\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Small.wdata_q_15_31\,
  I0 => \fifo_inst_Small.wdata_q_15_37\,
  I1 => \fifo_inst/Small.wdata\(31));
\fifo_inst/Small.wdata_q_15_s28\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_15_32\,
  I0 => \fifo_inst_Small.wdata_q_15_38\,
  I1 => \fifo_inst/Small.wdata\(255),
  I2 => fifo_inst_rbin_num_next_4,
  I3 => \fifo_inst/Small.wdata\(239));
\fifo_inst/Small.wdata_q_15_s29\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => \fifo_inst_Small.wdata_q_15_33\,
  I0 => \fifo_inst/rbin_num\(2),
  I1 => \fifo_inst/rbin_num\(1),
  I2 => \fifo_inst/rbin_num\(0),
  I3 => \fifo_inst/rbin_num\(3));
\fifo_inst/Small.wdata_q_15_s30\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => \fifo_inst_Small.wdata_q_15_34\,
  I0 => \fifo_inst/rbin_num\(0),
  I1 => \fifo_inst/rbin_num\(1),
  I2 => \fifo_inst/rbin_num\(2),
  I3 => \fifo_inst/rbin_num\(3));
\fifo_inst/Small.wdata_q_15_s31\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => \fifo_inst_Small.wdata_q_15_35\,
  I0 => \fifo_inst/rbin_num\(3),
  I1 => \fifo_inst/rbin_num\(1),
  I2 => \fifo_inst/rbin_num\(2),
  I3 => \fifo_inst/rbin_num\(0));
\fifo_inst/Small.wdata_q_15_s32\: LUT4
generic map (
  INIT => X"0100"
)
port map (
  F => \fifo_inst_Small.wdata_q_15_36\,
  I0 => \fifo_inst/rbin_num\(1),
  I1 => \fifo_inst/rbin_num\(2),
  I2 => \fifo_inst/rbin_num\(3),
  I3 => \fifo_inst/rbin_num\(0));
\fifo_inst/Small.wdata_q_14_s20\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_14_24\,
  I0 => \fifo_inst_Small.wdata_q_12_32\,
  I1 => \fifo_inst/Small.wdata\(206),
  I2 => \fifo_inst_Small.wdata_q_12_33\,
  I3 => \fifo_inst/Small.wdata\(142));
\fifo_inst/Small.wdata_q_14_s21\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_14_25\,
  I0 => \fifo_inst/Small.wdata\(222),
  I1 => \fifo_inst_Small.wdata_q_15_34\,
  I2 => fifo_inst_rbin_num_next_4,
  I3 => \fifo_inst/Small.wdata\(238));
\fifo_inst/Small.wdata_q_14_s22\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_14_26\,
  I0 => \fifo_inst_Small.wdata_q_15_30\,
  I1 => \fifo_inst/Small.wdata\(126),
  I2 => \fifo_inst_Small.wdata_q_6_32\,
  I3 => \fifo_inst/Small.wdata\(62));
\fifo_inst/Small.wdata_q_14_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_14_27\,
  I0 => \fifo_inst_Small.wdata_q_15_38\,
  I1 => \fifo_inst/Small.wdata\(254),
  I2 => \fifo_inst_Small.wdata_q_6_33\,
  I3 => \fifo_inst/Small.wdata\(190));
\fifo_inst/Small.wdata_q_14_s24\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_14_28\,
  I0 => \fifo_inst_Small.wdata_q_15_35\,
  I1 => \fifo_inst/Small.wdata\(110),
  I2 => \fifo_inst_Small.wdata_q_15_36\,
  I3 => \fifo_inst/Small.wdata\(14));
\fifo_inst/Small.wdata_q_14_s25\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_14_29\,
  I0 => \fifo_inst_Small.wdata_q_15_33\,
  I1 => \fifo_inst/Small.wdata\(174),
  I2 => \fifo_inst_Small.wdata_q_13_32\,
  I3 => \fifo_inst/Small.wdata\(46));
\fifo_inst/Small.wdata_q_14_s26\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_14_30\,
  I0 => \fifo_inst/Small.wdata\(30),
  I1 => \fifo_inst_Small.wdata_q_15_37\,
  I2 => \fifo_inst_Small.wdata_q_12_34\,
  I3 => \fifo_inst/Small.wdata\(158));
\fifo_inst/Small.wdata_q_14_s27\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_14_31\,
  I0 => \fifo_inst_Small.wdata_q_5_32\,
  I1 => \fifo_inst/Small.wdata\(94),
  I2 => \fifo_inst_Small.wdata_q_13_33\,
  I3 => \fifo_inst/Small.wdata\(78));
\fifo_inst/Small.wdata_q_13_s22\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Small.wdata_q_13_26\,
  I0 => \fifo_inst_Small.wdata_q_12_34\,
  I1 => \fifo_inst/Small.wdata\(157));
\fifo_inst/Small.wdata_q_13_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_13_27\,
  I0 => \fifo_inst/Small.wdata\(189),
  I1 => \fifo_inst_Small.wdata_q_6_33\,
  I2 => fifo_inst_rbin_num_next_4,
  I3 => \fifo_inst/Small.wdata\(237));
\fifo_inst/Small.wdata_q_13_s24\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_13_28\,
  I0 => \fifo_inst_Small.wdata_q_15_38\,
  I1 => \fifo_inst/Small.wdata\(253),
  I2 => \fifo_inst_Small.wdata_q_15_37\,
  I3 => \fifo_inst/Small.wdata\(29));
\fifo_inst/Small.wdata_q_13_s25\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_13_29\,
  I0 => \fifo_inst/Small.wdata\(93),
  I1 => \fifo_inst_Small.wdata_q_5_32\,
  I2 => \fifo_inst_Small.wdata_q_12_33\,
  I3 => \fifo_inst/Small.wdata\(141));
\fifo_inst/Small.wdata_q_13_s26\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_13_30\,
  I0 => \fifo_inst/Small.wdata\(125),
  I1 => \fifo_inst_Small.wdata_q_15_30\,
  I2 => \fifo_inst_Small.wdata_q_15_34\,
  I3 => \fifo_inst/Small.wdata\(221));
\fifo_inst/Small.wdata_q_13_s27\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_13_31\,
  I0 => \fifo_inst/Small.wdata\(61),
  I1 => \fifo_inst_Small.wdata_q_6_32\,
  I2 => \fifo_inst_Small.wdata_q_12_32\,
  I3 => \fifo_inst/Small.wdata\(205));
\fifo_inst/Small.wdata_q_13_s28\: LUT4
generic map (
  INIT => X"1000"
)
port map (
  F => \fifo_inst_Small.wdata_q_13_32\,
  I0 => \fifo_inst/rbin_num\(2),
  I1 => \fifo_inst/rbin_num\(3),
  I2 => \fifo_inst/rbin_num\(0),
  I3 => \fifo_inst/rbin_num\(1));
\fifo_inst/Small.wdata_q_13_s29\: LUT4
generic map (
  INIT => X"1000"
)
port map (
  F => \fifo_inst_Small.wdata_q_13_33\,
  I0 => \fifo_inst/rbin_num\(1),
  I1 => \fifo_inst/rbin_num\(3),
  I2 => \fifo_inst/rbin_num\(2),
  I3 => \fifo_inst/rbin_num\(0));
\fifo_inst/Small.wdata_q_12_s22\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Small.wdata_q_12_26\,
  I0 => \fifo_inst_Small.wdata_q_13_32\,
  I1 => \fifo_inst/Small.wdata\(44));
\fifo_inst/Small.wdata_q_12_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_12_27\,
  I0 => \fifo_inst/Small.wdata\(60),
  I1 => \fifo_inst_Small.wdata_q_6_32\,
  I2 => \fifo_inst_Small.wdata_q_6_33\,
  I3 => \fifo_inst/Small.wdata\(188));
\fifo_inst/Small.wdata_q_12_s24\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_12_28\,
  I0 => \fifo_inst/Small.wdata\(12),
  I1 => \fifo_inst_Small.wdata_q_15_36\,
  I2 => \fifo_inst_Small.wdata_q_15_34\,
  I3 => \fifo_inst/Small.wdata\(220));
\fifo_inst/Small.wdata_q_12_s25\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_12_29\,
  I0 => \fifo_inst/Small.wdata\(92),
  I1 => \fifo_inst_Small.wdata_q_5_32\,
  I2 => fifo_inst_rbin_num_next_4,
  I3 => \fifo_inst/Small.wdata\(236));
\fifo_inst/Small.wdata_q_12_s26\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_12_30\,
  I0 => \fifo_inst/Small.wdata\(28),
  I1 => \fifo_inst_Small.wdata_q_15_37\,
  I2 => \fifo_inst_Small.wdata_q_15_35\,
  I3 => \fifo_inst/Small.wdata\(108));
\fifo_inst/Small.wdata_q_12_s27\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_12_31\,
  I0 => \fifo_inst_Small.wdata_q_15_38\,
  I1 => \fifo_inst/Small.wdata\(252),
  I2 => \fifo_inst_Small.wdata_q_13_33\,
  I3 => \fifo_inst/Small.wdata\(76));
\fifo_inst/Small.wdata_q_12_s28\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => \fifo_inst_Small.wdata_q_12_32\,
  I0 => \fifo_inst/rbin_num\(1),
  I1 => \fifo_inst/rbin_num\(0),
  I2 => \fifo_inst/rbin_num\(2),
  I3 => \fifo_inst/rbin_num\(3));
\fifo_inst/Small.wdata_q_12_s29\: LUT4
generic map (
  INIT => X"1000"
)
port map (
  F => \fifo_inst_Small.wdata_q_12_33\,
  I0 => \fifo_inst/rbin_num\(1),
  I1 => \fifo_inst/rbin_num\(2),
  I2 => \fifo_inst/rbin_num\(0),
  I3 => \fifo_inst/rbin_num\(3));
\fifo_inst/Small.wdata_q_12_s30\: LUT4
generic map (
  INIT => X"1000"
)
port map (
  F => \fifo_inst_Small.wdata_q_12_34\,
  I0 => \fifo_inst/rbin_num\(0),
  I1 => \fifo_inst/rbin_num\(2),
  I2 => \fifo_inst/rbin_num\(1),
  I3 => \fifo_inst/rbin_num\(3));
\fifo_inst/Small.wdata_q_11_s20\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_11_24\,
  I0 => \fifo_inst_Small.wdata_q_15_38\,
  I1 => \fifo_inst/Small.wdata\(251),
  I2 => \fifo_inst_Small.wdata_q_15_36\,
  I3 => \fifo_inst/Small.wdata\(11));
\fifo_inst/Small.wdata_q_11_s21\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_11_25\,
  I0 => \fifo_inst_Small.wdata_q_12_34\,
  I1 => \fifo_inst/Small.wdata\(155),
  I2 => \fifo_inst_Small.wdata_q_12_33\,
  I3 => \fifo_inst/Small.wdata\(139));
\fifo_inst/Small.wdata_q_11_s22\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_11_26\,
  I0 => \fifo_inst_Small.wdata_q_15_35\,
  I1 => \fifo_inst/Small.wdata\(107),
  I2 => \fifo_inst_Small.wdata_q_5_32\,
  I3 => \fifo_inst/Small.wdata\(91));
\fifo_inst/Small.wdata_q_11_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_11_27\,
  I0 => \fifo_inst/Small.wdata\(27),
  I1 => \fifo_inst_Small.wdata_q_15_37\,
  I2 => \fifo_inst_Small.wdata_q_12_32\,
  I3 => \fifo_inst/Small.wdata\(203));
\fifo_inst/Small.wdata_q_11_s24\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_11_28\,
  I0 => \fifo_inst/Small.wdata\(59),
  I1 => \fifo_inst_Small.wdata_q_6_32\,
  I2 => fifo_inst_rbin_num_next_4,
  I3 => \fifo_inst/Small.wdata\(235));
\fifo_inst/Small.wdata_q_11_s25\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_11_29\,
  I0 => \fifo_inst/Small.wdata\(75),
  I1 => \fifo_inst_Small.wdata_q_13_33\,
  I2 => \fifo_inst_Small.wdata_q_6_33\,
  I3 => \fifo_inst/Small.wdata\(187));
\fifo_inst/Small.wdata_q_11_s26\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_11_30\,
  I0 => \fifo_inst/Small.wdata\(123),
  I1 => \fifo_inst_Small.wdata_q_15_30\,
  I2 => \fifo_inst_Small.wdata_q_15_33\,
  I3 => \fifo_inst/Small.wdata\(171));
\fifo_inst/Small.wdata_q_11_s27\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_11_31\,
  I0 => \fifo_inst_Small.wdata_q_15_34\,
  I1 => \fifo_inst/Small.wdata\(219),
  I2 => \fifo_inst_Small.wdata_q_13_32\,
  I3 => \fifo_inst/Small.wdata\(43));
\fifo_inst/Small.wdata_q_10_s20\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_10_24\,
  I0 => \fifo_inst/Small.wdata\(74),
  I1 => \fifo_inst_Small.wdata_q_13_33\,
  I2 => \fifo_inst_Small.wdata_q_12_32\,
  I3 => \fifo_inst/Small.wdata\(202));
\fifo_inst/Small.wdata_q_10_s21\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_10_25\,
  I0 => \fifo_inst_Small.wdata_q_6_33\,
  I1 => \fifo_inst/Small.wdata\(186),
  I2 => \fifo_inst_Small.wdata_q_12_33\,
  I3 => \fifo_inst/Small.wdata\(138));
\fifo_inst/Small.wdata_q_10_s22\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_10_26\,
  I0 => \fifo_inst_Small.wdata_q_15_35\,
  I1 => \fifo_inst/Small.wdata\(106),
  I2 => \fifo_inst_Small.wdata_q_6_32\,
  I3 => \fifo_inst/Small.wdata\(58));
\fifo_inst/Small.wdata_q_10_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_10_27\,
  I0 => \fifo_inst_Small.wdata_q_15_38\,
  I1 => \fifo_inst/Small.wdata\(250),
  I2 => \fifo_inst_Small.wdata_q_15_34\,
  I3 => \fifo_inst/Small.wdata\(218));
\fifo_inst/Small.wdata_q_10_s24\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_10_28\,
  I0 => \fifo_inst/Small.wdata\(10),
  I1 => \fifo_inst_Small.wdata_q_15_36\,
  I2 => \fifo_inst_Small.wdata_q_5_32\,
  I3 => \fifo_inst/Small.wdata\(90));
\fifo_inst/Small.wdata_q_10_s25\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_10_29\,
  I0 => \fifo_inst_Small.wdata_q_15_30\,
  I1 => \fifo_inst/Small.wdata\(122),
  I2 => \fifo_inst_Small.wdata_q_13_32\,
  I3 => \fifo_inst/Small.wdata\(42));
\fifo_inst/Small.wdata_q_10_s26\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_10_30\,
  I0 => \fifo_inst/Small.wdata\(26),
  I1 => \fifo_inst_Small.wdata_q_15_37\,
  I2 => fifo_inst_rbin_num_next_4,
  I3 => \fifo_inst/Small.wdata\(234));
\fifo_inst/Small.wdata_q_10_s27\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_10_31\,
  I0 => \fifo_inst_Small.wdata_q_15_33\,
  I1 => \fifo_inst/Small.wdata\(170),
  I2 => \fifo_inst_Small.wdata_q_12_34\,
  I3 => \fifo_inst/Small.wdata\(154));
\fifo_inst/Small.wdata_q_9_s20\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_9_24\,
  I0 => \fifo_inst_Small.wdata_q_15_38\,
  I1 => \fifo_inst/Small.wdata\(249),
  I2 => \fifo_inst_Small.wdata_q_13_33\,
  I3 => \fifo_inst/Small.wdata\(73));
\fifo_inst/Small.wdata_q_9_s21\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_9_25\,
  I0 => \fifo_inst/Small.wdata\(169),
  I1 => \fifo_inst_Small.wdata_q_15_33\,
  I2 => \fifo_inst_Small.wdata_q_15_34\,
  I3 => \fifo_inst/Small.wdata\(217));
\fifo_inst/Small.wdata_q_9_s22\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_9_26\,
  I0 => \fifo_inst/Small.wdata\(25),
  I1 => \fifo_inst_Small.wdata_q_15_37\,
  I2 => \fifo_inst_Small.wdata_q_12_32\,
  I3 => \fifo_inst/Small.wdata\(201));
\fifo_inst/Small.wdata_q_9_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_9_27\,
  I0 => \fifo_inst/Small.wdata\(9),
  I1 => \fifo_inst_Small.wdata_q_15_36\,
  I2 => \fifo_inst_Small.wdata_q_6_32\,
  I3 => \fifo_inst/Small.wdata\(57));
\fifo_inst/Small.wdata_q_9_s24\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_9_28\,
  I0 => \fifo_inst/Small.wdata\(89),
  I1 => \fifo_inst_Small.wdata_q_5_32\,
  I2 => \fifo_inst_Small.wdata_q_6_33\,
  I3 => \fifo_inst/Small.wdata\(185));
\fifo_inst/Small.wdata_q_9_s25\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_9_29\,
  I0 => \fifo_inst/Small.wdata\(105),
  I1 => \fifo_inst_Small.wdata_q_15_35\,
  I2 => \fifo_inst_Small.wdata_q_12_33\,
  I3 => \fifo_inst/Small.wdata\(137));
\fifo_inst/Small.wdata_q_9_s26\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_9_30\,
  I0 => \fifo_inst/Small.wdata\(121),
  I1 => \fifo_inst_Small.wdata_q_15_30\,
  I2 => fifo_inst_rbin_num_next_4,
  I3 => \fifo_inst/Small.wdata\(233));
\fifo_inst/Small.wdata_q_9_s27\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_9_31\,
  I0 => \fifo_inst_Small.wdata_q_12_34\,
  I1 => \fifo_inst/Small.wdata\(153),
  I2 => \fifo_inst_Small.wdata_q_13_32\,
  I3 => \fifo_inst/Small.wdata\(41));
\fifo_inst/Small.wdata_q_8_s20\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_8_24\,
  I0 => \fifo_inst_Small.wdata_q_15_34\,
  I1 => \fifo_inst/Small.wdata\(216),
  I2 => \fifo_inst_Small.wdata_q_12_32\,
  I3 => \fifo_inst/Small.wdata\(200));
\fifo_inst/Small.wdata_q_8_s21\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_8_25\,
  I0 => \fifo_inst_Small.wdata_q_15_38\,
  I1 => \fifo_inst/Small.wdata\(248),
  I2 => \fifo_inst_Small.wdata_q_12_33\,
  I3 => \fifo_inst/Small.wdata\(136));
\fifo_inst/Small.wdata_q_8_s22\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_8_26\,
  I0 => \fifo_inst/Small.wdata\(168),
  I1 => \fifo_inst_Small.wdata_q_15_33\,
  I2 => fifo_inst_rbin_num_next_4,
  I3 => \fifo_inst/Small.wdata\(232));
\fifo_inst/Small.wdata_q_8_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_8_27\,
  I0 => \fifo_inst/Small.wdata\(104),
  I1 => \fifo_inst_Small.wdata_q_15_35\,
  I2 => \fifo_inst_Small.wdata_q_12_34\,
  I3 => \fifo_inst/Small.wdata\(152));
\fifo_inst/Small.wdata_q_8_s24\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_8_28\,
  I0 => \fifo_inst/Small.wdata\(8),
  I1 => \fifo_inst_Small.wdata_q_15_36\,
  I2 => \fifo_inst_Small.wdata_q_5_32\,
  I3 => \fifo_inst/Small.wdata\(88));
\fifo_inst/Small.wdata_q_8_s25\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_8_29\,
  I0 => \fifo_inst/Small.wdata\(24),
  I1 => \fifo_inst_Small.wdata_q_15_37\,
  I2 => \fifo_inst_Small.wdata_q_13_32\,
  I3 => \fifo_inst/Small.wdata\(40));
\fifo_inst/Small.wdata_q_8_s26\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_8_30\,
  I0 => \fifo_inst/Small.wdata\(56),
  I1 => \fifo_inst_Small.wdata_q_6_32\,
  I2 => \fifo_inst_Small.wdata_q_13_33\,
  I3 => \fifo_inst/Small.wdata\(72));
\fifo_inst/Small.wdata_q_8_s27\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_8_31\,
  I0 => \fifo_inst/Small.wdata\(120),
  I1 => \fifo_inst_Small.wdata_q_15_30\,
  I2 => \fifo_inst_Small.wdata_q_6_33\,
  I3 => \fifo_inst/Small.wdata\(184));
\fifo_inst/Small.wdata_q_7_s20\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_7_24\,
  I0 => \fifo_inst_Small.wdata_q_15_34\,
  I1 => \fifo_inst/Small.wdata\(215),
  I2 => \fifo_inst_Small.wdata_q_12_32\,
  I3 => \fifo_inst/Small.wdata\(199));
\fifo_inst/Small.wdata_q_7_s21\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_7_25\,
  I0 => \fifo_inst/Small.wdata\(7),
  I1 => \fifo_inst_Small.wdata_q_15_36\,
  I2 => \fifo_inst_Small.wdata_q_5_32\,
  I3 => \fifo_inst/Small.wdata\(87));
\fifo_inst/Small.wdata_q_7_s22\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_7_26\,
  I0 => \fifo_inst/Small.wdata\(23),
  I1 => \fifo_inst_Small.wdata_q_15_37\,
  I2 => \fifo_inst_Small.wdata_q_6_33\,
  I3 => \fifo_inst/Small.wdata\(183));
\fifo_inst/Small.wdata_q_7_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_7_27\,
  I0 => \fifo_inst_Small.wdata_q_15_38\,
  I1 => \fifo_inst/Small.wdata\(247),
  I2 => \fifo_inst_Small.wdata_q_12_33\,
  I3 => \fifo_inst/Small.wdata\(135));
\fifo_inst/Small.wdata_q_7_s24\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_7_28\,
  I0 => \fifo_inst_Small.wdata_q_12_34\,
  I1 => \fifo_inst/Small.wdata\(151),
  I2 => \fifo_inst_Small.wdata_q_6_32\,
  I3 => \fifo_inst/Small.wdata\(55));
\fifo_inst/Small.wdata_q_7_s25\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_7_29\,
  I0 => \fifo_inst_Small.wdata_q_15_30\,
  I1 => \fifo_inst/Small.wdata\(119),
  I2 => \fifo_inst_Small.wdata_q_13_33\,
  I3 => \fifo_inst/Small.wdata\(71));
\fifo_inst/Small.wdata_q_7_s26\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_7_30\,
  I0 => \fifo_inst_Small.wdata_q_15_35\,
  I1 => \fifo_inst/Small.wdata\(103),
  I2 => \fifo_inst_Small.wdata_q_13_32\,
  I3 => \fifo_inst/Small.wdata\(39));
\fifo_inst/Small.wdata_q_7_s27\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_7_31\,
  I0 => \fifo_inst/Small.wdata\(167),
  I1 => \fifo_inst_Small.wdata_q_15_33\,
  I2 => fifo_inst_rbin_num_next_4,
  I3 => \fifo_inst/Small.wdata\(231));
\fifo_inst/Small.wdata_q_6_s22\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Small.wdata_q_6_26\,
  I0 => \fifo_inst_Small.wdata_q_15_35\,
  I1 => \fifo_inst/Small.wdata\(102));
\fifo_inst/Small.wdata_q_6_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_6_27\,
  I0 => \fifo_inst_Small.wdata_q_15_38\,
  I1 => \fifo_inst/Small.wdata\(246),
  I2 => fifo_inst_rbin_num_next_4,
  I3 => \fifo_inst/Small.wdata\(230));
\fifo_inst/Small.wdata_q_6_s24\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_6_28\,
  I0 => \fifo_inst/Small.wdata\(118),
  I1 => \fifo_inst_Small.wdata_q_15_30\,
  I2 => \fifo_inst_Small.wdata_q_12_32\,
  I3 => \fifo_inst/Small.wdata\(198));
\fifo_inst/Small.wdata_q_6_s25\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_6_29\,
  I0 => \fifo_inst_Small.wdata_q_5_32\,
  I1 => \fifo_inst/Small.wdata\(86),
  I2 => \fifo_inst_Small.wdata_q_13_33\,
  I3 => \fifo_inst/Small.wdata\(70));
\fifo_inst/Small.wdata_q_6_s26\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_6_30\,
  I0 => \fifo_inst/Small.wdata\(22),
  I1 => \fifo_inst_Small.wdata_q_15_37\,
  I2 => \fifo_inst_Small.wdata_q_15_33\,
  I3 => \fifo_inst/Small.wdata\(166));
\fifo_inst/Small.wdata_q_6_s27\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_6_31\,
  I0 => \fifo_inst/Small.wdata\(6),
  I1 => \fifo_inst_Small.wdata_q_15_36\,
  I2 => \fifo_inst_Small.wdata_q_13_32\,
  I3 => \fifo_inst/Small.wdata\(38));
\fifo_inst/Small.wdata_q_6_s28\: LUT4
generic map (
  INIT => X"0100"
)
port map (
  F => \fifo_inst_Small.wdata_q_6_32\,
  I0 => \fifo_inst/rbin_num\(0),
  I1 => \fifo_inst/rbin_num\(1),
  I2 => \fifo_inst/rbin_num\(3),
  I3 => \fifo_inst/rbin_num\(2));
\fifo_inst/Small.wdata_q_6_s29\: LUT4
generic map (
  INIT => X"1000"
)
port map (
  F => \fifo_inst_Small.wdata_q_6_33\,
  I0 => \fifo_inst/rbin_num\(0),
  I1 => \fifo_inst/rbin_num\(1),
  I2 => \fifo_inst/rbin_num\(2),
  I3 => \fifo_inst/rbin_num\(3));
\fifo_inst/Small.wdata_q_5_s22\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_5_26\,
  I0 => \fifo_inst/Small.wdata\(165),
  I1 => \fifo_inst_Small.wdata_q_15_33\,
  I2 => fifo_inst_rbin_num_next_4,
  I3 => \fifo_inst/Small.wdata\(229));
\fifo_inst/Small.wdata_q_5_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_5_27\,
  I0 => \fifo_inst_Small.wdata_q_15_38\,
  I1 => \fifo_inst/Small.wdata\(245),
  I2 => \fifo_inst_Small.wdata_q_15_30\,
  I3 => \fifo_inst/Small.wdata\(117));
\fifo_inst/Small.wdata_q_5_s24\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_5_28\,
  I0 => \fifo_inst/Small.wdata\(21),
  I1 => \fifo_inst_Small.wdata_q_15_37\,
  I2 => \fifo_inst_Small.wdata_q_13_32\,
  I3 => \fifo_inst/Small.wdata\(37));
\fifo_inst/Small.wdata_q_5_s25\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_5_29\,
  I0 => \fifo_inst_Small.wdata_q_15_34\,
  I1 => \fifo_inst/Small.wdata\(213),
  I2 => \fifo_inst_Small.wdata_q_6_32\,
  I3 => \fifo_inst/Small.wdata\(53));
\fifo_inst/Small.wdata_q_5_s26\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Small.wdata_q_5_30\,
  I0 => \fifo_inst_Small.wdata_q_12_32\,
  I1 => \fifo_inst/Small.wdata\(197));
\fifo_inst/Small.wdata_q_5_s27\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_5_31\,
  I0 => \fifo_inst_Small.wdata_q_6_33\,
  I1 => \fifo_inst/Small.wdata\(181),
  I2 => \fifo_inst_Small.wdata_q_12_33\,
  I3 => \fifo_inst/Small.wdata\(133));
\fifo_inst/Small.wdata_q_5_s28\: LUT4
generic map (
  INIT => X"1000"
)
port map (
  F => \fifo_inst_Small.wdata_q_5_32\,
  I0 => \fifo_inst/rbin_num\(0),
  I1 => \fifo_inst/rbin_num\(3),
  I2 => \fifo_inst/rbin_num\(2),
  I3 => \fifo_inst/rbin_num\(1));
\fifo_inst/Small.wdata_q_4_s22\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_4_26\,
  I0 => \fifo_inst/Small.wdata\(20),
  I1 => \fifo_inst_Small.wdata_q_15_37\,
  I2 => \fifo_inst_Small.wdata_q_15_34\,
  I3 => \fifo_inst/Small.wdata\(212));
\fifo_inst/Small.wdata_q_4_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_4_27\,
  I0 => \fifo_inst/Small.wdata\(52),
  I1 => \fifo_inst_Small.wdata_q_6_32\,
  I2 => \fifo_inst_Small.wdata_q_12_32\,
  I3 => \fifo_inst/Small.wdata\(196));
\fifo_inst/Small.wdata_q_4_s24\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_4_28\,
  I0 => \fifo_inst_Small.wdata_q_15_35\,
  I1 => \fifo_inst/Small.wdata\(100),
  I2 => \fifo_inst_Small.wdata_q_5_32\,
  I3 => \fifo_inst/Small.wdata\(84));
\fifo_inst/Small.wdata_q_4_s25\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_4_29\,
  I0 => \fifo_inst/Small.wdata\(68),
  I1 => \fifo_inst_Small.wdata_q_13_33\,
  I2 => \fifo_inst_Small.wdata_q_6_33\,
  I3 => \fifo_inst/Small.wdata\(180));
\fifo_inst/Small.wdata_q_4_s26\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Small.wdata_q_4_30\,
  I0 => \fifo_inst_Small.wdata_q_13_32\,
  I1 => \fifo_inst/Small.wdata\(36));
\fifo_inst/Small.wdata_q_4_s27\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_4_31\,
  I0 => \fifo_inst_Small.wdata_q_15_38\,
  I1 => \fifo_inst/Small.wdata\(244),
  I2 => \fifo_inst_Small.wdata_q_15_33\,
  I3 => \fifo_inst/Small.wdata\(164));
\fifo_inst/Small.wdata_q_3_s20\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_3_24\,
  I0 => \fifo_inst/Small.wdata\(147),
  I1 => \fifo_inst_Small.wdata_q_12_34\,
  I2 => \fifo_inst_Small.wdata_q_12_32\,
  I3 => \fifo_inst/Small.wdata\(195));
\fifo_inst/Small.wdata_q_3_s21\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_3_25\,
  I0 => \fifo_inst/Small.wdata\(179),
  I1 => \fifo_inst_Small.wdata_q_6_33\,
  I2 => fifo_inst_rbin_num_next_4,
  I3 => \fifo_inst/Small.wdata\(227));
\fifo_inst/Small.wdata_q_3_s22\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_3_26\,
  I0 => \fifo_inst_Small.wdata_q_15_38\,
  I1 => \fifo_inst/Small.wdata\(243),
  I2 => \fifo_inst_Small.wdata_q_15_30\,
  I3 => \fifo_inst/Small.wdata\(115));
\fifo_inst/Small.wdata_q_3_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_3_27\,
  I0 => \fifo_inst_Small.wdata_q_5_32\,
  I1 => \fifo_inst/Small.wdata\(83),
  I2 => \fifo_inst_Small.wdata_q_13_32\,
  I3 => \fifo_inst/Small.wdata\(35));
\fifo_inst/Small.wdata_q_3_s24\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_3_28\,
  I0 => \fifo_inst_Small.wdata_q_15_35\,
  I1 => \fifo_inst/Small.wdata\(99),
  I2 => \fifo_inst_Small.wdata_q_13_33\,
  I3 => \fifo_inst/Small.wdata\(67));
\fifo_inst/Small.wdata_q_3_s25\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_3_29\,
  I0 => \fifo_inst_Small.wdata_q_15_33\,
  I1 => \fifo_inst/Small.wdata\(163),
  I2 => \fifo_inst_Small.wdata_q_12_33\,
  I3 => \fifo_inst/Small.wdata\(131));
\fifo_inst/Small.wdata_q_3_s26\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_3_30\,
  I0 => \fifo_inst_Small.wdata_q_15_34\,
  I1 => \fifo_inst/Small.wdata\(211),
  I2 => \fifo_inst_Small.wdata_q_6_32\,
  I3 => \fifo_inst/Small.wdata\(51));
\fifo_inst/Small.wdata_q_3_s27\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_3_31\,
  I0 => \fifo_inst_Small.wdata_q_15_37\,
  I1 => \fifo_inst/Small.wdata\(19),
  I2 => \fifo_inst_Small.wdata_q_15_36\,
  I3 => \fifo_inst/Small.wdata\(3));
\fifo_inst/Small.wdata_q_2_s20\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_2_24\,
  I0 => \fifo_inst_Small.wdata_q_5_32\,
  I1 => \fifo_inst/Small.wdata\(82),
  I2 => \fifo_inst_Small.wdata_q_13_33\,
  I3 => \fifo_inst/Small.wdata\(66));
\fifo_inst/Small.wdata_q_2_s21\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_2_25\,
  I0 => \fifo_inst_Small.wdata_q_12_32\,
  I1 => \fifo_inst/Small.wdata\(194),
  I2 => \fifo_inst_Small.wdata_q_6_33\,
  I3 => \fifo_inst/Small.wdata\(178));
\fifo_inst/Small.wdata_q_2_s22\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_2_26\,
  I0 => \fifo_inst/Small.wdata\(2),
  I1 => \fifo_inst_Small.wdata_q_15_36\,
  I2 => \fifo_inst_Small.wdata_q_12_33\,
  I3 => \fifo_inst/Small.wdata\(130));
\fifo_inst/Small.wdata_q_2_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_2_27\,
  I0 => \fifo_inst/Small.wdata\(34),
  I1 => \fifo_inst_Small.wdata_q_13_32\,
  I2 => fifo_inst_rbin_num_next_4,
  I3 => \fifo_inst/Small.wdata\(226));
\fifo_inst/Small.wdata_q_2_s24\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_2_28\,
  I0 => \fifo_inst_Small.wdata_q_15_30\,
  I1 => \fifo_inst/Small.wdata\(114),
  I2 => \fifo_inst_Small.wdata_q_6_32\,
  I3 => \fifo_inst/Small.wdata\(50));
\fifo_inst/Small.wdata_q_2_s25\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_2_29\,
  I0 => \fifo_inst/Small.wdata\(18),
  I1 => \fifo_inst_Small.wdata_q_15_37\,
  I2 => \fifo_inst_Small.wdata_q_15_34\,
  I3 => \fifo_inst/Small.wdata\(210));
\fifo_inst/Small.wdata_q_2_s26\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_2_30\,
  I0 => \fifo_inst_Small.wdata_q_15_38\,
  I1 => \fifo_inst/Small.wdata\(242),
  I2 => \fifo_inst_Small.wdata_q_12_34\,
  I3 => \fifo_inst/Small.wdata\(146));
\fifo_inst/Small.wdata_q_2_s27\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_2_31\,
  I0 => \fifo_inst/Small.wdata\(98),
  I1 => \fifo_inst_Small.wdata_q_15_35\,
  I2 => \fifo_inst_Small.wdata_q_15_33\,
  I3 => \fifo_inst/Small.wdata\(162));
\fifo_inst/Small.wdata_q_1_s22\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Small.wdata_q_1_26\,
  I0 => \fifo_inst_Small.wdata_q_12_33\,
  I1 => \fifo_inst/Small.wdata\(129));
\fifo_inst/Small.wdata_q_1_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_1_27\,
  I0 => \fifo_inst/Small.wdata\(193),
  I1 => \fifo_inst_Small.wdata_q_12_32\,
  I2 => fifo_inst_rbin_num_next_4,
  I3 => \fifo_inst/Small.wdata\(225));
\fifo_inst/Small.wdata_q_1_s24\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_1_28\,
  I0 => \fifo_inst_Small.wdata_q_15_38\,
  I1 => \fifo_inst/Small.wdata\(241),
  I2 => \fifo_inst_Small.wdata_q_15_37\,
  I3 => \fifo_inst/Small.wdata\(17));
\fifo_inst/Small.wdata_q_1_s25\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_1_29\,
  I0 => \fifo_inst_Small.wdata_q_15_34\,
  I1 => \fifo_inst/Small.wdata\(209),
  I2 => \fifo_inst_Small.wdata_q_12_34\,
  I3 => \fifo_inst/Small.wdata\(145));
\fifo_inst/Small.wdata_q_1_s26\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_1_30\,
  I0 => \fifo_inst_Small.wdata_q_5_32\,
  I1 => \fifo_inst/Small.wdata\(81),
  I2 => \fifo_inst_Small.wdata_q_13_33\,
  I3 => \fifo_inst/Small.wdata\(65));
\fifo_inst/Small.wdata_q_1_s27\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_1_31\,
  I0 => \fifo_inst/Small.wdata\(97),
  I1 => \fifo_inst_Small.wdata_q_15_35\,
  I2 => \fifo_inst_Small.wdata_q_15_33\,
  I3 => \fifo_inst/Small.wdata\(161));
\fifo_inst/Small.wdata_q_0_s20\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_0_24\,
  I0 => \fifo_inst/Small.wdata\(160),
  I1 => \fifo_inst_Small.wdata_q_15_33\,
  I2 => fifo_inst_rbin_num_next_4,
  I3 => \fifo_inst/Small.wdata\(224));
\fifo_inst/Small.wdata_q_0_s21\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_0_25\,
  I0 => \fifo_inst/Small.wdata\(16),
  I1 => \fifo_inst_Small.wdata_q_15_37\,
  I2 => \fifo_inst_Small.wdata_q_5_32\,
  I3 => \fifo_inst/Small.wdata\(80));
\fifo_inst/Small.wdata_q_0_s22\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_0_26\,
  I0 => \fifo_inst_Small.wdata_q_15_34\,
  I1 => \fifo_inst/Small.wdata\(208),
  I2 => \fifo_inst_Small.wdata_q_12_34\,
  I3 => \fifo_inst/Small.wdata\(144));
\fifo_inst/Small.wdata_q_0_s23\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_0_27\,
  I0 => \fifo_inst_Small.wdata_q_15_35\,
  I1 => \fifo_inst/Small.wdata\(96),
  I2 => \fifo_inst_Small.wdata_q_13_32\,
  I3 => \fifo_inst/Small.wdata\(32));
\fifo_inst/Small.wdata_q_0_s24\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_0_28\,
  I0 => \fifo_inst/Small.wdata\(0),
  I1 => \fifo_inst_Small.wdata_q_15_36\,
  I2 => \fifo_inst_Small.wdata_q_12_33\,
  I3 => \fifo_inst/Small.wdata\(128));
\fifo_inst/Small.wdata_q_0_s25\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_0_29\,
  I0 => \fifo_inst/Small.wdata\(48),
  I1 => \fifo_inst_Small.wdata_q_6_32\,
  I2 => \fifo_inst_Small.wdata_q_13_33\,
  I3 => \fifo_inst/Small.wdata\(64));
\fifo_inst/Small.wdata_q_0_s26\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_0_30\,
  I0 => \fifo_inst_Small.wdata_q_12_32\,
  I1 => \fifo_inst/Small.wdata\(192),
  I2 => \fifo_inst_Small.wdata_q_6_33\,
  I3 => \fifo_inst/Small.wdata\(176));
\fifo_inst/Small.wdata_q_0_s27\: LUT4
generic map (
  INIT => X"0777"
)
port map (
  F => \fifo_inst_Small.wdata_q_0_31\,
  I0 => \fifo_inst_Small.wdata_q_15_38\,
  I1 => \fifo_inst/Small.wdata\(240),
  I2 => \fifo_inst_Small.wdata_q_15_30\,
  I3 => \fifo_inst/Small.wdata\(112));
\fifo_inst/Small.wbinnext_8_s5\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wbinnext_8_9\,
  I0 => \fifo_inst/Small.wbin\(5),
  I1 => \fifo_inst/Small.wbin\(6),
  I2 => \fifo_inst/Small.wbin\(7),
  I3 => \fifo_inst/Small.wbin\(8));
\fifo_inst/wfull_val_s12\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => fifo_inst_wfull_val_15,
  I0 => \fifo_inst/Small.wq2_rptr\(1),
  I1 => \fifo_inst/Small.wbin\(2));
\fifo_inst/wfull_val_s13\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => fifo_inst_wfull_val_16,
  I0 => \fifo_inst/Small.wq2_rptr\(5),
  I1 => \fifo_inst/Small.wbin\(6));
\fifo_inst/Small.wdata_q_15_s33\: LUT4
generic map (
  INIT => X"0100"
)
port map (
  F => \fifo_inst_Small.wdata_q_15_37\,
  I0 => \fifo_inst/rbin_num\(0),
  I1 => \fifo_inst/rbin_num\(2),
  I2 => \fifo_inst/rbin_num\(3),
  I3 => \fifo_inst/rbin_num\(1));
\fifo_inst/Small.wdata_q_15_s34\: LUT4
generic map (
  INIT => X"0001"
)
port map (
  F => \fifo_inst_Small.wdata_q_15_38\,
  I0 => \fifo_inst/rbin_num\(0),
  I1 => \fifo_inst/rbin_num\(1),
  I2 => \fifo_inst/rbin_num\(2),
  I3 => \fifo_inst/rbin_num\(3));
\fifo_inst/Almost_Full_s7\: LUT4
generic map (
  INIT => X"FF02"
)
port map (
  F => fifo_inst_Almost_Full_10,
  I0 => fifo_inst_Almost_Full,
  I1 => \fifo_inst/wcnt_sub\(4),
  I2 => \fifo_inst/wcnt_sub\(5),
  I3 => fifo_inst_n1247);
\fifo_inst/Small.rcount_w_0_s1\: LUT4
generic map (
  INIT => X"9669"
)
port map (
  F => \fifo_inst/Small.rcount_w\(0),
  I0 => \fifo_inst/Small.rcount_w\(6),
  I1 => \fifo_inst_Small.rcount_w_2\,
  I2 => \fifo_inst/Small.wq2_rptr\(1),
  I3 => \fifo_inst/Small.wq2_rptr\(0));
\fifo_inst/Small.rgraynext_1_s1\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Small.rgraynext\(1),
  I0 => \fifo_inst_Small.rgraynext_2\,
  I1 => \fifo_inst/rbin_num\(6),
  I2 => \fifo_inst/rbin_num_next\(5));
\fifo_inst/Small.rcount_w_6_s1\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => \fifo_inst/Small.rcount_w\(6),
  I0 => \fifo_inst/Small.wq2_rptr\(9),
  I1 => \fifo_inst/Small.wq2_rptr\(8),
  I2 => \fifo_inst/Small.wq2_rptr\(6),
  I3 => \fifo_inst/Small.wq2_rptr\(7));
\fifo_inst/Small.rcount_w_7_s1\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Small.rcount_w\(7),
  I0 => \fifo_inst/Small.wq2_rptr\(9),
  I1 => \fifo_inst/Small.wq2_rptr\(8),
  I2 => \fifo_inst/Small.wq2_rptr\(7));
\fifo_inst/Small.wbinnext_9_s3\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/Small.wbinnext\(9),
  I0 => \fifo_inst_Small.wgraynext_2\,
  I1 => \fifo_inst_Small.wgraynext_6_5\,
  I2 => \fifo_inst_Small.wbinnext_8_9\,
  I3 => \fifo_inst/Small.wptr\(9));
\fifo_inst/Small.wbinnext_8_s6\: LUT4
generic map (
  INIT => X"1555"
)
port map (
  F => \fifo_inst/Small.wbinnext\(8),
  I0 => \fifo_inst_Small.wgraynext_8\,
  I1 => \fifo_inst_Small.wgraynext_2\,
  I2 => \fifo_inst_Small.wgraynext_6_5\,
  I3 => \fifo_inst_Small.wbinnext_8_9\);
\fifo_inst/Small.wcount_r_1_10_s1\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => \fifo_inst/Small.wcount_r_1\(10),
  I0 => \fifo_inst/Small.rq2_wptr\(9),
  I1 => \fifo_inst/Small.rq2_wptr\(8),
  I2 => \fifo_inst/Small.rq2_wptr\(7),
  I3 => \fifo_inst/Small.rq2_wptr\(6));
\fifo_inst/Small.wcount_r_1_11_s1\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Small.wcount_r_1\(11),
  I0 => \fifo_inst/Small.rq2_wptr\(9),
  I1 => \fifo_inst/Small.rq2_wptr\(8),
  I2 => \fifo_inst/Small.rq2_wptr\(7));
\fifo_inst/Small.wbinnext_4_s4\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/Small.wbinnext\(4),
  I0 => \fifo_inst_Small.wgraynext_2\,
  I1 => \fifo_inst/Small.wbin\(2),
  I2 => \fifo_inst/Small.wbin\(3),
  I3 => \fifo_inst/Small.wbin\(4));
\fifo_inst/rbin_num_next_11_s4\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/rbin_num_next\(11),
  I0 => \fifo_inst_Small.rgraynext_2\,
  I1 => \fifo_inst_Small.rgraynext_6\,
  I2 => \fifo_inst/rbin_num\(10),
  I3 => \fifo_inst/rbin_num\(11));
\fifo_inst/Small.wbinnext_5_s5\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Small.wbinnext_5\,
  I0 => \fifo_inst_Small.wgraynext_2\,
  I1 => \fifo_inst/Small.wbin\(2),
  I2 => \fifo_inst/Small.wbin\(3),
  I3 => \fifo_inst/Small.wbin\(4));
\fifo_inst/Small.wbinnext_0_s4\: LUT3
generic map (
  INIT => X"B4"
)
port map (
  F => \fifo_inst_Small.wbinnext_0\,
  I0 => NN_0,
  I1 => WrEn,
  I2 => \fifo_inst/Small.wbin\(0));
\fifo_inst/rbin_num_next_2_s5\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => fifo_inst_rbin_num_next_2,
  I0 => NN,
  I1 => RdEn,
  I2 => \fifo_inst/rbin_num\(0),
  I3 => \fifo_inst/rbin_num\(1));
\fifo_inst/rbin_num_next_4_s5\: LUT4
generic map (
  INIT => X"BF40"
)
port map (
  F => \fifo_inst/rbin_num_next\(4),
  I0 => NN,
  I1 => RdEn,
  I2 => fifo_inst_rbin_num_next_4,
  I3 => \fifo_inst/rbin_num\(4));
\fifo_inst/rbin_num_next_1_s4\: LUT4
generic map (
  INIT => X"BF40"
)
port map (
  F => \fifo_inst/rbin_num_next\(1),
  I0 => NN,
  I1 => RdEn,
  I2 => \fifo_inst/rbin_num\(0),
  I3 => \fifo_inst/rbin_num\(1));
\fifo_inst/rbin_num_next_0_s4\: LUT3
generic map (
  INIT => X"B4"
)
port map (
  F => fifo_inst_rbin_num_next_0,
  I0 => NN,
  I1 => RdEn,
  I2 => \fifo_inst/rbin_num\(0));
\fifo_inst/rempty_val_s1\: LUT3
generic map (
  INIT => X"41"
)
port map (
  F => fifo_inst_rempty_val,
  I0 => fifo_inst_n1022_3,
  I1 => \fifo_inst/Small.rq2_wptr\(9),
  I2 => \fifo_inst/rbin_num_next\(13));
\fifo_inst/Small.wgraynext_5_s1\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Small.wgraynext\(5),
  I0 => \fifo_inst_Small.wbinnext_5\,
  I1 => \fifo_inst/Small.wbin\(5),
  I2 => \fifo_inst/Small.wbinnext\(6));
\fifo_inst/Small.wcount_r_1_8_s1\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Small.wcount_r_1\(8),
  I0 => \fifo_inst/Small.wcount_r_1\(10),
  I1 => \fifo_inst/Small.rq2_wptr\(5),
  I2 => \fifo_inst/Small.rq2_wptr\(4));
\fifo_inst/Small.rcount_w_3_s1\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => \fifo_inst/Small.rcount_w\(3),
  I0 => \fifo_inst/Small.rcount_w\(6),
  I1 => \fifo_inst/Small.wq2_rptr\(5),
  I2 => \fifo_inst/Small.wq2_rptr\(3),
  I3 => \fifo_inst/Small.wq2_rptr\(4));
\fifo_inst/Small.rcount_w_4_s1\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Small.rcount_w\(4),
  I0 => \fifo_inst/Small.rcount_w\(6),
  I1 => \fifo_inst/Small.wq2_rptr\(5),
  I2 => \fifo_inst/Small.wq2_rptr\(4));
\fifo_inst/n4_s2\: INV
port map (
  O => fifo_inst_n4,
  I => RdClk);
\fifo_inst/n9_s2\: INV
port map (
  O => fifo_inst_n9,
  I => WrClk);
\fifo_inst/rcnt_sub_0_s2\: INV
port map (
  O => fifo_inst_rcnt_sub_0,
  I => \fifo_inst/rbin_num\(0));
GND_s0: GND
port map (
  G => GND_0);
VCC_s0: VCC
port map (
  V => VCC_0);
GSR_0: GSR
port map (
  GSRI => VCC_0);
  Empty <= NN;
  Full <= NN_0;
end beh;
