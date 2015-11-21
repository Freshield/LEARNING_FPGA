/*
	模式可选，
	MODE_0 : 灰度移动斜条
	MODE_1 : 竖直彩条
	MODE_2 : 水平彩条
	MODE_3 : 棋盘格
	MODE_4 : 蓝屏
	MODE_5 : 黑屏
*/
`timescale	1ps/1ps

module	hd_source(
											input				wire[7 : 0]				MODE_SELECT_8B,
											input				wire							sys_clk,
											//timing	parameter
											input				wire[15: 0]				i_h_fp_16b,
											input				wire[15: 0]				i_h_sync_16b,
											input				wire[15: 0]				i_h_bp_16b,
											input				wire[15: 0]				i_h_active_16b,
											input				wire[15: 0]				i_h_total_16b,
											       
											input				wire[15: 0]				i_v_fp_16b,
											input				wire[15: 0]				i_v_sync_16b,
											input				wire[15: 0]				i_v_bp_16b,
											input				wire[15: 0]				i_v_active_16b,
											input				wire[15: 0]				i_v_total_16b,
											//output
											output			wire							o_source_clk,
											output			reg								o_h_sync,
											output			reg								o_v_sync,
											output			reg								o_de,
											
											output			reg [7 : 0]				o_rgb_r_8b,
											output			reg [7 : 0]				o_rgb_g_8b,
											output			reg [7 : 0]				o_rgb_b_8b
											);
/****************************************************************************/
//color parameter
parameter						WHITE_R_8B 		= 8'hff;
parameter						WHITE_G_8B 		= 8'hff;
parameter						WHITE_B_8B 		= 8'hff;
                                	
parameter						YELLOW_R_8B 	= 8'hff;
parameter						YELLOW_G_8B 	= 8'hff;
parameter						YELLOW_B_8B 	= 8'h00;
                                	
parameter						CYAN_R_8B 		= 8'h00;
parameter						CYAN_G_8B 		= 8'hff;
parameter						CYAN_B_8B 		= 8'hff;
                                	
parameter						GREEN_R_8B 		= 8'h00;
parameter						GREEN_G_8B 		= 8'hff;
parameter						GREEN_B_8B 		= 8'h00;

parameter						MAGENTA_R_8B 	= 8'hff;
parameter						MAGENTA_G_8B 	= 8'h00;
parameter						MAGENTA_B_8B 	= 8'hff;

parameter						RED_R_8B 			= 8'hff;
parameter						RED_G_8B 			= 8'h00;
parameter						RED_B_8B 			= 8'h00;

parameter						BLUE_R_8B 		= 8'h00;
parameter						BLUE_G_8B 		= 8'h00;
parameter						BLUE_B_8B 		= 8'hff;

parameter						BLACK_R_8B 		= 8'h00;
parameter						BLACK_G_8B 		= 8'h00;
parameter						BLACK_B_8B 		= 8'h00;
/****************************************************************************/
//timing
reg	[15: 0]		h_count_16b; 
reg	[15: 0]		v_count_16b;


always @ (posedge	sys_clk)
	begin
		if(h_count_16b == i_h_total_16b - 16'd1)
			h_count_16b <= 16'd0;
		else
			h_count_16b <= h_count_16b + 16'd1;
	end
	
always @ (posedge	sys_clk)
	begin
		if(h_count_16b == i_h_total_16b - 16'd1)
			begin
				if(v_count_16b == i_v_total_16b - 16'd1)
					v_count_16b <= 16'd0;
				else
					v_count_16b <= v_count_16b + 16'd1;
			end
		else
			v_count_16b <= v_count_16b;
	end
/****************************************************************************/
//!!!!h_sync已经延迟一级，LV1	
reg				h_sync_delay;
reg				v_sync_delay;
reg				de_delay;

always @ (posedge	sys_clk)
	begin
		h_sync_delay 	<=	h_sync;
		v_sync_delay	<=	v_sync;
		de_delay			<=	de;
	end
/****************************************************************************/
//LV1
reg 					h_sync;
reg 					h_active;

reg 					v_sync;
reg 					v_active;

wire					de;
always @ (posedge	sys_clk)
begin
	h_sync 		<= (h_count_16b < i_h_fp_16b + i_h_sync_16b	) && (h_count_16b >= i_h_fp_16b															);
	h_active	<= (h_count_16b < i_h_total_16b							) && (h_count_16b >= i_h_fp_16b + i_h_sync_16b + i_h_bp_16b	); 
	          
	v_sync 		<= (v_count_16b < i_v_fp_16b + i_v_sync_16b	) && (v_count_16b >= i_v_fp_16b															);
	v_active	<= (v_count_16b < i_v_total_16b							) && (v_count_16b >= i_v_fp_16b + i_v_sync_16b + i_v_bp_16b	); 
end
assign	de				= h_active && v_active;
/****************************************************************************/
//LV1
reg [15: 0]			h_count_active_16b;
reg [15: 0]			v_count_active_16b;

reg [15: 0]			h_blank_16b;
reg [15: 0]			v_blank_16b;	
always @ (posedge	sys_clk)
begin
	h_blank_16b <= i_h_fp_16b + i_h_sync_16b + i_h_bp_16b;
	v_blank_16b <= i_v_fp_16b + i_v_sync_16b + i_v_bp_16b;
end	
always @ (posedge	sys_clk)
begin
	h_count_active_16b <= h_count_16b - h_blank_16b;
	v_count_active_16b <= v_count_16b - v_blank_16b;
end

/****************************************************************************/
//LV2
reg	[15: 0]			frm_offset_16b;
reg [15: 0]			h_count_offset_16b;
	
always @ (posedge	sys_clk)
	begin
		if(v_sync && ~v_sync_delay)
			frm_offset_16b <= frm_offset_16b + 16'd1;
		else
			frm_offset_16b <= frm_offset_16b;
	end

always @ (posedge	sys_clk)
	h_count_offset_16b <= h_count_active_16b + frm_offset_16b;
/****************************************************************************/
//mode_0
//LV3
reg [7 : 0]		mode_0_rgb_r_8b;
reg [7 : 0]		mode_0_rgb_g_8b;
reg [7 : 0]		mode_0_rgb_b_8b;

reg						mode_0_h_sync;
reg						mode_0_v_sync;
reg						mode_0_de;	
always @ (posedge	sys_clk)
	begin
		mode_0_rgb_r_8b <= h_count_offset_16b[7 : 0] + v_count_16b[7 : 0];
		mode_0_rgb_g_8b <= h_count_offset_16b[7 : 0] + v_count_16b[7 : 0];
		mode_0_rgb_b_8b <= h_count_offset_16b[7 : 0] + v_count_16b[7 : 0];
	end

always @ (posedge	sys_clk)
begin
	mode_0_h_sync <= h_sync_delay;
	mode_0_v_sync <= v_sync_delay;
	mode_0_de			<= de_delay;
end
/****************************************************************************/
//mode_1
reg [7 : 0]			mode_1_rgb_r_8b;
reg [7 : 0]			mode_1_rgb_g_8b;
reg [7 : 0]			mode_1_rgb_b_8b;
	
	
wire[12: 0]			h_interval_13b;
reg [15: 0]			h_bound_1st_16b;
reg [15: 0]			h_bound_2nd_16b;
reg [15: 0]			h_bound_3rd_16b;
reg [15: 0]			h_bound_4th_16b;
reg [15: 0]			h_bound_5th_16b;
reg [15: 0]			h_bound_6th_16b;
reg [15: 0]			h_bound_7th_16b;
reg [15: 0]			h_bound_8th_16b;
reg [7 : 0]			h_flag_8b;
		
assign	h_interval_13b 	= i_h_active_16b[15: 3];

always @ (posedge	sys_clk)
begin	
	h_bound_1st_16b <= h_interval_13b * 3'd1;
	h_bound_2nd_16b <= h_interval_13b * 3'd2;
	h_bound_3rd_16b <= h_interval_13b * 3'd3;
	h_bound_4th_16b <= h_interval_13b * 3'd4;
	h_bound_5th_16b <= h_interval_13b * 3'd5;
	h_bound_6th_16b <= h_interval_13b * 3'd6;
	h_bound_7th_16b <= h_interval_13b * 3'd7;
	h_bound_8th_16b <= i_h_active_16b;
end

//LV2
always @ (posedge	sys_clk)
begin
	h_flag_8b[0] <= (h_count_active_16b < h_bound_1st_16b);
	h_flag_8b[1] <= (h_count_active_16b < h_bound_2nd_16b) && (h_count_active_16b >= h_bound_1st_16b);
	h_flag_8b[2] <= (h_count_active_16b < h_bound_3rd_16b) && (h_count_active_16b >= h_bound_2nd_16b);
	h_flag_8b[3] <= (h_count_active_16b < h_bound_4th_16b) && (h_count_active_16b >= h_bound_3rd_16b);
	h_flag_8b[4] <= (h_count_active_16b < h_bound_5th_16b) && (h_count_active_16b >= h_bound_4th_16b);
	h_flag_8b[5] <= (h_count_active_16b < h_bound_6th_16b) && (h_count_active_16b >= h_bound_5th_16b);
	h_flag_8b[6] <= (h_count_active_16b < h_bound_7th_16b) && (h_count_active_16b >= h_bound_6th_16b);
	h_flag_8b[7] <= (h_count_active_16b < h_bound_8th_16b) && (h_count_active_16b >= h_bound_7th_16b);
end
//LV3
always @ (posedge	sys_clk)
	begin
		case(h_flag_8b)
			8'h01:
				begin
					mode_1_rgb_r_8b <= WHITE_R_8B;
					mode_1_rgb_g_8b <= WHITE_G_8B;
					mode_1_rgb_b_8b <= WHITE_B_8B;
				end
			8'h02:
				begin
					mode_1_rgb_r_8b <= YELLOW_R_8B;
					mode_1_rgb_g_8b <= YELLOW_G_8B;
					mode_1_rgb_b_8b <= YELLOW_B_8B;
				end
			8'h04:
				begin
					mode_1_rgb_r_8b <= CYAN_R_8B;
					mode_1_rgb_g_8b <= CYAN_G_8B;
					mode_1_rgb_b_8b <= CYAN_B_8B;
				end
			8'h08:
				begin
					mode_1_rgb_r_8b <= GREEN_R_8B;
					mode_1_rgb_g_8b <= GREEN_G_8B;
					mode_1_rgb_b_8b <= GREEN_B_8B;
				end
			8'h10:
				begin
					mode_1_rgb_r_8b <= MAGENTA_R_8B;
					mode_1_rgb_g_8b <= MAGENTA_G_8B;
					mode_1_rgb_b_8b <= MAGENTA_B_8B;
				end
			8'h20:
				begin
					mode_1_rgb_r_8b <= RED_R_8B;
					mode_1_rgb_g_8b <= RED_G_8B;
					mode_1_rgb_b_8b <= RED_B_8B;
				end
			8'h40:
				begin
					mode_1_rgb_r_8b <= BLUE_R_8B;
					mode_1_rgb_g_8b <= BLUE_G_8B;
					mode_1_rgb_b_8b <= BLUE_B_8B;
				end
			8'h80:
				begin
					mode_1_rgb_r_8b <= BLACK_R_8B;
					mode_1_rgb_g_8b <= BLACK_G_8B;
					mode_1_rgb_b_8b <= BLACK_B_8B;
				end
			default:
				begin
					mode_1_rgb_r_8b <= BLACK_R_8B;
					mode_1_rgb_g_8b <= BLACK_G_8B;
					mode_1_rgb_b_8b <= BLACK_B_8B;
				end
		endcase
	end

reg				mode_1_h_sync;
reg				mode_1_v_sync;
reg				mode_1_de;
always @ (posedge	sys_clk)
begin
	mode_1_h_sync <= h_sync_delay;
	mode_1_v_sync <= v_sync_delay;
	mode_1_de			<= de_delay;
end
/****************************************************************************/
//mode_2
reg [7 : 0]			mode_2_rgb_r_8b;
reg [7 : 0]			mode_2_rgb_g_8b;
reg [7 : 0]			mode_2_rgb_b_8b;
	
	
wire[12: 0]			v_interval_13b;
reg [15: 0]			v_bound_1st_16b;
reg [15: 0]			v_bound_2nd_16b;
reg [15: 0]			v_bound_3rd_16b;
reg [15: 0]			v_bound_4th_16b;
reg [15: 0]			v_bound_5th_16b;
reg [15: 0]			v_bound_6th_16b;
reg [15: 0]			v_bound_7th_16b;
reg [15: 0]			v_bound_8th_16b;
reg [7 : 0]			v_flag_8b;
		
assign	v_interval_13b 	= i_v_active_16b[15: 3];

always @ (posedge	sys_clk)
begin	      
	v_bound_1st_16b <= v_interval_13b * 3'd1;
	v_bound_2nd_16b <= v_interval_13b * 3'd2;
	v_bound_3rd_16b <= v_interval_13b * 3'd3;
	v_bound_4th_16b <= v_interval_13b * 3'd4;
	v_bound_5th_16b <= v_interval_13b * 3'd5;
	v_bound_6th_16b <= v_interval_13b * 3'd6;
	v_bound_7th_16b <= v_interval_13b * 3'd7;
	v_bound_8th_16b <= i_v_active_16b;
end

//LV2
always @ (posedge	sys_clk)
begin
	v_flag_8b[0] <= (v_count_active_16b < v_bound_1st_16b);
	v_flag_8b[1] <= (v_count_active_16b < v_bound_2nd_16b) && (v_count_active_16b >= v_bound_1st_16b);
	v_flag_8b[2] <= (v_count_active_16b < v_bound_3rd_16b) && (v_count_active_16b >= v_bound_2nd_16b);
	v_flag_8b[3] <= (v_count_active_16b < v_bound_4th_16b) && (v_count_active_16b >= v_bound_3rd_16b);
	v_flag_8b[4] <= (v_count_active_16b < v_bound_5th_16b) && (v_count_active_16b >= v_bound_4th_16b);
	v_flag_8b[5] <= (v_count_active_16b < v_bound_6th_16b) && (v_count_active_16b >= v_bound_5th_16b);
	v_flag_8b[6] <= (v_count_active_16b < v_bound_7th_16b) && (v_count_active_16b >= v_bound_6th_16b);
	v_flag_8b[7] <= (v_count_active_16b < v_bound_8th_16b) && (v_count_active_16b >= v_bound_7th_16b);
end
//LV3
always @ (posedge	sys_clk)
	begin
		case(v_flag_8b)
			8'h01:
				begin
					mode_2_rgb_r_8b <= BLUE_R_8B;
					mode_2_rgb_g_8b <= BLUE_G_8B;
					mode_2_rgb_b_8b <= BLUE_B_8B;
				end
			8'h02:
				begin
					mode_2_rgb_r_8b <= YELLOW_R_8B;
					mode_2_rgb_g_8b <= YELLOW_G_8B;
					mode_2_rgb_b_8b <= YELLOW_B_8B;
				end
			8'h04:
				begin
					mode_2_rgb_r_8b <= CYAN_R_8B;
					mode_2_rgb_g_8b <= CYAN_G_8B;
					mode_2_rgb_b_8b <= CYAN_B_8B;
				end
			8'h08:
				begin
					mode_2_rgb_r_8b <= GREEN_R_8B;
					mode_2_rgb_g_8b <= GREEN_G_8B;
					mode_2_rgb_b_8b <= GREEN_B_8B;
				end
			8'h10:
				begin
					mode_2_rgb_r_8b <= MAGENTA_R_8B;
					mode_2_rgb_g_8b <= MAGENTA_G_8B;
					mode_2_rgb_b_8b <= MAGENTA_B_8B;
				end
			8'h20:
				begin
					mode_2_rgb_r_8b <= RED_R_8B;
					mode_2_rgb_g_8b <= RED_G_8B;
					mode_2_rgb_b_8b <= RED_B_8B;
				end
			8'h40:
				begin
					mode_2_rgb_r_8b <= BLUE_R_8B;
					mode_2_rgb_g_8b <= BLUE_G_8B;
					mode_2_rgb_b_8b <= BLUE_B_8B;
				end
			8'h80:
				begin
					mode_2_rgb_r_8b <= BLACK_R_8B;
					mode_2_rgb_g_8b <= BLACK_G_8B;
					mode_2_rgb_b_8b <= BLACK_B_8B;
				end
			default:
				begin
					mode_2_rgb_r_8b <= BLACK_R_8B;
					mode_2_rgb_g_8b <= BLACK_G_8B;
					mode_2_rgb_b_8b <= BLACK_B_8B;
				end
		endcase
	end

reg			mode_2_h_sync;
reg			mode_2_v_sync;
reg			mode_2_de;	
always @ (posedge	sys_clk)
begin
	mode_2_h_sync <= h_sync_delay;
	mode_2_v_sync <= v_sync_delay;
	mode_2_de			<= de_delay;
end
/****************************************************************************/
//mode_3
reg [7 : 0]		mode_3_rgb_r_8b;
reg [7 : 0]		mode_3_rgb_g_8b;
reg [7 : 0]		mode_3_rgb_b_8b;	
//LV2
reg						color_judge;
always @ (posedge	sys_clk)
begin
	color_judge <= h_count_active_16b[6] + v_count_active_16b[6];
end
//LV3
always @ (posedge	sys_clk)
	begin
		mode_3_rgb_r_8b <= color_judge ? 8'hff : 8'h00;
		mode_3_rgb_g_8b <= color_judge ? 8'hff : 8'h00;
		mode_3_rgb_b_8b <= color_judge ? 8'hff : 8'h00;
	end

reg			mode_3_h_sync;
reg			mode_3_v_sync;
reg			mode_3_de;	
always @ (posedge	sys_clk)
begin
	mode_3_h_sync <= h_sync_delay;
	mode_3_v_sync <= v_sync_delay;
	mode_3_de			<= de_delay;
end
/****************************************************************************/
//mode_4
reg [7 : 0]		mode_4_rgb_r_8b;
reg [7 : 0]		mode_4_rgb_g_8b;
reg [7 : 0]		mode_4_rgb_b_8b;	
always @ (posedge	sys_clk)
	begin
		mode_4_rgb_r_8b <= 8'h00;
		mode_4_rgb_g_8b <= 8'h00;
		mode_4_rgb_b_8b <= 8'hff;
	end

reg			mode_4_h_sync;
reg			mode_4_v_sync;
reg			mode_4_de;	
always @ (posedge	sys_clk)
begin
	mode_4_h_sync <= h_sync;
	mode_4_v_sync <= v_sync;
	mode_4_de			<= de;
end
/****************************************************************************/
//mode_5
reg [7 : 0]		mode_5_rgb_r_8b;
reg [7 : 0]		mode_5_rgb_g_8b;
reg [7 : 0]		mode_5_rgb_b_8b;	
always @ (posedge	sys_clk)
	begin
		mode_5_rgb_r_8b <= 8'h00;
		mode_5_rgb_g_8b <= 8'h00;
		mode_5_rgb_b_8b <= 8'h00;
	end

reg			mode_5_h_sync;
reg			mode_5_v_sync;
reg			mode_5_de;	
always @ (posedge	sys_clk)
begin
	mode_5_h_sync <= h_sync;
	mode_5_v_sync <= v_sync;
	mode_5_de			<= de;
end
/****************************************************************************/
always @ (posedge	sys_clk)
begin
	case(MODE_SELECT_8B)
		8'd0:
			begin
				o_rgb_r_8b <= mode_0_rgb_r_8b;
				o_rgb_g_8b <= mode_0_rgb_g_8b;
				o_rgb_b_8b <= mode_0_rgb_b_8b;
				o_h_sync	 <= mode_0_h_sync;
				o_v_sync	 <= mode_0_v_sync;
				o_de			 <= mode_0_de;
			end
		8'd1:
			begin
				o_rgb_r_8b <= mode_1_rgb_r_8b;
				o_rgb_g_8b <= mode_1_rgb_g_8b;
				o_rgb_b_8b <= mode_1_rgb_b_8b;
				o_h_sync	 <= mode_1_h_sync;
				o_v_sync	 <= mode_1_v_sync;
				o_de			 <= mode_1_de;
			end
		8'd2:
			begin
				o_rgb_r_8b <= mode_2_rgb_r_8b;
				o_rgb_g_8b <= mode_2_rgb_g_8b;
				o_rgb_b_8b <= mode_2_rgb_b_8b;
				o_h_sync	 <= mode_2_h_sync;
				o_v_sync	 <= mode_2_v_sync;
				o_de			 <= mode_2_de;
			end	
		8'd3:
			begin
				o_rgb_r_8b <= mode_3_rgb_r_8b;
				o_rgb_g_8b <= mode_3_rgb_g_8b;
				o_rgb_b_8b <= mode_3_rgb_b_8b;
				o_h_sync	 <= mode_3_h_sync;
				o_v_sync	 <= mode_3_v_sync;
				o_de			 <= mode_3_de;
			end
		8'd4:
			begin
				o_rgb_r_8b <= mode_4_rgb_r_8b;
				o_rgb_g_8b <= mode_4_rgb_g_8b;
				o_rgb_b_8b <= mode_4_rgb_b_8b;
				o_h_sync	 <= mode_4_h_sync;
				o_v_sync	 <= mode_4_v_sync;
				o_de			 <= mode_4_de;
			end
		8'd5:
			begin
				o_rgb_r_8b <= mode_5_rgb_r_8b;
				o_rgb_g_8b <= mode_5_rgb_g_8b;
				o_rgb_b_8b <= mode_5_rgb_b_8b;
				o_h_sync	 <= mode_5_h_sync;
				o_v_sync	 <= mode_5_v_sync;
				o_de			 <= mode_5_de;
			end
		default:
			begin
				o_rgb_r_8b <= mode_0_rgb_r_8b;
				o_rgb_g_8b <= mode_0_rgb_g_8b;
				o_rgb_b_8b <= mode_0_rgb_b_8b;
				o_h_sync	 <= mode_0_h_sync;
				o_v_sync	 <= mode_0_v_sync;
				o_de			 <= mode_0_de;
			end
	endcase
end

assign	o_source_clk = sys_clk;	

endmodule




