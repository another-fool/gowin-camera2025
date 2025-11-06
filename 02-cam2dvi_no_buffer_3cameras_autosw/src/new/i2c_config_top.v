module i2c_config_top  (
	input                  clk,
	input                  rst_n,
//sensor 0 	
	inout                  cmos_scl,       //cmos i2c clock
	inout                  cmos_sda,       //cmos i2c data
    output [2:0]	       i2c_sel
);
    
    assign i2c_sel = 'b101;


    wire[15:0]                      cmos_16bit_data;
    wire                            cmos_16bit_clk;
    wire[15:0] 						write_data;

    wire[9:0]                       lut_index;
    wire[31:0]                      lut_data;
    wire i2c_done;
    wire i2c_err;



    reg [31:0] cmos_reset_delay_cnt;
    reg cmos_reset;
    reg cmos_start_config;
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            cmos_reset_delay_cnt <= 0;
            cmos_reset <= 0;
            cmos_start_config <= 0;
        end else begin
            if(cmos_reset_delay_cnt == 32'd3_000_000)
            begin
                cmos_reset_delay_cnt <= cmos_reset_delay_cnt;
                cmos_reset <= 1'b1;
                cmos_start_config <= 1'b1;
            end else if(cmos_reset_delay_cnt == 32'd100_000)
            begin
                cmos_reset_delay_cnt <= cmos_reset_delay_cnt + 1;
                cmos_reset <= 1'b1;
                cmos_start_config <= 1'b0;
            end else begin
                cmos_reset_delay_cnt <= cmos_reset_delay_cnt + 1;
                cmos_reset <= cmos_reset;
                cmos_start_config <= cmos_start_config;
            end
            
        end
    end
     lut_ov5640_rgb565 #(
    	.HActive(12'd1280),
    	.VActive(12'd720),
    	.HTotal(13'd1892),
    	.VTotal(13'd740),
        .USE_4vs3_frame("false")
    )lut_ov5640_rgb565_m0(
    	.lut_index(lut_index),
    	.lut_data(lut_data)
    );

    i2c_config i2c_config_m0(
    	.rst                        (~cmos_start_config       ),
    	.clk                        (clk                      ),
    	.clk_div_cnt                (16'd500                  ),
    	.i2c_addr_2byte             (1'b1                     ),
    	.lut_index                  (lut_index                ),
    	.lut_dev_addr               (lut_data[31:24]          ),
    	.lut_reg_addr               (lut_data[23:8]           ),
    	.lut_reg_data               (lut_data[7:0]            ),
    	.error                      (i2c_err                  ),
    	.done                       (i2c_done                 ),
    	.i2c_scl                    (cmos_scl                 ),
    	.i2c_sda                    (cmos_sda                 )
    );


endmodule