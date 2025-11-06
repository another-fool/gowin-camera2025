--
--Written by GowinSynthesis
--Tool Version "V1.9.12 (64-bit)"
--Sat Nov  1 17:22:57 2025

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

entity fifo_16x8192_256x512 is
port(
  Data :  in std_logic_vector(15 downto 0);
  Reset :  in std_logic;
  WrClk :  in std_logic;
  RdClk :  in std_logic;
  WrEn :  in std_logic;
  RdEn :  in std_logic;
  Rnum :  out std_logic_vector(9 downto 0);
  Almost_Empty :  out std_logic;
  Q :  out std_logic_vector(255 downto 0);
  Empty :  out std_logic;
  Full :  out std_logic);
end fifo_16x8192_256x512;
architecture beh of fifo_16x8192_256x512 is
  signal fifo_inst_rcnt_sub_0 : std_logic ;
  signal fifo_inst_rcnt_sub_1 : std_logic ;
  signal fifo_inst_rcnt_sub_2 : std_logic ;
  signal fifo_inst_rcnt_sub_3 : std_logic ;
  signal fifo_inst_rcnt_sub_4 : std_logic ;
  signal fifo_inst_rcnt_sub_5 : std_logic ;
  signal fifo_inst_rcnt_sub_6 : std_logic ;
  signal fifo_inst_rcnt_sub_7 : std_logic ;
  signal fifo_inst_rcnt_sub_8 : std_logic ;
  signal fifo_inst_rcnt_sub_9 : std_logic ;
  signal fifo_inst_n1185 : std_logic ;
  signal fifo_inst_n1185_3 : std_logic ;
  signal fifo_inst_n1186 : std_logic ;
  signal fifo_inst_n1186_3 : std_logic ;
  signal fifo_inst_n1187 : std_logic ;
  signal fifo_inst_n1187_3 : std_logic ;
  signal fifo_inst_n1188 : std_logic ;
  signal fifo_inst_n1188_3 : std_logic ;
  signal fifo_inst_n1189 : std_logic ;
  signal fifo_inst_n1189_3 : std_logic ;
  signal fifo_inst_n1190 : std_logic ;
  signal fifo_inst_n1190_3 : std_logic ;
  signal fifo_inst_n1191 : std_logic ;
  signal fifo_inst_n1191_3 : std_logic ;
  signal fifo_inst_n1192 : std_logic ;
  signal fifo_inst_n1192_3 : std_logic ;
  signal fifo_inst_n1193 : std_logic ;
  signal fifo_inst_n1193_3 : std_logic ;
  signal fifo_inst_n28 : std_logic ;
  signal fifo_inst_n32 : std_logic ;
  signal fifo_inst_n1206 : std_logic ;
  signal fifo_inst_wfull_val : std_logic ;
  signal fifo_inst_arempty_val : std_logic ;
  signal \fifo_inst_Big.rgraynext_8\ : std_logic ;
  signal \fifo_inst_Big.wgraynext_0\ : std_logic ;
  signal \fifo_inst_Big.wgraynext_0_5\ : std_logic ;
  signal \fifo_inst_Big.wgraynext_1\ : std_logic ;
  signal \fifo_inst_Big.wgraynext_2\ : std_logic ;
  signal \fifo_inst_Big.wgraynext_3\ : std_logic ;
  signal \fifo_inst_Big.wgraynext_4\ : std_logic ;
  signal \fifo_inst_Big.wgraynext_5\ : std_logic ;
  signal \fifo_inst_Big.wgraynext_7\ : std_logic ;
  signal \fifo_inst_Big.wgraynext_8\ : std_logic ;
  signal fifo_inst_wfull_val_4 : std_logic ;
  signal fifo_inst_wfull_val_5 : std_logic ;
  signal fifo_inst_wfull_val_6 : std_logic ;
  signal fifo_inst_wfull_val_7 : std_logic ;
  signal fifo_inst_arempty_val_4 : std_logic ;
  signal fifo_inst_arempty_val_5 : std_logic ;
  signal fifo_inst_rbin_num_next_2 : std_logic ;
  signal fifo_inst_rbin_num_next_5 : std_logic ;
  signal fifo_inst_rbin_num_next_6 : std_logic ;
  signal \fifo_inst_Big.wgraynext_2_5\ : std_logic ;
  signal \fifo_inst_Big.wgraynext_4_5\ : std_logic ;
  signal \fifo_inst_Big.wgraynext_7_5\ : std_logic ;
  signal fifo_inst_wfull_val_8 : std_logic ;
  signal fifo_inst_wfull_val_9 : std_logic ;
  signal fifo_inst_wfull_val_10 : std_logic ;
  signal fifo_inst_wfull_val_11 : std_logic ;
  signal fifo_inst_wfull_val_12 : std_logic ;
  signal fifo_inst_arempty_val_6 : std_logic ;
  signal fifo_inst_wfull_val_13 : std_logic ;
  signal \fifo_inst_Big.wbin_num_next_7\ : std_logic ;
  signal \fifo_inst_Big.wbin_num_next_0\ : std_logic ;
  signal fifo_inst_rbin_num_next_0 : std_logic ;
  signal fifo_inst_rempty_val : std_logic ;
  signal fifo_inst_n4 : std_logic ;
  signal fifo_inst_n9 : std_logic ;
  signal GND_0 : std_logic ;
  signal VCC_0 : std_logic ;
  signal \fifo_inst/reset_r\ : std_logic_vector(1 downto 0);
  signal \fifo_inst/reset_w\ : std_logic_vector(1 downto 0);
  signal \fifo_inst/rbin_num\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/Big.wq1_rptr\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/Big.wq2_rptr\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/Big.rq1_wptr\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/Big.rq2_wptr\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/Big.rptr\ : std_logic_vector(8 downto 0);
  signal \fifo_inst/Big.wptr\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/Big.wbin\ : std_logic_vector(12 downto 0);
  signal \fifo_inst/rcnt_sub\ : std_logic_vector(9 downto 0);
  signal \fifo_inst/Big.rgraynext\ : std_logic_vector(8 downto 0);
  signal \fifo_inst/Big.wcount_r\ : std_logic_vector(8 downto 0);
  signal \fifo_inst/Big.wgraynext\ : std_logic_vector(8 downto 0);
  signal \fifo_inst/rbin_num_next\ : std_logic_vector(9 downto 1);
  signal \fifo_inst/Big.wbin_num_next\ : std_logic_vector(13 downto 1);
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
\fifo_inst/Big.wq1_rptr_9_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq1_rptr\(9),
  D => \fifo_inst/rbin_num\(9),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq1_rptr_8_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq1_rptr\(8),
  D => \fifo_inst/Big.rptr\(8),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq1_rptr_7_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq1_rptr\(7),
  D => \fifo_inst/Big.rptr\(7),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq1_rptr_6_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq1_rptr\(6),
  D => \fifo_inst/Big.rptr\(6),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq1_rptr_5_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq1_rptr\(5),
  D => \fifo_inst/Big.rptr\(5),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq1_rptr_4_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq1_rptr\(4),
  D => \fifo_inst/Big.rptr\(4),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq1_rptr_3_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq1_rptr\(3),
  D => \fifo_inst/Big.rptr\(3),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq1_rptr_2_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq1_rptr\(2),
  D => \fifo_inst/Big.rptr\(2),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq1_rptr_1_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq1_rptr\(1),
  D => \fifo_inst/Big.rptr\(1),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq1_rptr_0_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq1_rptr\(0),
  D => \fifo_inst/Big.rptr\(0),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq2_rptr_9_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq2_rptr\(9),
  D => \fifo_inst/Big.wq1_rptr\(9),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq2_rptr_8_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq2_rptr\(8),
  D => \fifo_inst/Big.wq1_rptr\(8),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq2_rptr_7_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq2_rptr\(7),
  D => \fifo_inst/Big.wq1_rptr\(7),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq2_rptr_6_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq2_rptr\(6),
  D => \fifo_inst/Big.wq1_rptr\(6),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq2_rptr_5_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq2_rptr\(5),
  D => \fifo_inst/Big.wq1_rptr\(5),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq2_rptr_4_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq2_rptr\(4),
  D => \fifo_inst/Big.wq1_rptr\(4),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq2_rptr_3_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq2_rptr\(3),
  D => \fifo_inst/Big.wq1_rptr\(3),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq2_rptr_2_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq2_rptr\(2),
  D => \fifo_inst/Big.wq1_rptr\(2),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq2_rptr_1_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq2_rptr\(1),
  D => \fifo_inst/Big.wq1_rptr\(1),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wq2_rptr_0_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wq2_rptr\(0),
  D => \fifo_inst/Big.wq1_rptr\(0),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.rq1_wptr_9_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq1_wptr\(9),
  D => \fifo_inst/Big.wptr\(9),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq1_wptr_8_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq1_wptr\(8),
  D => \fifo_inst/Big.wptr\(8),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq1_wptr_7_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq1_wptr\(7),
  D => \fifo_inst/Big.wptr\(7),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq1_wptr_6_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq1_wptr\(6),
  D => \fifo_inst/Big.wptr\(6),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq1_wptr_5_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq1_wptr\(5),
  D => \fifo_inst/Big.wptr\(5),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq1_wptr_4_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq1_wptr\(4),
  D => \fifo_inst/Big.wptr\(4),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq1_wptr_3_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq1_wptr\(3),
  D => \fifo_inst/Big.wptr\(3),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq1_wptr_2_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq1_wptr\(2),
  D => \fifo_inst/Big.wptr\(2),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq1_wptr_1_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq1_wptr\(1),
  D => \fifo_inst/Big.wptr\(1),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq1_wptr_0_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq1_wptr\(0),
  D => \fifo_inst/Big.wptr\(0),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq2_wptr_9_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq2_wptr\(9),
  D => \fifo_inst/Big.rq1_wptr\(9),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq2_wptr_8_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq2_wptr\(8),
  D => \fifo_inst/Big.rq1_wptr\(8),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq2_wptr_7_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq2_wptr\(7),
  D => \fifo_inst/Big.rq1_wptr\(7),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq2_wptr_6_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq2_wptr\(6),
  D => \fifo_inst/Big.rq1_wptr\(6),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq2_wptr_5_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq2_wptr\(5),
  D => \fifo_inst/Big.rq1_wptr\(5),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq2_wptr_4_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq2_wptr\(4),
  D => \fifo_inst/Big.rq1_wptr\(4),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq2_wptr_3_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq2_wptr\(3),
  D => \fifo_inst/Big.rq1_wptr\(3),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq2_wptr_2_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq2_wptr\(2),
  D => \fifo_inst/Big.rq1_wptr\(2),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq2_wptr_1_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq2_wptr\(1),
  D => \fifo_inst/Big.rq1_wptr\(1),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rq2_wptr_0_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rq2_wptr\(0),
  D => \fifo_inst/Big.rq1_wptr\(0),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rptr_8_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rptr\(8),
  D => \fifo_inst/Big.rgraynext\(8),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rptr_7_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rptr\(7),
  D => \fifo_inst/Big.rgraynext\(7),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rptr_6_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rptr\(6),
  D => \fifo_inst/Big.rgraynext\(6),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rptr_5_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rptr\(5),
  D => \fifo_inst/Big.rgraynext\(5),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rptr_4_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rptr\(4),
  D => \fifo_inst/Big.rgraynext\(4),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rptr_3_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rptr\(3),
  D => \fifo_inst/Big.rgraynext\(3),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rptr_2_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rptr\(2),
  D => \fifo_inst/Big.rgraynext\(2),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rptr_1_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rptr\(1),
  D => \fifo_inst/Big.rgraynext\(1),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.rptr_0_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.rptr\(0),
  D => \fifo_inst/Big.rgraynext\(0),
  CLK => RdClk,
  CLEAR => \fifo_inst/reset_r\(1),
  CE => VCC_0);
\fifo_inst/Big.wptr_9_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wptr\(9),
  D => \fifo_inst/Big.wbin_num_next\(13),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wptr_8_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wptr\(8),
  D => \fifo_inst/Big.wgraynext\(8),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wptr_7_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wptr\(7),
  D => \fifo_inst/Big.wgraynext\(7),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wptr_6_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wptr\(6),
  D => \fifo_inst/Big.wgraynext\(6),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wptr_5_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wptr\(5),
  D => \fifo_inst/Big.wgraynext\(5),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wptr_4_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wptr\(4),
  D => \fifo_inst/Big.wgraynext\(4),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wptr_3_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wptr\(3),
  D => \fifo_inst/Big.wgraynext\(3),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wptr_2_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wptr\(2),
  D => \fifo_inst/Big.wgraynext\(2),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wptr_1_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wptr\(1),
  D => \fifo_inst/Big.wgraynext\(1),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wptr_0_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wptr\(0),
  D => \fifo_inst/Big.wgraynext\(0),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wbin_12_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wbin\(12),
  D => \fifo_inst/Big.wbin_num_next\(12),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wbin_11_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wbin\(11),
  D => \fifo_inst/Big.wbin_num_next\(11),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wbin_10_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wbin\(10),
  D => \fifo_inst/Big.wbin_num_next\(10),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wbin_9_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wbin\(9),
  D => \fifo_inst/Big.wbin_num_next\(9),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wbin_8_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wbin\(8),
  D => \fifo_inst/Big.wbin_num_next\(8),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wbin_7_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wbin\(7),
  D => \fifo_inst/Big.wbin_num_next\(7),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wbin_6_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wbin\(6),
  D => \fifo_inst/Big.wbin_num_next\(6),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wbin_5_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wbin\(5),
  D => \fifo_inst/Big.wbin_num_next\(5),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wbin_4_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wbin\(4),
  D => \fifo_inst/Big.wbin_num_next\(4),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wbin_3_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wbin\(3),
  D => \fifo_inst/Big.wbin_num_next\(3),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wbin_2_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wbin\(2),
  D => \fifo_inst/Big.wbin_num_next\(2),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wbin_1_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wbin\(1),
  D => \fifo_inst/Big.wbin_num_next\(1),
  CLK => WrClk,
  CLEAR => \fifo_inst/reset_w\(1),
  CE => VCC_0);
\fifo_inst/Big.wbin_0_s0\: DFFCE
port map (
  Q => \fifo_inst/Big.wbin\(0),
  D => \fifo_inst_Big.wbin_num_next_0\,
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
\fifo_inst/Almost_Empty_s0\: DFFPE
port map (
  Q => Almost_Empty,
  D => fifo_inst_arempty_val,
  CLK => RdClk,
  PRESET => \fifo_inst/reset_r\(1),
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
  D => \fifo_inst/rcnt_sub\(0),
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
\fifo_inst/Big.mem_Big.mem_0_0_s\: SDPB
generic map (
  BIT_WIDTH_0 => 2,
  BIT_WIDTH_1 => 32,
  READ_MODE => '0',
  RESET_MODE => "ASYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31 downto 30) => Q(241 downto 240),
  DO(29 downto 28) => Q(225 downto 224),
  DO(27 downto 26) => Q(209 downto 208),
  DO(25 downto 24) => Q(193 downto 192),
  DO(23 downto 22) => Q(177 downto 176),
  DO(21 downto 20) => Q(161 downto 160),
  DO(19 downto 18) => Q(145 downto 144),
  DO(17 downto 16) => Q(129 downto 128),
  DO(15 downto 14) => Q(113 downto 112),
  DO(13 downto 12) => Q(97 downto 96),
  DO(11 downto 10) => Q(81 downto 80),
  DO(9 downto 8) => Q(65 downto 64),
  DO(7 downto 6) => Q(49 downto 48),
  DO(5 downto 4) => Q(33 downto 32),
  DO(3 downto 2) => Q(17 downto 16),
  DO(1 downto 0) => Q(1 downto 0),
  CLKA => WrClk,
  CEA => fifo_inst_n28,
  CLKB => RdClk,
  CEB => fifo_inst_n32,
  OCE => GND_0,
  RESET => \fifo_inst/reset_r\(1),
  ADA(13 downto 1) => \fifo_inst/Big.wbin\(12 downto 0),
  ADA(0) => GND_0,
  ADB(13 downto 5) => \fifo_inst/rbin_num\(8 downto 0),
  ADB(4) => GND_0,
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  DI(31) => GND_0,
  DI(30) => GND_0,
  DI(29) => GND_0,
  DI(28) => GND_0,
  DI(27) => GND_0,
  DI(26) => GND_0,
  DI(25) => GND_0,
  DI(24) => GND_0,
  DI(23) => GND_0,
  DI(22) => GND_0,
  DI(21) => GND_0,
  DI(20) => GND_0,
  DI(19) => GND_0,
  DI(18) => GND_0,
  DI(17) => GND_0,
  DI(16) => GND_0,
  DI(15) => GND_0,
  DI(14) => GND_0,
  DI(13) => GND_0,
  DI(12) => GND_0,
  DI(11) => GND_0,
  DI(10) => GND_0,
  DI(9) => GND_0,
  DI(8) => GND_0,
  DI(7) => GND_0,
  DI(6) => GND_0,
  DI(5) => GND_0,
  DI(4) => GND_0,
  DI(3) => GND_0,
  DI(2) => GND_0,
  DI(1 downto 0) => Data(1 downto 0),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0);
\fifo_inst/Big.mem_Big.mem_0_1_s\: SDPB
generic map (
  BIT_WIDTH_0 => 2,
  BIT_WIDTH_1 => 32,
  READ_MODE => '0',
  RESET_MODE => "ASYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31 downto 30) => Q(243 downto 242),
  DO(29 downto 28) => Q(227 downto 226),
  DO(27 downto 26) => Q(211 downto 210),
  DO(25 downto 24) => Q(195 downto 194),
  DO(23 downto 22) => Q(179 downto 178),
  DO(21 downto 20) => Q(163 downto 162),
  DO(19 downto 18) => Q(147 downto 146),
  DO(17 downto 16) => Q(131 downto 130),
  DO(15 downto 14) => Q(115 downto 114),
  DO(13 downto 12) => Q(99 downto 98),
  DO(11 downto 10) => Q(83 downto 82),
  DO(9 downto 8) => Q(67 downto 66),
  DO(7 downto 6) => Q(51 downto 50),
  DO(5 downto 4) => Q(35 downto 34),
  DO(3 downto 2) => Q(19 downto 18),
  DO(1 downto 0) => Q(3 downto 2),
  CLKA => WrClk,
  CEA => fifo_inst_n28,
  CLKB => RdClk,
  CEB => fifo_inst_n32,
  OCE => GND_0,
  RESET => \fifo_inst/reset_r\(1),
  ADA(13 downto 1) => \fifo_inst/Big.wbin\(12 downto 0),
  ADA(0) => GND_0,
  ADB(13 downto 5) => \fifo_inst/rbin_num\(8 downto 0),
  ADB(4) => GND_0,
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  DI(31) => GND_0,
  DI(30) => GND_0,
  DI(29) => GND_0,
  DI(28) => GND_0,
  DI(27) => GND_0,
  DI(26) => GND_0,
  DI(25) => GND_0,
  DI(24) => GND_0,
  DI(23) => GND_0,
  DI(22) => GND_0,
  DI(21) => GND_0,
  DI(20) => GND_0,
  DI(19) => GND_0,
  DI(18) => GND_0,
  DI(17) => GND_0,
  DI(16) => GND_0,
  DI(15) => GND_0,
  DI(14) => GND_0,
  DI(13) => GND_0,
  DI(12) => GND_0,
  DI(11) => GND_0,
  DI(10) => GND_0,
  DI(9) => GND_0,
  DI(8) => GND_0,
  DI(7) => GND_0,
  DI(6) => GND_0,
  DI(5) => GND_0,
  DI(4) => GND_0,
  DI(3) => GND_0,
  DI(2) => GND_0,
  DI(1 downto 0) => Data(3 downto 2),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0);
\fifo_inst/Big.mem_Big.mem_0_2_s\: SDPB
generic map (
  BIT_WIDTH_0 => 2,
  BIT_WIDTH_1 => 32,
  READ_MODE => '0',
  RESET_MODE => "ASYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31 downto 30) => Q(245 downto 244),
  DO(29 downto 28) => Q(229 downto 228),
  DO(27 downto 26) => Q(213 downto 212),
  DO(25 downto 24) => Q(197 downto 196),
  DO(23 downto 22) => Q(181 downto 180),
  DO(21 downto 20) => Q(165 downto 164),
  DO(19 downto 18) => Q(149 downto 148),
  DO(17 downto 16) => Q(133 downto 132),
  DO(15 downto 14) => Q(117 downto 116),
  DO(13 downto 12) => Q(101 downto 100),
  DO(11 downto 10) => Q(85 downto 84),
  DO(9 downto 8) => Q(69 downto 68),
  DO(7 downto 6) => Q(53 downto 52),
  DO(5 downto 4) => Q(37 downto 36),
  DO(3 downto 2) => Q(21 downto 20),
  DO(1 downto 0) => Q(5 downto 4),
  CLKA => WrClk,
  CEA => fifo_inst_n28,
  CLKB => RdClk,
  CEB => fifo_inst_n32,
  OCE => GND_0,
  RESET => \fifo_inst/reset_r\(1),
  ADA(13 downto 1) => \fifo_inst/Big.wbin\(12 downto 0),
  ADA(0) => GND_0,
  ADB(13 downto 5) => \fifo_inst/rbin_num\(8 downto 0),
  ADB(4) => GND_0,
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  DI(31) => GND_0,
  DI(30) => GND_0,
  DI(29) => GND_0,
  DI(28) => GND_0,
  DI(27) => GND_0,
  DI(26) => GND_0,
  DI(25) => GND_0,
  DI(24) => GND_0,
  DI(23) => GND_0,
  DI(22) => GND_0,
  DI(21) => GND_0,
  DI(20) => GND_0,
  DI(19) => GND_0,
  DI(18) => GND_0,
  DI(17) => GND_0,
  DI(16) => GND_0,
  DI(15) => GND_0,
  DI(14) => GND_0,
  DI(13) => GND_0,
  DI(12) => GND_0,
  DI(11) => GND_0,
  DI(10) => GND_0,
  DI(9) => GND_0,
  DI(8) => GND_0,
  DI(7) => GND_0,
  DI(6) => GND_0,
  DI(5) => GND_0,
  DI(4) => GND_0,
  DI(3) => GND_0,
  DI(2) => GND_0,
  DI(1 downto 0) => Data(5 downto 4),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0);
\fifo_inst/Big.mem_Big.mem_0_3_s\: SDPB
generic map (
  BIT_WIDTH_0 => 2,
  BIT_WIDTH_1 => 32,
  READ_MODE => '0',
  RESET_MODE => "ASYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31 downto 30) => Q(247 downto 246),
  DO(29 downto 28) => Q(231 downto 230),
  DO(27 downto 26) => Q(215 downto 214),
  DO(25 downto 24) => Q(199 downto 198),
  DO(23 downto 22) => Q(183 downto 182),
  DO(21 downto 20) => Q(167 downto 166),
  DO(19 downto 18) => Q(151 downto 150),
  DO(17 downto 16) => Q(135 downto 134),
  DO(15 downto 14) => Q(119 downto 118),
  DO(13 downto 12) => Q(103 downto 102),
  DO(11 downto 10) => Q(87 downto 86),
  DO(9 downto 8) => Q(71 downto 70),
  DO(7 downto 6) => Q(55 downto 54),
  DO(5 downto 4) => Q(39 downto 38),
  DO(3 downto 2) => Q(23 downto 22),
  DO(1 downto 0) => Q(7 downto 6),
  CLKA => WrClk,
  CEA => fifo_inst_n28,
  CLKB => RdClk,
  CEB => fifo_inst_n32,
  OCE => GND_0,
  RESET => \fifo_inst/reset_r\(1),
  ADA(13 downto 1) => \fifo_inst/Big.wbin\(12 downto 0),
  ADA(0) => GND_0,
  ADB(13 downto 5) => \fifo_inst/rbin_num\(8 downto 0),
  ADB(4) => GND_0,
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  DI(31) => GND_0,
  DI(30) => GND_0,
  DI(29) => GND_0,
  DI(28) => GND_0,
  DI(27) => GND_0,
  DI(26) => GND_0,
  DI(25) => GND_0,
  DI(24) => GND_0,
  DI(23) => GND_0,
  DI(22) => GND_0,
  DI(21) => GND_0,
  DI(20) => GND_0,
  DI(19) => GND_0,
  DI(18) => GND_0,
  DI(17) => GND_0,
  DI(16) => GND_0,
  DI(15) => GND_0,
  DI(14) => GND_0,
  DI(13) => GND_0,
  DI(12) => GND_0,
  DI(11) => GND_0,
  DI(10) => GND_0,
  DI(9) => GND_0,
  DI(8) => GND_0,
  DI(7) => GND_0,
  DI(6) => GND_0,
  DI(5) => GND_0,
  DI(4) => GND_0,
  DI(3) => GND_0,
  DI(2) => GND_0,
  DI(1 downto 0) => Data(7 downto 6),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0);
\fifo_inst/Big.mem_Big.mem_0_4_s\: SDPB
generic map (
  BIT_WIDTH_0 => 2,
  BIT_WIDTH_1 => 32,
  READ_MODE => '0',
  RESET_MODE => "ASYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31 downto 30) => Q(249 downto 248),
  DO(29 downto 28) => Q(233 downto 232),
  DO(27 downto 26) => Q(217 downto 216),
  DO(25 downto 24) => Q(201 downto 200),
  DO(23 downto 22) => Q(185 downto 184),
  DO(21 downto 20) => Q(169 downto 168),
  DO(19 downto 18) => Q(153 downto 152),
  DO(17 downto 16) => Q(137 downto 136),
  DO(15 downto 14) => Q(121 downto 120),
  DO(13 downto 12) => Q(105 downto 104),
  DO(11 downto 10) => Q(89 downto 88),
  DO(9 downto 8) => Q(73 downto 72),
  DO(7 downto 6) => Q(57 downto 56),
  DO(5 downto 4) => Q(41 downto 40),
  DO(3 downto 2) => Q(25 downto 24),
  DO(1 downto 0) => Q(9 downto 8),
  CLKA => WrClk,
  CEA => fifo_inst_n28,
  CLKB => RdClk,
  CEB => fifo_inst_n32,
  OCE => GND_0,
  RESET => \fifo_inst/reset_r\(1),
  ADA(13 downto 1) => \fifo_inst/Big.wbin\(12 downto 0),
  ADA(0) => GND_0,
  ADB(13 downto 5) => \fifo_inst/rbin_num\(8 downto 0),
  ADB(4) => GND_0,
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  DI(31) => GND_0,
  DI(30) => GND_0,
  DI(29) => GND_0,
  DI(28) => GND_0,
  DI(27) => GND_0,
  DI(26) => GND_0,
  DI(25) => GND_0,
  DI(24) => GND_0,
  DI(23) => GND_0,
  DI(22) => GND_0,
  DI(21) => GND_0,
  DI(20) => GND_0,
  DI(19) => GND_0,
  DI(18) => GND_0,
  DI(17) => GND_0,
  DI(16) => GND_0,
  DI(15) => GND_0,
  DI(14) => GND_0,
  DI(13) => GND_0,
  DI(12) => GND_0,
  DI(11) => GND_0,
  DI(10) => GND_0,
  DI(9) => GND_0,
  DI(8) => GND_0,
  DI(7) => GND_0,
  DI(6) => GND_0,
  DI(5) => GND_0,
  DI(4) => GND_0,
  DI(3) => GND_0,
  DI(2) => GND_0,
  DI(1 downto 0) => Data(9 downto 8),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0);
\fifo_inst/Big.mem_Big.mem_0_5_s\: SDPB
generic map (
  BIT_WIDTH_0 => 2,
  BIT_WIDTH_1 => 32,
  READ_MODE => '0',
  RESET_MODE => "ASYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31 downto 30) => Q(251 downto 250),
  DO(29 downto 28) => Q(235 downto 234),
  DO(27 downto 26) => Q(219 downto 218),
  DO(25 downto 24) => Q(203 downto 202),
  DO(23 downto 22) => Q(187 downto 186),
  DO(21 downto 20) => Q(171 downto 170),
  DO(19 downto 18) => Q(155 downto 154),
  DO(17 downto 16) => Q(139 downto 138),
  DO(15 downto 14) => Q(123 downto 122),
  DO(13 downto 12) => Q(107 downto 106),
  DO(11 downto 10) => Q(91 downto 90),
  DO(9 downto 8) => Q(75 downto 74),
  DO(7 downto 6) => Q(59 downto 58),
  DO(5 downto 4) => Q(43 downto 42),
  DO(3 downto 2) => Q(27 downto 26),
  DO(1 downto 0) => Q(11 downto 10),
  CLKA => WrClk,
  CEA => fifo_inst_n28,
  CLKB => RdClk,
  CEB => fifo_inst_n32,
  OCE => GND_0,
  RESET => \fifo_inst/reset_r\(1),
  ADA(13 downto 1) => \fifo_inst/Big.wbin\(12 downto 0),
  ADA(0) => GND_0,
  ADB(13 downto 5) => \fifo_inst/rbin_num\(8 downto 0),
  ADB(4) => GND_0,
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  DI(31) => GND_0,
  DI(30) => GND_0,
  DI(29) => GND_0,
  DI(28) => GND_0,
  DI(27) => GND_0,
  DI(26) => GND_0,
  DI(25) => GND_0,
  DI(24) => GND_0,
  DI(23) => GND_0,
  DI(22) => GND_0,
  DI(21) => GND_0,
  DI(20) => GND_0,
  DI(19) => GND_0,
  DI(18) => GND_0,
  DI(17) => GND_0,
  DI(16) => GND_0,
  DI(15) => GND_0,
  DI(14) => GND_0,
  DI(13) => GND_0,
  DI(12) => GND_0,
  DI(11) => GND_0,
  DI(10) => GND_0,
  DI(9) => GND_0,
  DI(8) => GND_0,
  DI(7) => GND_0,
  DI(6) => GND_0,
  DI(5) => GND_0,
  DI(4) => GND_0,
  DI(3) => GND_0,
  DI(2) => GND_0,
  DI(1 downto 0) => Data(11 downto 10),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0);
\fifo_inst/Big.mem_Big.mem_0_6_s\: SDPB
generic map (
  BIT_WIDTH_0 => 2,
  BIT_WIDTH_1 => 32,
  READ_MODE => '0',
  RESET_MODE => "ASYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31 downto 30) => Q(253 downto 252),
  DO(29 downto 28) => Q(237 downto 236),
  DO(27 downto 26) => Q(221 downto 220),
  DO(25 downto 24) => Q(205 downto 204),
  DO(23 downto 22) => Q(189 downto 188),
  DO(21 downto 20) => Q(173 downto 172),
  DO(19 downto 18) => Q(157 downto 156),
  DO(17 downto 16) => Q(141 downto 140),
  DO(15 downto 14) => Q(125 downto 124),
  DO(13 downto 12) => Q(109 downto 108),
  DO(11 downto 10) => Q(93 downto 92),
  DO(9 downto 8) => Q(77 downto 76),
  DO(7 downto 6) => Q(61 downto 60),
  DO(5 downto 4) => Q(45 downto 44),
  DO(3 downto 2) => Q(29 downto 28),
  DO(1 downto 0) => Q(13 downto 12),
  CLKA => WrClk,
  CEA => fifo_inst_n28,
  CLKB => RdClk,
  CEB => fifo_inst_n32,
  OCE => GND_0,
  RESET => \fifo_inst/reset_r\(1),
  ADA(13 downto 1) => \fifo_inst/Big.wbin\(12 downto 0),
  ADA(0) => GND_0,
  ADB(13 downto 5) => \fifo_inst/rbin_num\(8 downto 0),
  ADB(4) => GND_0,
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  DI(31) => GND_0,
  DI(30) => GND_0,
  DI(29) => GND_0,
  DI(28) => GND_0,
  DI(27) => GND_0,
  DI(26) => GND_0,
  DI(25) => GND_0,
  DI(24) => GND_0,
  DI(23) => GND_0,
  DI(22) => GND_0,
  DI(21) => GND_0,
  DI(20) => GND_0,
  DI(19) => GND_0,
  DI(18) => GND_0,
  DI(17) => GND_0,
  DI(16) => GND_0,
  DI(15) => GND_0,
  DI(14) => GND_0,
  DI(13) => GND_0,
  DI(12) => GND_0,
  DI(11) => GND_0,
  DI(10) => GND_0,
  DI(9) => GND_0,
  DI(8) => GND_0,
  DI(7) => GND_0,
  DI(6) => GND_0,
  DI(5) => GND_0,
  DI(4) => GND_0,
  DI(3) => GND_0,
  DI(2) => GND_0,
  DI(1 downto 0) => Data(13 downto 12),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0);
\fifo_inst/Big.mem_Big.mem_0_7_s\: SDPB
generic map (
  BIT_WIDTH_0 => 2,
  BIT_WIDTH_1 => 32,
  READ_MODE => '0',
  RESET_MODE => "ASYNC",
  BLK_SEL_0 => "000",
  BLK_SEL_1 => "000"
)
port map (
  DO(31 downto 30) => Q(255 downto 254),
  DO(29 downto 28) => Q(239 downto 238),
  DO(27 downto 26) => Q(223 downto 222),
  DO(25 downto 24) => Q(207 downto 206),
  DO(23 downto 22) => Q(191 downto 190),
  DO(21 downto 20) => Q(175 downto 174),
  DO(19 downto 18) => Q(159 downto 158),
  DO(17 downto 16) => Q(143 downto 142),
  DO(15 downto 14) => Q(127 downto 126),
  DO(13 downto 12) => Q(111 downto 110),
  DO(11 downto 10) => Q(95 downto 94),
  DO(9 downto 8) => Q(79 downto 78),
  DO(7 downto 6) => Q(63 downto 62),
  DO(5 downto 4) => Q(47 downto 46),
  DO(3 downto 2) => Q(31 downto 30),
  DO(1 downto 0) => Q(15 downto 14),
  CLKA => WrClk,
  CEA => fifo_inst_n28,
  CLKB => RdClk,
  CEB => fifo_inst_n32,
  OCE => GND_0,
  RESET => \fifo_inst/reset_r\(1),
  ADA(13 downto 1) => \fifo_inst/Big.wbin\(12 downto 0),
  ADA(0) => GND_0,
  ADB(13 downto 5) => \fifo_inst/rbin_num\(8 downto 0),
  ADB(4) => GND_0,
  ADB(3) => GND_0,
  ADB(2) => GND_0,
  ADB(1) => GND_0,
  ADB(0) => GND_0,
  DI(31) => GND_0,
  DI(30) => GND_0,
  DI(29) => GND_0,
  DI(28) => GND_0,
  DI(27) => GND_0,
  DI(26) => GND_0,
  DI(25) => GND_0,
  DI(24) => GND_0,
  DI(23) => GND_0,
  DI(22) => GND_0,
  DI(21) => GND_0,
  DI(20) => GND_0,
  DI(19) => GND_0,
  DI(18) => GND_0,
  DI(17) => GND_0,
  DI(16) => GND_0,
  DI(15) => GND_0,
  DI(14) => GND_0,
  DI(13) => GND_0,
  DI(12) => GND_0,
  DI(11) => GND_0,
  DI(10) => GND_0,
  DI(9) => GND_0,
  DI(8) => GND_0,
  DI(7) => GND_0,
  DI(6) => GND_0,
  DI(5) => GND_0,
  DI(4) => GND_0,
  DI(3) => GND_0,
  DI(2) => GND_0,
  DI(1 downto 0) => Data(15 downto 14),
  BLKSELA(2) => GND_0,
  BLKSELA(1) => GND_0,
  BLKSELA(0) => GND_0,
  BLKSELB(2) => GND_0,
  BLKSELB(1) => GND_0,
  BLKSELB(0) => GND_0);
\fifo_inst/rcnt_sub_0_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(0),
  COUT => fifo_inst_rcnt_sub_0,
  I0 => \fifo_inst/Big.wcount_r\(0),
  I1 => \fifo_inst/rbin_num\(0),
  I3 => GND_0,
  CIN => VCC_0);
\fifo_inst/rcnt_sub_1_s\: ALU
generic map (
  ALU_MODE => 1
)
port map (
  SUM => \fifo_inst/rcnt_sub\(1),
  COUT => fifo_inst_rcnt_sub_1,
  I0 => \fifo_inst/Big.wcount_r\(1),
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
  I0 => \fifo_inst/Big.wcount_r\(2),
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
  I0 => \fifo_inst/Big.wcount_r\(3),
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
  I0 => \fifo_inst/Big.wcount_r\(4),
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
  I0 => \fifo_inst/Big.wcount_r\(5),
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
  I0 => \fifo_inst/Big.wcount_r\(6),
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
  I0 => \fifo_inst/Big.wcount_r\(7),
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
  I0 => \fifo_inst/Big.wcount_r\(8),
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
  I0 => fifo_inst_n1206,
  I1 => GND_0,
  I3 => GND_0,
  CIN => fifo_inst_rcnt_sub_8);
\fifo_inst/n1185_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1185,
  COUT => fifo_inst_n1185_3,
  I0 => \fifo_inst/Big.rgraynext\(0),
  I1 => \fifo_inst/Big.rq2_wptr\(0),
  I3 => GND_0,
  CIN => GND_0);
\fifo_inst/n1186_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1186,
  COUT => fifo_inst_n1186_3,
  I0 => \fifo_inst/Big.rgraynext\(1),
  I1 => \fifo_inst/Big.rq2_wptr\(1),
  I3 => GND_0,
  CIN => fifo_inst_n1185_3);
\fifo_inst/n1187_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1187,
  COUT => fifo_inst_n1187_3,
  I0 => \fifo_inst/Big.rgraynext\(2),
  I1 => \fifo_inst/Big.rq2_wptr\(2),
  I3 => GND_0,
  CIN => fifo_inst_n1186_3);
\fifo_inst/n1188_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1188,
  COUT => fifo_inst_n1188_3,
  I0 => \fifo_inst/Big.rgraynext\(3),
  I1 => \fifo_inst/Big.rq2_wptr\(3),
  I3 => GND_0,
  CIN => fifo_inst_n1187_3);
\fifo_inst/n1189_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1189,
  COUT => fifo_inst_n1189_3,
  I0 => \fifo_inst/Big.rgraynext\(4),
  I1 => \fifo_inst/Big.rq2_wptr\(4),
  I3 => GND_0,
  CIN => fifo_inst_n1188_3);
\fifo_inst/n1190_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1190,
  COUT => fifo_inst_n1190_3,
  I0 => \fifo_inst/Big.rgraynext\(5),
  I1 => \fifo_inst/Big.rq2_wptr\(5),
  I3 => GND_0,
  CIN => fifo_inst_n1189_3);
\fifo_inst/n1191_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1191,
  COUT => fifo_inst_n1191_3,
  I0 => \fifo_inst/Big.rgraynext\(6),
  I1 => \fifo_inst/Big.rq2_wptr\(6),
  I3 => GND_0,
  CIN => fifo_inst_n1190_3);
\fifo_inst/n1192_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1192,
  COUT => fifo_inst_n1192_3,
  I0 => \fifo_inst/Big.rgraynext\(7),
  I1 => \fifo_inst/Big.rq2_wptr\(7),
  I3 => GND_0,
  CIN => fifo_inst_n1191_3);
\fifo_inst/n1193_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n1193,
  COUT => fifo_inst_n1193_3,
  I0 => \fifo_inst/Big.rgraynext\(8),
  I1 => \fifo_inst/Big.rq2_wptr\(8),
  I3 => GND_0,
  CIN => fifo_inst_n1192_3);
\fifo_inst/n28_s1\: LUT2
generic map (
  INIT => X"4"
)
port map (
  F => fifo_inst_n28,
  I0 => NN_0,
  I1 => WrEn);
\fifo_inst/n32_s0\: LUT2
generic map (
  INIT => X"4"
)
port map (
  F => fifo_inst_n32,
  I0 => NN,
  I1 => RdEn);
\fifo_inst/Big.rgraynext_7_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Big.rgraynext\(7),
  I0 => \fifo_inst/rbin_num_next\(7),
  I1 => \fifo_inst/rbin_num_next\(8));
\fifo_inst/Big.rgraynext_8_s0\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Big.rgraynext\(8),
  I0 => \fifo_inst_Big.rgraynext_8\,
  I1 => \fifo_inst/rbin_num_next\(8),
  I2 => \fifo_inst/rbin_num\(9));
\fifo_inst/Big.wcount_r_8_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Big.wcount_r\(8),
  I0 => \fifo_inst/Big.rq2_wptr\(9),
  I1 => \fifo_inst/Big.rq2_wptr\(8));
\fifo_inst/Big.wcount_r_5_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Big.wcount_r\(5),
  I0 => \fifo_inst/Big.wcount_r\(6),
  I1 => \fifo_inst/Big.rq2_wptr\(5));
\fifo_inst/Big.wcount_r_4_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Big.wcount_r\(4),
  I0 => \fifo_inst/Big.wcount_r\(5),
  I1 => \fifo_inst/Big.rq2_wptr\(4));
\fifo_inst/Big.wcount_r_3_s0\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => \fifo_inst/Big.wcount_r\(3),
  I0 => \fifo_inst/Big.wcount_r\(6),
  I1 => \fifo_inst/Big.rq2_wptr\(5),
  I2 => \fifo_inst/Big.rq2_wptr\(4),
  I3 => \fifo_inst/Big.rq2_wptr\(3));
\fifo_inst/Big.wcount_r_2_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Big.wcount_r\(2),
  I0 => \fifo_inst/Big.wcount_r\(3),
  I1 => \fifo_inst/Big.rq2_wptr\(2));
\fifo_inst/Big.wcount_r_1_s0\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Big.wcount_r\(1),
  I0 => \fifo_inst/Big.wcount_r\(3),
  I1 => \fifo_inst/Big.rq2_wptr\(2),
  I2 => \fifo_inst/Big.rq2_wptr\(1));
\fifo_inst/Big.wcount_r_0_s0\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => \fifo_inst/Big.wcount_r\(0),
  I0 => \fifo_inst/Big.wcount_r\(3),
  I1 => \fifo_inst/Big.rq2_wptr\(2),
  I2 => \fifo_inst/Big.rq2_wptr\(1),
  I3 => \fifo_inst/Big.rq2_wptr\(0));
\fifo_inst/n1206_s0\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => fifo_inst_n1206,
  I0 => \fifo_inst/Big.rq2_wptr\(9),
  I1 => \fifo_inst/rbin_num\(9));
\fifo_inst/Big.wgraynext_0_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Big.wgraynext\(0),
  I0 => \fifo_inst_Big.wgraynext_0\,
  I1 => \fifo_inst_Big.wgraynext_0_5\,
  I2 => \fifo_inst/Big.wbin\(4),
  I3 => \fifo_inst/Big.wbin\(5));
\fifo_inst/Big.wgraynext_1_s0\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => \fifo_inst/Big.wgraynext\(1),
  I0 => \fifo_inst_Big.wgraynext_1\,
  I1 => \fifo_inst/Big.wbin\(6));
\fifo_inst/Big.wgraynext_3_s0\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => \fifo_inst/Big.wgraynext\(3),
  I0 => \fifo_inst_Big.wgraynext_3\,
  I1 => \fifo_inst/Big.wbin\(8));
\fifo_inst/Big.wgraynext_4_s0\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => \fifo_inst/Big.wgraynext\(4),
  I0 => \fifo_inst_Big.wgraynext_4\,
  I1 => \fifo_inst/Big.wbin\(9));
\fifo_inst/Big.wgraynext_5_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Big.wgraynext\(5),
  I0 => \fifo_inst_Big.wgraynext_5\,
  I1 => \fifo_inst/Big.wbin\(9),
  I2 => \fifo_inst/Big.wbin\(10));
\fifo_inst/Big.wgraynext_6_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Big.wgraynext\(6),
  I0 => \fifo_inst_Big.wgraynext_5\,
  I1 => \fifo_inst/Big.wbin\(9),
  I2 => \fifo_inst/Big.wbin\(10),
  I3 => \fifo_inst/Big.wbin\(11));
\fifo_inst/Big.wgraynext_7_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Big.wgraynext\(7),
  I0 => \fifo_inst_Big.wgraynext_7\,
  I1 => \fifo_inst/Big.wbin\(11),
  I2 => \fifo_inst/Big.wbin\(12));
\fifo_inst/wfull_val_s0\: LUT4
generic map (
  INIT => X"0800"
)
port map (
  F => fifo_inst_wfull_val,
  I0 => fifo_inst_wfull_val_4,
  I1 => fifo_inst_wfull_val_5,
  I2 => fifo_inst_wfull_val_6,
  I3 => fifo_inst_wfull_val_7);
\fifo_inst/arempty_val_s0\: LUT4
generic map (
  INIT => X"1F00"
)
port map (
  F => fifo_inst_arempty_val,
  I0 => \fifo_inst/rcnt_sub\(5),
  I1 => fifo_inst_arempty_val_4,
  I2 => \fifo_inst/rcnt_sub\(6),
  I3 => fifo_inst_arempty_val_5);
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
\fifo_inst/rbin_num_next_4_s3\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/rbin_num_next\(4),
  I0 => fifo_inst_rbin_num_next_2,
  I1 => \fifo_inst/rbin_num\(2),
  I2 => \fifo_inst/rbin_num\(3),
  I3 => \fifo_inst/rbin_num\(4));
\fifo_inst/rbin_num_next_5_s3\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/rbin_num_next\(5),
  I0 => fifo_inst_rbin_num_next_5,
  I1 => \fifo_inst/rbin_num\(5));
\fifo_inst/rbin_num_next_8_s3\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/rbin_num_next\(8),
  I0 => fifo_inst_rbin_num_next_6,
  I1 => \fifo_inst/rbin_num\(6),
  I2 => \fifo_inst/rbin_num\(7),
  I3 => \fifo_inst/rbin_num\(8));
\fifo_inst/rbin_num_next_9_s2\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/rbin_num_next\(9),
  I0 => \fifo_inst_Big.rgraynext_8\,
  I1 => \fifo_inst/rbin_num\(9));
\fifo_inst/Big.wbin_num_next_2_s3\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Big.wbin_num_next\(2),
  I0 => \fifo_inst_Big.wgraynext_0\,
  I1 => \fifo_inst/Big.wbin\(2));
\fifo_inst/Big.wbin_num_next_3_s3\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/Big.wbin_num_next\(3),
  I0 => \fifo_inst_Big.wgraynext_0\,
  I1 => \fifo_inst/Big.wbin\(2),
  I2 => \fifo_inst/Big.wbin\(3));
\fifo_inst/Big.wbin_num_next_7_s3\: LUT2
generic map (
  INIT => X"1"
)
port map (
  F => \fifo_inst/Big.wbin_num_next\(7),
  I0 => \fifo_inst_Big.wbin_num_next_7\,
  I1 => \fifo_inst_Big.wgraynext_3\);
\fifo_inst/Big.wbin_num_next_8_s3\: LUT2
generic map (
  INIT => X"1"
)
port map (
  F => \fifo_inst/Big.wbin_num_next\(8),
  I0 => \fifo_inst_Big.wgraynext_4\,
  I1 => \fifo_inst_Big.wgraynext_5\);
\fifo_inst/Big.wbin_num_next_9_s3\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Big.wbin_num_next\(9),
  I0 => \fifo_inst_Big.wgraynext_5\,
  I1 => \fifo_inst/Big.wbin\(9));
\fifo_inst/Big.wbin_num_next_10_s3\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/Big.wbin_num_next\(10),
  I0 => \fifo_inst_Big.wgraynext_5\,
  I1 => \fifo_inst/Big.wbin\(9),
  I2 => \fifo_inst/Big.wbin\(10));
\fifo_inst/Big.wbin_num_next_11_s3\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/Big.wbin_num_next\(11),
  I0 => \fifo_inst_Big.wgraynext_7\,
  I1 => \fifo_inst/Big.wbin\(11));
\fifo_inst/Big.wbin_num_next_12_s3\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/Big.wbin_num_next\(12),
  I0 => \fifo_inst_Big.wgraynext_7\,
  I1 => \fifo_inst/Big.wbin\(11),
  I2 => \fifo_inst/Big.wbin\(12));
\fifo_inst/Big.wbin_num_next_13_s2\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/Big.wbin_num_next\(13),
  I0 => \fifo_inst_Big.wgraynext_7\,
  I1 => \fifo_inst/Big.wbin\(11),
  I2 => \fifo_inst/Big.wbin\(12),
  I3 => \fifo_inst/Big.wptr\(9));
\fifo_inst/Big.rgraynext_8_s1\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Big.rgraynext_8\,
  I0 => fifo_inst_rbin_num_next_6,
  I1 => \fifo_inst/rbin_num\(6),
  I2 => \fifo_inst/rbin_num\(7),
  I3 => \fifo_inst/rbin_num\(8));
\fifo_inst/Big.wgraynext_0_s1\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => \fifo_inst_Big.wgraynext_0\,
  I0 => NN_0,
  I1 => WrEn,
  I2 => \fifo_inst/Big.wbin\(0),
  I3 => \fifo_inst/Big.wbin\(1));
\fifo_inst/Big.wgraynext_0_s2\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Big.wgraynext_0_5\,
  I0 => \fifo_inst/Big.wbin\(2),
  I1 => \fifo_inst/Big.wbin\(3));
\fifo_inst/Big.wgraynext_1_s1\: LUT4
generic map (
  INIT => X"007F"
)
port map (
  F => \fifo_inst_Big.wgraynext_1\,
  I0 => \fifo_inst_Big.wgraynext_0_5\,
  I1 => \fifo_inst/Big.wbin\(4),
  I2 => \fifo_inst_Big.wgraynext_0\,
  I3 => \fifo_inst/Big.wbin\(5));
\fifo_inst/Big.wgraynext_2_s1\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Big.wgraynext_2\,
  I0 => \fifo_inst_Big.wgraynext_0\,
  I1 => \fifo_inst_Big.wgraynext_2_5\);
\fifo_inst/Big.wgraynext_3_s1\: LUT4
generic map (
  INIT => X"007F"
)
port map (
  F => \fifo_inst_Big.wgraynext_3\,
  I0 => \fifo_inst_Big.wgraynext_2_5\,
  I1 => \fifo_inst/Big.wbin\(6),
  I2 => \fifo_inst_Big.wgraynext_0\,
  I3 => \fifo_inst/Big.wbin\(7));
\fifo_inst/Big.wgraynext_4_s1\: LUT4
generic map (
  INIT => X"007F"
)
port map (
  F => \fifo_inst_Big.wgraynext_4\,
  I0 => \fifo_inst_Big.wgraynext_2_5\,
  I1 => \fifo_inst_Big.wgraynext_4_5\,
  I2 => \fifo_inst_Big.wgraynext_0\,
  I3 => \fifo_inst/Big.wbin\(8));
\fifo_inst/Big.wgraynext_5_s1\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Big.wgraynext_5\,
  I0 => \fifo_inst_Big.wgraynext_0\,
  I1 => \fifo_inst_Big.wgraynext_2_5\,
  I2 => \fifo_inst_Big.wgraynext_4_5\,
  I3 => \fifo_inst/Big.wbin\(8));
\fifo_inst/Big.wgraynext_7_s1\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Big.wgraynext_7\,
  I0 => \fifo_inst_Big.wgraynext_0\,
  I1 => \fifo_inst_Big.wgraynext_2_5\,
  I2 => \fifo_inst_Big.wgraynext_7_5\,
  I3 => \fifo_inst/Big.wbin\(6));
\fifo_inst/Big.wgraynext_8_s1\: LUT3
generic map (
  INIT => X"07"
)
port map (
  F => \fifo_inst_Big.wgraynext_8\,
  I0 => \fifo_inst/Big.wbin\(11),
  I1 => \fifo_inst_Big.wgraynext_7\,
  I2 => \fifo_inst/Big.wbin\(12));
\fifo_inst/wfull_val_s1\: LUT4
generic map (
  INIT => X"0100"
)
port map (
  F => fifo_inst_wfull_val_4,
  I0 => fifo_inst_wfull_val_8,
  I1 => fifo_inst_wfull_val_9,
  I2 => fifo_inst_wfull_val_10,
  I3 => fifo_inst_wfull_val_11);
\fifo_inst/wfull_val_s2\: LUT4
generic map (
  INIT => X"9009"
)
port map (
  F => fifo_inst_wfull_val_5,
  I0 => \fifo_inst/Big.wgraynext\(5),
  I1 => \fifo_inst/Big.wq2_rptr\(5),
  I2 => \fifo_inst/Big.wgraynext\(6),
  I3 => \fifo_inst/Big.wq2_rptr\(6));
\fifo_inst/wfull_val_s3\: LUT2
generic map (
  INIT => X"9"
)
port map (
  F => fifo_inst_wfull_val_6,
  I0 => \fifo_inst/Big.wbin_num_next\(13),
  I1 => \fifo_inst/Big.wq2_rptr\(9));
\fifo_inst/wfull_val_s4\: LUT4
generic map (
  INIT => X"2882"
)
port map (
  F => fifo_inst_wfull_val_7,
  I0 => fifo_inst_wfull_val_12,
  I1 => \fifo_inst_Big.wgraynext_8\,
  I2 => \fifo_inst/Big.wq2_rptr\(8),
  I3 => \fifo_inst/Big.wptr\(9));
\fifo_inst/arempty_val_s1\: LUT3
generic map (
  INIT => X"B0"
)
port map (
  F => fifo_inst_arempty_val_4,
  I0 => \fifo_inst/rcnt_sub\(2),
  I1 => fifo_inst_arempty_val_6,
  I2 => \fifo_inst/rcnt_sub\(4));
\fifo_inst/arempty_val_s2\: LUT3
generic map (
  INIT => X"01"
)
port map (
  F => fifo_inst_arempty_val_5,
  I0 => \fifo_inst/rcnt_sub\(7),
  I1 => \fifo_inst/rcnt_sub\(8),
  I2 => \fifo_inst/rcnt_sub\(9));
\fifo_inst/rbin_num_next_2_s4\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => fifo_inst_rbin_num_next_2,
  I0 => NN,
  I1 => RdEn,
  I2 => \fifo_inst/rbin_num\(0),
  I3 => \fifo_inst/rbin_num\(1));
\fifo_inst/rbin_num_next_5_s4\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => fifo_inst_rbin_num_next_5,
  I0 => fifo_inst_rbin_num_next_2,
  I1 => \fifo_inst/rbin_num\(2),
  I2 => \fifo_inst/rbin_num\(3),
  I3 => \fifo_inst/rbin_num\(4));
\fifo_inst/rbin_num_next_6_s4\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => fifo_inst_rbin_num_next_6,
  I0 => fifo_inst_rbin_num_next_5,
  I1 => \fifo_inst/rbin_num\(5));
\fifo_inst/Big.wgraynext_2_s2\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Big.wgraynext_2_5\,
  I0 => \fifo_inst/Big.wbin\(2),
  I1 => \fifo_inst/Big.wbin\(3),
  I2 => \fifo_inst/Big.wbin\(4),
  I3 => \fifo_inst/Big.wbin\(5));
\fifo_inst/Big.wgraynext_4_s2\: LUT2
generic map (
  INIT => X"8"
)
port map (
  F => \fifo_inst_Big.wgraynext_4_5\,
  I0 => \fifo_inst/Big.wbin\(6),
  I1 => \fifo_inst/Big.wbin\(7));
\fifo_inst/Big.wgraynext_7_s2\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Big.wgraynext_7_5\,
  I0 => \fifo_inst/Big.wbin\(7),
  I1 => \fifo_inst/Big.wbin\(8),
  I2 => \fifo_inst/Big.wbin\(9),
  I3 => \fifo_inst/Big.wbin\(10));
\fifo_inst/wfull_val_s5\: LUT3
generic map (
  INIT => X"69"
)
port map (
  F => fifo_inst_wfull_val_8,
  I0 => \fifo_inst_Big.wgraynext_3\,
  I1 => \fifo_inst/Big.wq2_rptr\(3),
  I2 => \fifo_inst/Big.wbin\(8));
\fifo_inst/wfull_val_s6\: LUT4
generic map (
  INIT => X"E11E"
)
port map (
  F => fifo_inst_wfull_val_9,
  I0 => \fifo_inst_Big.wgraynext_2\,
  I1 => \fifo_inst/Big.wbin\(6),
  I2 => \fifo_inst/Big.wq2_rptr\(2),
  I3 => \fifo_inst/Big.wbin\(7));
\fifo_inst/wfull_val_s7\: LUT3
generic map (
  INIT => X"69"
)
port map (
  F => fifo_inst_wfull_val_10,
  I0 => \fifo_inst_Big.wgraynext_4\,
  I1 => \fifo_inst/Big.wq2_rptr\(4),
  I2 => \fifo_inst/Big.wbin\(9));
\fifo_inst/wfull_val_s8\: LUT4
generic map (
  INIT => X"6006"
)
port map (
  F => fifo_inst_wfull_val_11,
  I0 => \fifo_inst_Big.wgraynext_1\,
  I1 => fifo_inst_wfull_val_13,
  I2 => \fifo_inst/Big.wgraynext\(0),
  I3 => \fifo_inst/Big.wq2_rptr\(0));
\fifo_inst/wfull_val_s9\: LUT4
generic map (
  INIT => X"1EE1"
)
port map (
  F => fifo_inst_wfull_val_12,
  I0 => \fifo_inst_Big.wgraynext_7\,
  I1 => \fifo_inst/Big.wbin\(11),
  I2 => \fifo_inst/Big.wq2_rptr\(7),
  I3 => \fifo_inst/Big.wbin\(12));
\fifo_inst/arempty_val_s3\: LUT4
generic map (
  INIT => X"0100"
)
port map (
  F => fifo_inst_arempty_val_6,
  I0 => \fifo_inst/rcnt_sub\(0),
  I1 => \fifo_inst/rcnt_sub\(1),
  I2 => \fifo_inst/rcnt_sub\(3),
  I3 => RdEn);
\fifo_inst/wfull_val_s10\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => fifo_inst_wfull_val_13,
  I0 => \fifo_inst/Big.wq2_rptr\(1),
  I1 => \fifo_inst/Big.wbin\(6));
\fifo_inst/Big.wcount_r_7_s1\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Big.wcount_r\(7),
  I0 => \fifo_inst/Big.rq2_wptr\(9),
  I1 => \fifo_inst/Big.rq2_wptr\(8),
  I2 => \fifo_inst/Big.rq2_wptr\(7));
\fifo_inst/Big.wgraynext_8_s2\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Big.wgraynext\(8),
  I0 => \fifo_inst/Big.wbin\(11),
  I1 => \fifo_inst_Big.wgraynext_7\,
  I2 => \fifo_inst/Big.wbin\(12),
  I3 => \fifo_inst/Big.wptr\(9));
\fifo_inst/Big.wbin_num_next_4_s4\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/Big.wbin_num_next\(4),
  I0 => \fifo_inst_Big.wgraynext_0\,
  I1 => \fifo_inst/Big.wbin\(2),
  I2 => \fifo_inst/Big.wbin\(3),
  I3 => \fifo_inst/Big.wbin\(4));
\fifo_inst/Big.rgraynext_2_s1\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Big.rgraynext\(2),
  I0 => fifo_inst_rbin_num_next_2,
  I1 => \fifo_inst/rbin_num\(2),
  I2 => \fifo_inst/rbin_num_next\(3));
\fifo_inst/Big.rgraynext_1_s1\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Big.rgraynext\(1),
  I0 => \fifo_inst/rbin_num_next\(1),
  I1 => fifo_inst_rbin_num_next_2,
  I2 => \fifo_inst/rbin_num\(2));
\fifo_inst/Big.rgraynext_3_s1\: LUT4
generic map (
  INIT => X"8778"
)
port map (
  F => \fifo_inst/Big.rgraynext\(3),
  I0 => fifo_inst_rbin_num_next_2,
  I1 => \fifo_inst/rbin_num\(2),
  I2 => \fifo_inst/rbin_num\(3),
  I3 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/Big.rgraynext_5_s1\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Big.rgraynext\(5),
  I0 => \fifo_inst/rbin_num_next\(6),
  I1 => fifo_inst_rbin_num_next_5,
  I2 => \fifo_inst/rbin_num\(5));
\fifo_inst/Big.rgraynext_4_s1\: LUT3
generic map (
  INIT => X"96"
)
port map (
  F => \fifo_inst/Big.rgraynext\(4),
  I0 => fifo_inst_rbin_num_next_5,
  I1 => \fifo_inst/rbin_num\(5),
  I2 => \fifo_inst/rbin_num_next\(4));
\fifo_inst/rbin_num_next_7_s4\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/rbin_num_next\(7),
  I0 => fifo_inst_rbin_num_next_5,
  I1 => \fifo_inst/rbin_num\(5),
  I2 => \fifo_inst/rbin_num\(6),
  I3 => \fifo_inst/rbin_num\(7));
\fifo_inst/rbin_num_next_6_s5\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/rbin_num_next\(6),
  I0 => fifo_inst_rbin_num_next_5,
  I1 => \fifo_inst/rbin_num\(5),
  I2 => \fifo_inst/rbin_num\(6));
\fifo_inst/Big.wbin_num_next_7_s6\: LUT4
generic map (
  INIT => X"8000"
)
port map (
  F => \fifo_inst_Big.wbin_num_next_7\,
  I0 => \fifo_inst_Big.wgraynext_0\,
  I1 => \fifo_inst_Big.wgraynext_2_5\,
  I2 => \fifo_inst/Big.wbin\(6),
  I3 => \fifo_inst/Big.wbin\(7));
\fifo_inst/Big.wbin_num_next_6_s4\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/Big.wbin_num_next\(6),
  I0 => \fifo_inst_Big.wgraynext_0\,
  I1 => \fifo_inst_Big.wgraynext_2_5\,
  I2 => \fifo_inst/Big.wbin\(6));
\fifo_inst/Big.wbin_num_next_5_s4\: LUT3
generic map (
  INIT => X"15"
)
port map (
  F => \fifo_inst/Big.wbin_num_next\(5),
  I0 => \fifo_inst_Big.wgraynext_1\,
  I1 => \fifo_inst_Big.wgraynext_0\,
  I2 => \fifo_inst_Big.wgraynext_2_5\);
\fifo_inst/Big.wgraynext_2_s3\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Big.wgraynext\(2),
  I0 => \fifo_inst_Big.wgraynext_0\,
  I1 => \fifo_inst_Big.wgraynext_2_5\,
  I2 => \fifo_inst/Big.wbin\(6),
  I3 => \fifo_inst/Big.wbin\(7));
\fifo_inst/Big.wbin_num_next_1_s4\: LUT4
generic map (
  INIT => X"BF40"
)
port map (
  F => \fifo_inst/Big.wbin_num_next\(1),
  I0 => NN_0,
  I1 => WrEn,
  I2 => \fifo_inst/Big.wbin\(0),
  I3 => \fifo_inst/Big.wbin\(1));
\fifo_inst/Big.wbin_num_next_0_s4\: LUT3
generic map (
  INIT => X"B4"
)
port map (
  F => \fifo_inst_Big.wbin_num_next_0\,
  I0 => NN_0,
  I1 => WrEn,
  I2 => \fifo_inst/Big.wbin\(0));
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
\fifo_inst/Big.wcount_r_6_s1\: LUT4
generic map (
  INIT => X"6996"
)
port map (
  F => \fifo_inst/Big.wcount_r\(6),
  I0 => \fifo_inst/Big.rq2_wptr\(9),
  I1 => \fifo_inst/Big.rq2_wptr\(8),
  I2 => \fifo_inst/Big.rq2_wptr\(7),
  I3 => \fifo_inst/Big.rq2_wptr\(6));
\fifo_inst/Big.rgraynext_0_s1\: LUT4
generic map (
  INIT => X"4BB4"
)
port map (
  F => \fifo_inst/Big.rgraynext\(0),
  I0 => NN,
  I1 => RdEn,
  I2 => \fifo_inst/rbin_num\(0),
  I3 => \fifo_inst/rbin_num_next\(1));
\fifo_inst/rempty_val_s2\: LUT4
generic map (
  INIT => X"1441"
)
port map (
  F => fifo_inst_rempty_val,
  I0 => fifo_inst_n1193_3,
  I1 => \fifo_inst/Big.rq2_wptr\(9),
  I2 => \fifo_inst_Big.rgraynext_8\,
  I3 => \fifo_inst/rbin_num\(9));
\fifo_inst/Big.rgraynext_6_s1\: LUT4
generic map (
  INIT => X"8778"
)
port map (
  F => \fifo_inst/Big.rgraynext\(6),
  I0 => fifo_inst_rbin_num_next_5,
  I1 => \fifo_inst/rbin_num\(5),
  I2 => \fifo_inst/rbin_num\(6),
  I3 => \fifo_inst/rbin_num_next\(7));
\fifo_inst/n4_s2\: INV
port map (
  O => fifo_inst_n4,
  I => RdClk);
\fifo_inst/n9_s2\: INV
port map (
  O => fifo_inst_n9,
  I => WrClk);
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
