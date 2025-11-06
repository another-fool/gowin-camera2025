//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.9 (64-bit)
//Part Number: GW5AST-LV138FPG676AC1/I0
//Device: GW5AST-138B
//Device Version: B
//Created Time: Sun Nov  2 21:12:36 2025

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    Gowin_PLL_B your_instance_name(
        .lock(lock_o), //output lock
        .clkout0(clkout0_o), //output clkout0
        .clkout1(clkout1_o), //output clkout1
        .clkin(clkin_i), //input clkin
        .reset(reset_i) //input reset
    );

//--------Copy end-------------------
