//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.9
//Part Number: GW5AST-LV138FPG676AC1/I0
//Device: GW5AST-138
//Device Version: B
//Created Time: Mon Nov  3 23:09:53 2025

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	MJPEG_Encoder_Top your_instance_name(
		.clk(clk_i), //input clk
		.rstn(rstn_i), //input rstn
		.DE(DE_i), //input DE
		.data_in(data_in_i), //input [23:0] data_in
		.img_out(img_out_o), //output [7:0] img_out
		.img_valid(img_valid_o), //output img_valid
		.img_done(img_done_o) //output img_done
	);

//--------Copy end-------------------
