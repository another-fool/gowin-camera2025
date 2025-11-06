//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.9 (64-bit)
//Part Number: GW5AST-LV138FPG676AC1/I0
//Device: GW5AST-138B
//Device Version: B
//Created Time: Sat Nov  1 22:00:45 2025

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    Gowin_PLL_F your_instance_name(
        .lock(lock_o), //output lock
        .clkout0(clkout0_o), //output clkout0
        .clkin(clkin_i), //input clkin
        .reset(reset_i) //input reset
    );

//--------Copy end-------------------
