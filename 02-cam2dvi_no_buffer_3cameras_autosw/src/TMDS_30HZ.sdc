//Copyright (C)2014-2024 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.9.02 
//Created Time: 2024-04-24 12:57:14
create_clock -name clk -period 20 -waveform {0 18.518} [get_ports {clk}] -add
create_generated_clock -name mem_clk -source [get_ports {clk}] -master_clock clk -divide_by 1 -multiply_by 8 [get_nets {memory_clk}] 
create_generated_clock -name video_clk -source [get_ports {clk}] -master_clock clk -divide_by 400 -multiply_by 297 [get_nets {video_clk}]
create_generated_clock -name clk_x1 -source [get_ports {clk}] -master_clock clk -divide_by 1 -multiply_by 2 [get_pins {u_ddr3/gw3_top/u_ddr_phy_top/fclkdiv/CLKOUT}]

create_generated_clock -name cmos0_vsync -source [get_ports {clk}] -master_clock clk -divide_by 50 -multiply_by 1 -duty_cycle 50 [get_ports {cmos0_vsync}]
#create_generated_clock -name cmos1_vsync -source [get_ports {clk}] -master_clock clk -divide_by 50 -multiply_by 1 -duty_cycle 50 [get_ports {cmos1_vsync}]
#create_generated_clock -name cmos2_vsync -source [get_ports {clk}] -master_clock clk -divide_by 50 -multiply_by 1 -duty_cycle 50 [get_ports {cmos2_vsync}]
create_generated_clock -name cmos0_pclk -source [get_ports {clk}] -master_clock clk -divide_by 1 -multiply_by 2 -duty_cycle 50 [get_ports {cmos0_pclk}]
#create_generated_clock -name cmos1_pclk -source [get_ports {clk}] -master_clock clk -divide_by 1 -multiply_by 2 -duty_cycle 50 [get_ports {cmos1_pclk}]
#create_generated_clock -name cmos2_pclk -source [get_ports {clk}] -master_clock clk -divide_by 1 -multiply_by 2 -duty_cycle 50 [get_ports {cmos2_pclk}]



set_clock_groups -asynchronous -group [get_clocks {video_clk}] -group [get_clocks {clk_x1}] -group [get_clocks {mem_clk}] -group [get_clocks {cmos0_pclk}]  
#set_clock_groups -asynchronous -group [get_clocks {video_clk}] -group [get_clocks {clk_x1}] -group [get_clocks {mem_clk}] -group [get_clocks {cmos0_pclk}] -group [get_clocks {cmos1_pclk}] -group [get_clocks {cmos2_pclk}]
report_timing -hold -from_clock [get_clocks {clk*}] -to_clock [get_clocks {clk*}] -max_paths 25 -max_common_paths 1
report_timing -setup -from_clock [get_clocks {clk*}] -to_clock [get_clocks {clk*}] -max_paths 25 -max_common_paths 1
