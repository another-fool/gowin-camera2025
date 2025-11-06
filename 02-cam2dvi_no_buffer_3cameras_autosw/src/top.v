module top #(
    //Note: USE DDR3 with 400MHz: enable file [DDR3MI_400M.v] & [gowin_pll_400M.v], 
    //                            disable [DDR3MI_300M.v] & [gowin_pll_300M.v] (USE 300M Reverse operation)

    //Note: HDMI Output use 1280x720: Set USE_1280 = "true", Enable [TMDS_PLL_xx.v], [TMDS_xxHZ.sdc],
    //                                Disable Other [TMDS_PLL_*.v], xx is frame rate

    //Note: HDMI Output use 800x600: Set USE_1280 = "false", Enable [TMDS_PLL_800_600_60.v], [TMDS_800_600_60.sdc],
    //                               Disable Other [TMDS_PLL_*.v] 
    parameter USE_TPG = "false",
    parameter USE_1280 = "true"   
)(
	input                  clk,
	input                  rst_n,
	output [4:0]           state_led,
//uart 
    input                  rxp ,
//sensor 0 	
	inout                  cmos_scl,       //cmos i2c clock
	inout                  cmos_sda,       //cmos i2c data
    output [2:0]	       i2c_sel,

	input                  cmos0_vsync,     //cmos vsync
	input                  cmos0_href,      //cmos hsync refrence,data valid
	input                  cmos0_pclk,      //cmos pxiel clock 
	input  [7:0]           cmos0_db,        //cmos data 
    
	input                  cmos1_vsync,     //cmos vsync
	input                  cmos1_href,      //cmos hsync refrence,data valid
	input                  cmos1_pclk,      //cmos pxiel clock 
	input  [7:0]           cmos1_db,        //cmos data 	    
    
	input                  cmos2_vsync,     //cmos vsync
	input                  cmos2_href,      //cmos hsync refrence,data valid
	input                  cmos2_pclk,      //cmos pxiel clock 
	input  [7:0]           cmos2_db,        //cmos data 
//DDR
	output [16-1:0]        ddr_addr,       //ROW_WIDTH=16
	output [3-1:0]         ddr_bank,       //BANK_WIDTH=3
	output                 ddr_cs,
	output                 ddr_ras,
	output                 ddr_cas,
	output                 ddr_we,
	output                 ddr_ck,
	output                 ddr_ck_n,
	output                 ddr_cke,
	output                 ddr_odt,
	output                 ddr_reset_n,
	output [4-1:0]         ddr_dm,         //DM_WIDTH=4
	inout  [32-1:0]        ddr_dq,         //DQ_WIDTH=32
	inout  [4-1:0]         ddr_dqs,        //DQS_WIDTH=4
	inout  [4-1:0]         ddr_dqs_n,      //DQS_WIDTH=4
  
//HDMI
    output                 tmds_clk_n_0,
    output                 tmds_clk_p_0,
    output [2:0]           tmds_d_n_0, //{r,g,b}
    output [2:0]           tmds_d_p_0,

    output                 tmds_clk_n_1,
    output                 tmds_clk_p_1,
    output [2:0]           tmds_d_n_1, //{r,g,b}
    output [2:0]           tmds_d_p_1
);     

//memory interface
    wire                   memory_clk         ;
    wire                   dma_clk         	  ;
    wire                   DDR_pll_lock       ;
    wire                   cmd_ready          ;
    wire[2:0]              cmd                ;
    wire                   cmd_en             ;
    wire[28:0]             addr               ;
    wire                   wr_data_rdy        ;
    wire                   wr_data_en         ; 
    wire                   wr_data_end        ; 
    wire[255:0]            wr_data            ; 
    wire[31:0]             wr_data_mask       ; 
    wire                   rd_data_valid      ; 
    wire                   rd_data_end        ; 
    wire[255:0]            rd_data            ; 
    wire                   init_calib_complete; 
    wire                   TMDS_DDR_pll_lock  ; 
    wire                   video_clk          ; 
    //------------------- 
    wire                   syn_off0_re        ; 
    wire                   syn_off0_vs        ;
    wire                   syn_off0_hs        ;
    wire                   off0_syn_de        ;
    wire [15:0]            off0_syn_data      ;  
 

    //状态指示灯 
    wire check;
    wire i2c_done;
    reg [4:0] cmos0_vs_cnt;
    always@(posedge cmos0_vsync) 
        cmos0_vs_cnt <= cmos0_vs_cnt + 1; 
    assign state_led[4] = ~check ;
    assign state_led[3] = ~cmos0_vs_cnt[4];
    assign state_led[2] = ~TMDS_DDR_pll_lock;
    assign state_led[1] = ~DDR_pll_lock; 
    assign state_led[0] = ~init_calib_complete; //DDR3初始化指示灯
    // assign state_led[0] = check_led; //DDR3初始化指示灯 
 
    Gowin_PLL Gowin_PLL_m0(
    	.clkin                     (clk                         ),
    	.clkout0                   (cmos_clk 	              	),
        .clkout1                   (aux_clk 	              	),
        .clkout2                   (memory_clk 	              	),
    	.lock 					   (DDR_pll_lock 				),
        .reset                     (1'b0                        ),
        .enclk0                    (1'b1                        ), //input enclk0
        .enclk1                    (1'b1                        ), //input enclk1
        .enclk2                    (pll_stop                    ) //input enclk2
	);
 
mux_top  mux_top_inst (
    .clk(clk)                    ,
    .rst_n(rst_n)                , 
    .check(check)                , 
    .rxp(rxp)            ,
    .dma_clk(dma_clk)            ,
    .video_clk      (video_clk    ),
    .syn_off0_vs    (syn_off0_vs  ),
    .syn_off0_hs    (syn_off0_hs  ),
    .out_de         (out_de       ),
    .off0_syn_data  (off0_syn_data),
    .off0_syn_de    (off0_syn_de  ),

    .cmos_scl       (cmos_scl     ),
    .cmos_sda       (cmos_sda     ),
    .i2c_sel        (i2c_sel      ),
    .cmos0_vsync    (cmos0_vsync  ),
    .cmos0_href     (cmos0_href   ),
    .cmos0_pclk     (cmos0_pclk   ),
    .cmos0_db       (cmos0_db     ),
    .cmos1_vsync    (cmos1_vsync  ),
    .cmos1_href     (cmos1_href   ),
    .cmos1_pclk     (cmos1_pclk   ),
    .cmos1_db       (cmos1_db     ),
    .cmos2_vsync    (cmos2_vsync  ),
    .cmos2_href     (cmos2_href   ),
    .cmos2_pclk     (cmos2_pclk   ),
    .cmos2_db       (cmos2_db     ),    
    .init_complete(init_calib_complete),
    .cmd_ready(cmd_ready)        ,
    .cmd(cmd)                    ,
    .cmd_en(cmd_en)              ,
    .addr(addr)                  ,
    .wr_data_rdy(wr_data_rdy)    ,
    .wr_data(wr_data)            ,
    .wr_data_en(wr_data_en)      ,
    .wr_data_end(wr_data_end)    ,
    .wr_data_mask(wr_data_mask)  ,
    .rd_data(rd_data)            ,
    .rd_data_valid(rd_data_valid),
    .rd_data_end(rd_data_end) );
   DDR3MI u_ddr3
    (
        .clk                (clk                ),
        .memory_clk         (memory_clk         ),
        .pll_stop           (pll_stop           ),
        .pll_lock           (DDR_pll_lock       ),
        .rst_n              (rst_n              ), 
        .cmd_ready          (cmd_ready          ),
        .cmd                (cmd                ),
        .cmd_en             (cmd_en             ),
        .addr               (addr               ),
        .wr_data_rdy        (wr_data_rdy        ),
        .wr_data            (wr_data            ),
        .wr_data_en         (wr_data_en         ),
        .wr_data_end        (wr_data_end        ),
        .wr_data_mask       (wr_data_mask       ),
        .rd_data            (rd_data            ),
        .rd_data_valid      (rd_data_valid      ),
        .rd_data_end        (rd_data_end        ),
        .sr_req             (1'b0               ),
        .ref_req            (1'b0               ),
        .sr_ack             (                   ),
        .ref_ack            (                   ),
        .init_calib_complete(init_calib_complete),
        .clk_out            (dma_clk            ),
        .burst              (1'b1               ),
        // mem interface
        .ddr_rst            (                 ),
        .O_ddr_addr         (ddr_addr         ),
        .O_ddr_ba           (ddr_bank         ),
        .O_ddr_cs_n         (ddr_cs           ),
        .O_ddr_ras_n        (ddr_ras          ),
        .O_ddr_cas_n        (ddr_cas          ),
        .O_ddr_we_n         (ddr_we           ),
        .O_ddr_clk          (ddr_ck           ),
        .O_ddr_clk_n        (ddr_ck_n         ),
        .O_ddr_cke          (ddr_cke          ),
        .O_ddr_odt          (ddr_odt          ),
        .O_ddr_reset_n      (ddr_reset_n      ),
        .O_ddr_dqm          (ddr_dm           ),
        .IO_ddr_dq          (ddr_dq           ),
        .IO_ddr_dqs         (ddr_dqs          ),
        .IO_ddr_dqs_n       (ddr_dqs_n        )
    );
    //==============================================================================
    //TMDS TX(HDMI4)
 
 
    wire out_de;
    wire [9:0] lcd_x,lcd_y;
    wire        tp0_vs_in  ;
    wire        tp0_hs_in  ;
    wire        tp0_de_in ;
    wire [ 7:0] tp0_data_r;
    wire [ 7:0] tp0_data_g;
    wire [ 7:0] tp0_data_b;
    
    wire [4:0] lcd_r,lcd_b;
    wire [5:0] lcd_g;
    wire lcd_vs,lcd_de,lcd_hs,lcd_dclk;

    reg  [1:0]  Pout_hs_dn;
    reg  [1:0]  Pout_vs_dn;
    reg  [1:0]  Pout_de_dn;
    wire serial_clk;
    wire hdmi4_rst_n;

    TMDS_PLL u_tmds_pll(
        .clkin     (clk              ),     //input clk 
        .clkout0   (serial_clk       ),     //output clk x5ni
        .clkout1   (video_clk        ),     //output clk x1
        .lock      (TMDS_DDR_pll_lock)      //output lock
        );
 
    vga_timing #(
        .H_ACTIVE(16'd1280), 
        .H_FP(16'd110),
        .H_SYNC(16'd40),
        .H_BP(16'd220),
        .V_ACTIVE(16'd720),
        .V_FP(16'd5),
        .V_SYNC(16'd5),
        .V_BP(16'd20), 	
        .HS_POL(1'b1),   	
        .VS_POL(1'b1)
    ) vga_timing_m0(
        .clk (video_clk),
        .rst (~rst_n),

        .active_x(lcd_x),
        .active_y(lcd_y),

        .hs(syn_off0_hs),
        .vs(syn_off0_vs),
        .de(out_de) );
 

    always@(posedge video_clk or negedge rst_n)
    begin
        if(!rst_n)
            begin                          
                Pout_hs_dn  <= {2'b11};
                Pout_vs_dn  <= {2'b11}; 
                Pout_de_dn  <= {2'b00}; 
            end
        else 
            begin                          
                Pout_hs_dn  <= {Pout_hs_dn[0],syn_off0_hs};
                Pout_vs_dn  <= {Pout_vs_dn[0],syn_off0_vs}; 
                Pout_de_dn  <= {Pout_de_dn[0],out_de}; 
            end
    end

    // assign {lcd_r,lcd_g,lcd_b}    = off0_syn_de ? off0_syn_data[15:0] : 16'h0000;//{r,g,b}
    assign {lcd_r,lcd_g,lcd_b}    = off0_syn_de ? off0_syn_data  : 16'h0000;//{r,g,b}
    assign lcd_vs      			  = Pout_vs_dn[1];//syn_off0_vs;
    assign lcd_hs      			  = Pout_hs_dn[1];//syn_off0_hs;
    assign lcd_de      			  = Pout_de_dn[1];//off0_syn_de;
    assign lcd_dclk    			  = video_clk;//video_clk_phs;

    assign hdmi4_rst_n = rst_n & TMDS_DDR_pll_lock;


    wire dvi0_rgb_clk;
    wire dvi0_rgb_vs ;
    wire dvi0_rgb_hs ;
    wire dvi0_rgb_de ;
    wire [7:0] dvi0_rgb_r  ;
    wire [7:0] dvi0_rgb_g  ;
    wire [7:0] dvi0_rgb_b  ;

    wire dvi1_rgb_clk;
    wire dvi1_rgb_vs ;
    wire dvi1_rgb_hs ;
    wire dvi1_rgb_de ;
    wire [7:0] dvi1_rgb_r  ;
    wire [7:0] dvi1_rgb_g  ;
    wire [7:0] dvi1_rgb_b  ;


    assign dvi0_rgb_clk = lcd_dclk;
    assign dvi0_rgb_vs  = lcd_vs;
    assign dvi0_rgb_hs  = lcd_hs;
    assign dvi0_rgb_de  = lcd_de;
    assign dvi0_rgb_r   = {lcd_r,3'd0};
    assign dvi0_rgb_g   = {lcd_g,2'd0};
    assign dvi0_rgb_b   = {lcd_b,3'd0};

    assign dvi1_rgb_clk = lcd_dclk;
    assign dvi1_rgb_vs  = lcd_vs;
    assign dvi1_rgb_hs  = lcd_hs;
    assign dvi1_rgb_de  = lcd_de;
    assign dvi1_rgb_r   = {lcd_r,3'd0};
    assign dvi1_rgb_g   = {lcd_g,2'd0};
    assign dvi1_rgb_b   = {lcd_b,3'd0};
// end
// endgenerate

    DVI_TX_Top DVI_TX_Top_inst0
    (
        .I_rst_n       (hdmi4_rst_n   ),  //asynchronous reset, low active
        .I_serial_clk  (serial_clk    ),

        //CMOS
        .I_rgb_clk     (dvi0_rgb_clk),  //pixel clock
        .I_rgb_vs      (dvi0_rgb_vs ), 
        .I_rgb_hs      (dvi0_rgb_hs ),    
        .I_rgb_de      (dvi0_rgb_de ), 
        .I_rgb_r       (dvi0_rgb_r  ), 
        .I_rgb_g       (dvi0_rgb_g  ),  
        .I_rgb_b       (dvi0_rgb_b  ),  

        .O_tmds_clk_p  (tmds_clk_p_0  ),
        .O_tmds_clk_n  (tmds_clk_n_0  ),
        .O_tmds_data_p (tmds_d_p_0    ),  //{r,g,b}
        .O_tmds_data_n (tmds_d_n_0    )
    );


    DVI_TX_Top DVI_TX_Top_inst1
    (
        .I_rst_n       (hdmi4_rst_n   ),  //asynchronous reset, low active
        .I_serial_clk  (serial_clk    ),

        //CMOS
        .I_rgb_clk     (dvi1_rgb_clk),  //pixel clock
        .I_rgb_vs      (dvi1_rgb_vs ), 
        .I_rgb_hs      (dvi1_rgb_hs ),    
        .I_rgb_de      (dvi1_rgb_de ), 
        .I_rgb_r       (dvi1_rgb_r  ),  //tp0_data_r
        .I_rgb_g       (dvi1_rgb_g  ),  
        .I_rgb_b       (dvi1_rgb_b  ),  

        .O_tmds_clk_p  (tmds_clk_p_1  ),
        .O_tmds_clk_n  (tmds_clk_n_1  ),
        .O_tmds_data_p (tmds_d_p_1    ),  //{r,g,b}
        .O_tmds_data_n (tmds_d_n_1    )
    );


endmodule