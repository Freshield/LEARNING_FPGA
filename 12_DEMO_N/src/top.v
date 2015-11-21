//*************************************************************************\
//Copyright (c) 2013,  All rights reserved
//
//                   File Name  :  top.v
//                Project Name  :  
//                      Author  :  Meisq
//                       Email  :  msq@qq.com
//                      Device  :  
//                     Company  :  
//==========================================================================
//   Description:  
//
//   Called by  :   
//==========================================================================
//   Revision History:
//	Date		  By			Revision	Change Description
//--------------------------------------------------------------------------
//2013/12/30	     Meisq		    1.0			Original	
//*************************************************************************/
module top(
	//sys
	input clk,	
	input sys_key0,	
	//lcd
	output lcd_pwm,
	output lcd_mode,
	output lcd_lr,
	output lcd_ud,
	output lcd_out_clk,
	output lcd_out_hs,
	output lcd_out_vs,
	output lcd_out_de,
	output[5:0]  lcd_out_rgb_b,
	output[5:0]  lcd_out_rgb_g,
	output[5:0]  lcd_out_rgb_r
);
parameter H_ACTIVE = 16'd800;  
parameter H_FP = 16'd40;       
parameter H_SYNC = 16'd48;     
parameter H_BP = 16'd40;      
parameter V_ACTIVE = 16'd480;   
parameter V_FP 	= 16'd13;        
parameter V_SYNC  = 16'd3;      
parameter V_BP	= 16'd29;       
parameter H_TOTAL = H_ACTIVE + H_FP + H_SYNC + H_BP;
parameter V_TOTAL = V_ACTIVE + V_FP + V_SYNC + V_BP;
wire [7:0] rgb_r;
wire [7:0] rgb_g;
wire [7:0] rgb_b;
wire hs;
wire vs;
assign lcd_out_hs = ~hs;
assign lcd_out_vs = ~vs;
assign lcd_out_rgb_r = rgb_r[7:2];
assign lcd_out_rgb_g = rgb_g[7:2];
assign lcd_out_rgb_b = rgb_b[7:2];
assign lcd_mode = 1'b1;//DE Mode, Mode=鈥滺鈥HS floating and VS floating
assign lcd_lr = 1'b1;//Up to down
assign lcd_ud = 1'b1;//left to right
assign lcd_pwm = 1'b1;//ADJ adjust brightness to control Pin,Pulse duty the bigger the brighter
assign lcd_out_clk = clk;
wire rst_n;
reset reset_m0(
	.clk(clk),
	.rst_n(rst_n)
);

hd_source hd_source_m0(
	.MODE_SELECT_8B (8'd1),
	.sys_clk(clk),
	.i_h_fp_16b (H_FP),
	.i_h_sync_16b(H_SYNC),
	.i_h_bp_16b (H_BP),
	.i_h_active_16b (H_ACTIVE),
	.i_h_total_16b (H_TOTAL),	
	.i_v_fp_16b (V_FP),
	.i_v_sync_16b(V_SYNC),
	.i_v_bp_16b (V_BP),
	.i_v_active_16b (V_ACTIVE),
	.i_v_total_16b (V_TOTAL),
	.o_source_clk(),
	.o_h_sync(hs),
	.o_v_sync(vs),
	.o_de(lcd_out_de),
	.o_rgb_r_8b (rgb_r),
	.o_rgb_g_8b (rgb_g),
	.o_rgb_b_8b (rgb_b)
 );
 	 
 endmodule 