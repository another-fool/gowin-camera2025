//Copyright (C)2014-2025 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.12 (64-bit)
//Part Number: GW5AST-LV138FPG676AES
//Device: GW5AST-138
//Device Version: B
//Created Time: Thu Oct 30 12:45:37 2025

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    Gowin_SDPB your_instance_name(
        .dout(dout), //output [15:0] dout
        .clka(clka), //input clka
        .cea(cea), //input cea
        .clkb(clkb), //input clkb
        .ceb(ceb), //input ceb
        .oce(oce), //input oce
        .reset(reset), //input reset
        .ada(ada), //input [16:0] ada
        .din(din), //input [15:0] din
        .adb(adb) //input [16:0] adb
    );

//--------Copy end-------------------
