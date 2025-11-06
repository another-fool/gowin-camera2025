// /******************************************************************************
// Copyright 2022 GOWIN SEMICONDUCTOR CORPORATION

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// The Software is used with products manufacturered by GOWIN Semconductor only
// unless otherwise authorized by GOWIN Semiconductor.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
// ******************************************************************************/
/* `include "uvc_defs.v"

module frame
(
    input              CLK_I     ,       //clock
    input              RST_I     ,       //reset
    input              FIFO_AFULL_I,     //
    input              FIFO_EMPTY_I,     //
    input              SOF_I     ,       //

    //input  [7:0]       data_i,

    output [7:0]       DATA_O    ,       //
    output             DVAL_O            //
);

localparam HERADER_LEN = 12;
localparam WIDTH  = `WIDTH ;//480;
localparam HEIGHT = `HEIGHT;//20;//320;
localparam PAYLOAD_SIZE = `PAYLOAD_SIZE;
localparam FRAME_SIZE = WIDTH * HEIGHT * 2;

//==============================================================
//======Header Generate
reg sof_d0;
reg sof_d1;
wire sof_rise;
always @(posedge CLK_I or posedge RST_I) begin
    if (RST_I) begin
        sof_d0 <= 1'b0;
        sof_d1 <= 1'b0;
    end
    else begin
        sof_d0 <= SOF_I;
        sof_d1 <= sof_d0;
    end
end
assign sof_rise = (sof_d0)&(~sof_d1);


reg [10:0] sofCounts;
reg [10:0] sofCounts_reg;
reg [3:0] sof_1ms;
always @(posedge CLK_I or posedge RST_I) begin
    if (RST_I) begin
        sofCounts <= 11'd0;
        sof_1ms <= 4'd0;
    end
    else begin
        if (sof_rise) begin
            if (sof_1ms >= 4'd7) begin
                sof_1ms <= 4'd0;
            end
            else begin
                sof_1ms <= sof_1ms + 4'd1;
            end
        end
        if ((sof_rise)&&(sof_1ms == 3'd7)) begin
            sofCounts <= sofCounts + 'd1;
        end
    end
end

reg [31:0] pts;
reg [31:0] pts_reg;
always @(posedge CLK_I or posedge RST_I) begin
    if (RST_I) begin
        pts <= 32'd0;
    end
    else begin
        pts <= pts + 32'd1;
    end
end

//==============================================================
//======Frame Start and Over
reg [7:0] frame;
reg [15:0] byte_cnt;
reg [11:0] color_cnt;
reg [31:0] expectPixels;
reg frame_valid;
assign DATA_O = dout;
assign DVAL_O = dval;
reg [7:0] moving_pixel;
reg [7:0] dout;
reg       dval;
always @(posedge CLK_I or posedge RST_I) begin
    if (RST_I) begin
        frame_valid <= 1'b0;
        dout <= 8'd0;
        dval <= 1'd0;
        byte_cnt <= 16'd0;
        color_cnt <= 12'd0;
        expectPixels <= 32'd0;
        frame <= 8'h0C;
        pts_reg <= 32'd0;
        sofCounts_reg <= 11'd0;
        moving_pixel <= 8'd0;
    end
    else begin
        if (frame_valid) begin
            if(FIFO_AFULL_I == 1'b0) begin
                dval <= 1'b1;
                if (byte_cnt >= PAYLOAD_SIZE - 1'b1) begin
                    byte_cnt <= 16'd0;
                end
                else begin
                    byte_cnt <= byte_cnt + 16'd1;
                end
                case (byte_cnt)
                    16'd0 : dout <= HERADER_LEN;
                    16'd1 : 
                        if (expectPixels >= FRAME_SIZE - PAYLOAD_SIZE - 12 - 1'b1) begin
                            dout <= frame|8'h02;
                        end
                        else begin
                            dout <= frame;
                        end
                    16'd2 : dout <= pts_reg[7:0];     //8'hAE;//8'h11;//
                    16'd3 : dout <= pts_reg[15:8];    //8'h03;//8'h54;//
                    16'd4 : dout <= pts_reg[23:16];   //8'hB4;//8'h72;//
                    16'd5 : dout <= pts_reg[31:24];   //8'h32;//8'h9A;//
                    16'd6 : dout <= pts_reg[7:0];     //8'hAE;//8'h11;//
                    16'd7 : dout <= pts_reg[15:8];    //8'h03;//8'h54;//
                    16'd8 : dout <= pts_reg[23:16];   //8'hB4;//8'h72;//
                    16'd9 : dout <= pts_reg[31:24];   //8'h32;//8'h9A;//
                    16'd10 : dout <= sofCounts[7:0];            //8'h62;//
                    16'd11 : dout <= {5'd0,sofCounts[10:8]};    //8'h07;//
                    default : begin
                        if (color_cnt >= 12'd720 - 1) begin
                            color_cnt <= 12'd0;
                        end
                        else begin
                            color_cnt <= color_cnt + 4'd1;
                        end
                        if (expectPixels >= FRAME_SIZE - 1'b1) begin
                            frame_valid <= 1'b0;
                            expectPixels <= 32'd0;
                            frame <= {frame[7:1],frame[0]^1'b1};
                        end
                        else begin
                            expectPixels <= expectPixels + 1'b1;
                        end
                        //if (expectPixels <= 480 - 1'b1) begin
                        //    dout <= 8'h1F;
                        //end
                        //else begin
                        //    dout <= 8'h1F;
                        //end
///*
                        //if (1) // best case
                        ////if (byte_cnt<1024) //worst case
                        ////if (byte_cnt<16) //The more consequitive ones there are the more times txready will go low causing the buffer to hold data
                        //   dout <= 8'hFF;
                        //else
                        //   dout <= 0;
                            //
                        //
                        if (color_cnt < 12'd213 - moving_pixel) begin //RED
                            case (byte_cnt[1:0])
                                2'd0 : dout <= 8'h20;
                                2'd1 : dout <= 8'h60;
                                2'd2 : dout <= 8'h20;
                                2'd3 : dout <= 8'hDC;
                            endcase
                        end
                        else if (color_cnt < 12'd426 - moving_pixel) begin //GREEN
                            case (byte_cnt[1:0])
                                2'd0 : dout <= 8'h00;//20;//
                                2'd1 : dout <= 8'h00;//60;//
                                2'd2 : dout <= 8'h00;//20;//
                                2'd3 : dout <= 8'h00;//DC;//
                            endcase
                        end
                        else if (color_cnt < 12'd639 - moving_pixel) begin //BLUE
                            case (byte_cnt[1:0])
                                2'd0 : dout <= 8'h10;//20;//
                                2'd1 : dout <= 8'hD0;//60;//
                                2'd2 : dout <= 8'h10;//20;//
                                2'd3 : dout <= 8'h70;//DC;//
                            endcase
                        end
                        else if (color_cnt < 12'd852 - moving_pixel) begin //RED
                            case (byte_cnt[1:0])
                                2'd0 : dout <= 8'h20;//20;//
                                2'd1 : dout <= 8'h60;//60;//
                                2'd2 : dout <= 8'h20;//20;//
                                2'd3 : dout <= 8'hDC;//DC;//
                            endcase
                        end
                        else if (color_cnt < 12'd1065 - moving_pixel) begin //GREEN
                            case (byte_cnt[1:0])
                                2'd0 : dout <= 8'h00;//20;//
                                2'd1 : dout <= 8'h00;//60;//
                                2'd2 : dout <= 8'h00;//20;//
                                2'd3 : dout <= 8'h00;//DC;//
                            endcase
                        end
                        else if (color_cnt < 12'd1280 - moving_pixel) begin //BLUE
                            case (byte_cnt[1:0])
                                2'd0 : dout <= 8'h10;//20;//
                                2'd1 : dout <= 8'hD0;//60;//
                                2'd2 : dout <= 8'h10;//20;//
                                2'd3 : dout <= 8'h70;//DC;//
                            endcase
                        end
                        else begin
                            case (byte_cnt[1:0])
                                2'd0 : dout <= 8'h20;
                                2'd1 : dout <= 8'h60;
                                2'd2 : dout <= 8'h20;
                                2'd3 : dout <= 8'hDC;
                            endcase
                        end
                        //
                    end
                endcase
            end
            else begin
                dval <= 1'b0;
            end
        end
        else if ((sof_cnt == 16'd0)&&(sof_rise)) begin
            if (FIFO_EMPTY_I) begin
                if (color_cnt >= 1280) begin
                    color_cnt <= 12'd4;
                end
                else if (color_cnt >= 1276) begin
                    color_cnt <= 12'd0;
                end
                else begin
                    color_cnt <= color_cnt + 12'd4;
                end
                frame_valid <= 1'b1;
                pts_reg <= pts;
                sofCounts_reg <= sofCounts;
            end
            byte_cnt <= 16'd0;
            //color_cnt <= 4'd0;
            expectPixels <= 32'd0;
            dout <= 8'd0;
            dval <= 1'd0;
        end
        else begin
            byte_cnt <= 16'd0;
            //color_cnt <= 4'd0;
            expectPixels <= 32'd0;
            dout <= 8'd0;
            dval <= 1'd0;
        end
    end
end
//==============================================================
//======microframe control frame rate
reg [15:0] sof_cnt;
always @(posedge CLK_I or posedge RST_I) begin
    if (RST_I) begin
        sof_cnt <= 16'd0;
    end
    else begin
        if (sof_rise) begin
            if (sof_cnt >= 103) begin
                sof_cnt <= 16'd0;
            end
            else begin
                sof_cnt <= sof_cnt + 16'd1;
            end
        end
    end
end



// //==============================================================
// //==============================================================
// //==============================================================
// //==============================================================
// //==============================================================
endmodule */

module frame
(
    input              CLK_I     ,       //clock
    input              RST_I     ,       //reset
    input              FIFO_AFULL_I,     //
    input              FIFO_EMPTY_I,     //
    input              SOF_I     ,       //UVC帧起始信号
    // 新增：8位摄像头接口信号（必须加，否则无法接收摄像头数据）
    input       [7:0]  CAM_DATA_I,       //8位摄像头数据流（如YUV分量/灰度数据）
    input              CAM_DVAL_I,       //摄像头数据有效（高电平=数据可用）
    input              CAM_SOF_I,        //摄像头帧起始（与UVC的SOF同步）
    // 原输出端口
    output [7:0]       DATA_O    ,       //
    output             DVAL_O            //
);
// 原localparam保留，仅需确认FRAME_SIZE与摄像头分辨率匹配
localparam HERADER_LEN = 12;
localparam WIDTH  = `WIDTH ;// 需与摄像头水平分辨率一致（如720）
localparam HEIGHT = `HEIGHT;// 需与摄像头垂直分辨率一致（如480）
localparam PAYLOAD_SIZE = `PAYLOAD_SIZE;
// 关键：8位摄像头的FRAME_SIZE计算（根据摄像头格式调整）
// - 若为单分量（如Y灰度）：FRAME_SIZE = WIDTH * HEIGHT
// - 若为YUV422（2字节/像素）：FRAME_SIZE = WIDTH * HEIGHT * 2
localparam FRAME_SIZE = WIDTH * HEIGHT; // 示例：8位单分量格式，需根据实际调整
//==============================================================
//======Header Generate（原逻辑完全保留，不修改）
reg sof_d0;
reg sof_d1;
wire sof_rise;
always @(posedge CLK_I or posedge RST_I) begin
    if (RST_I) begin
        sof_d0 <= 1'b0;
        sof_d1 <= 1'b0;
    end
    else begin
        sof_d0 <= SOF_I;
        sof_d1 <= sof_d0;
    end
end
assign sof_rise = (sof_d0)&(~sof_d1);
reg [10:0] sofCounts;
reg [10:0] sofCounts_reg;
reg [3:0] sof_1ms;
always @(posedge CLK_I or posedge RST_I) begin
    if (RST_I) begin
        sofCounts <= 11'd0;
        sof_1ms <= 4'd0;
    end
    else begin
        if (sof_rise) begin
            if (sof_1ms >= 4'd7) begin
                sof_1ms <= 4'd0;
            end
            else begin
                sof_1ms <= sof_1ms + 4'd1;
            end
        end
        if ((sof_rise)&&(sof_1ms == 3'd7)) begin
            sofCounts <= sofCounts + 'd1;
        end
    end
end
reg [31:0] pts;
reg [31:0] pts_reg;
always @(posedge CLK_I or posedge RST_I) begin
    if (RST_I) begin
        pts <= 32'd0;
    end
    else begin
        pts <= pts + 32'd1;
    end
end
//==============================================================
//======Frame Start and Over（原逻辑保留，仅修改frame_valid触发条件）
reg [7:0] frame;
reg [15:0] byte_cnt;
reg [11:0] color_cnt;
reg [31:0] expectPixels;
reg frame_valid;
assign DATA_O = dout;
assign DVAL_O = dval;
reg [7:0] moving_pixel; // 彩条相关变量，无需删除（不影响）
reg [7:0] dout;
reg       dval;
always @(posedge CLK_I or posedge RST_I) begin
    if (RST_I) begin
        frame_valid <= 1'b0;
        dout <= 8'd0;
        dval <= 1'd0;
        byte_cnt <= 16'd0;
        color_cnt <= 12'd0;
        expectPixels <= 32'd0;
        frame <= 8'h0C;
        pts_reg <= 32'd0;
        sofCounts_reg <= 11'd0;
        moving_pixel <= 8'd0;
    end
    else begin
        if (frame_valid) begin
            if(FIFO_AFULL_I == 1'b0) begin
                dval <= 1'b1; // FIFO不满时，数据有效信号置1
                // byte_cnt计数逻辑（原逻辑保留，控制帧头/数据切换）
                if (byte_cnt >= PAYLOAD_SIZE - 1'b1) begin
                    byte_cnt <= 16'd0;
                end
                else begin
                    byte_cnt <= byte_cnt + 16'd1;
                end
                // 核心：case块（仅修改default分支，前12个byte_cnt完全保留）
                case (byte_cnt)
                    16'd0 : dout <= HERADER_LEN;
                    16'd1 : 
                        if (expectPixels >= FRAME_SIZE - PAYLOAD_SIZE - 12 - 1'b1) begin
                            dout <= frame|8'h02;
                        end
                        else begin
                            dout <= frame;
                        end
                    16'd2 : dout <= pts_reg[7:0];     //8'hAE;//8'h11;//
                    16'd3 : dout <= pts_reg[15:8];    //8'h03;//8'h54;//
                    16'd4 : dout <= pts_reg[23:16];   //8'hB4;//8'h72;//
                    16'd5 : dout <= pts_reg[31:24];   //8'h32;//8'h9A;//
                    16'd6 : dout <= pts_reg[7:0];     //8'hAE;//8'h11;//
                    16'd7 : dout <= pts_reg[15:8];    //8'h03;//8'h54;//
                    16'd8 : dout <= pts_reg[23:16];   //8'hB4;//8'h72;//
                    16'd9 : dout <= pts_reg[31:24];   //8'h32;//8'h9A;//
                    16'd10 : dout <= sofCounts[7:0];            //8'h62;//
                    16'd11 : dout <= {5'd0,sofCounts[10:8]};    //8'h07;//
                    // ###################################################
                    // 关键修改：default分支（删除彩条逻辑，接入摄像头数据）
                    // ###################################################
                    default : begin
                        // 1. 保留原color_cnt计数（适配摄像头水平分辨率，避免错位）
                        if (color_cnt >= WIDTH - 1) begin // 用WIDTH替代固定值720，适配分辨率
                            color_cnt <= 12'd0;
                        end
                        else begin
                            color_cnt <= color_cnt + 4'd1;
                        end
                        // 2. 保留原帧结束控制（确保一帧数据完整，不截断）
                        if (expectPixels >= FRAME_SIZE - 1'b1) begin
                            frame_valid <= 1'b0;        // 帧结束，关闭数据有效
                            expectPixels <= 32'd0;      // 重置像素计数器
                            frame <= {frame[7:1],frame[0]^1'b1}; // 原帧标识翻转（保留）
                        end
                        else begin
                            expectPixels <= expectPixels + 1'b1; // 每输出1字节，计数+1
                        end
                        // 3. 删除原彩条的if-else分支（所有判断color_cnt范围的代码）
                        // 4. 新增：接入8位摄像头数据（仅在摄像头数据有效时输出）
                        if (CAM_DVAL_I) begin // 过滤摄像头无效数据（如行空白、帧空白）
                            dout <= CAM_DATA_I; // 直接输出摄像头8位数据
                        end
                        else begin
                            dout <= 8'd0; // 无效时输出0，避免画面杂色（可根据需求调整）
                        end
                    end
                    // ###################################################
                    // default分支修改结束
                    // ###################################################
                endcase
            end
            else begin
                dval <= 1'b0; // FIFO满时，暂停输出数据
            end
        end
        // ###################################################
        // 新增：frame_valid触发条件加入CAM_SOF_I（同步UVC与摄像头帧起始）
        // ###################################################
        else if ((sof_cnt == 16'd0)&&(sof_rise)&&(CAM_SOF_I)) begin // 加CAM_SOF_I同步
            if (FIFO_EMPTY_I) begin
                // 原color_cnt初始化逻辑保留（适配摄像头分辨率）
                if (color_cnt >= WIDTH) begin // 用WIDTH替代1280，适配分辨率
                    color_cnt <= 12'd4;
                end
                else if (color_cnt >= WIDTH - 4) begin // 用WIDTH-4替代1276
                    color_cnt <= 12'd0;
                end
                else begin
                    color_cnt <= color_cnt + 12'd4;
                end
                frame_valid <= 1'b1; // 仅当UVC和摄像头帧起始同时到来时，启动帧输出
                pts_reg <= pts;
                sofCounts_reg <= sofCounts;
            end
            byte_cnt <= 16'd0;
            expectPixels <= 32'd0;
            dout <= 8'd0;
            dval <= 1'd0;
        end
        else begin
            // 非帧有效期间，重置所有计数器
            byte_cnt <= 16'd0;
            expectPixels <= 32'd0;
            dout <= 8'd0;
            dval <= 1'd0;
        end
    end
end
//==============================================================
//======microframe control frame rate（原逻辑完全保留，不修改）
reg [15:0] sof_cnt;
always @(posedge CLK_I or posedge RST_I) begin
    if (RST_I) begin
        sof_cnt <= 16'd0;
    end
    else begin
        if (sof_rise) begin
            if (sof_cnt >= 103) begin
                sof_cnt <= 16'd0;
            end
            else begin
                sof_cnt <= sof_cnt + 16'd1;
            end
        end
    end
end
//==============================================================
endmodule


