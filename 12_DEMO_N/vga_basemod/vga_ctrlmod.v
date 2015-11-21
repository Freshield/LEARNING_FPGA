module vga_ctrlmod
(
    input CLOCK, RESET,
	 input [10:0]qC1,
	 input [9:0]qC2,
	 output [7:0]VGA256,
	 input [7:0]ROM_Data,
	 output [13:0]ROM_Addr
	 
);
    /**************************************/
	 
	 // Height , width, x-offset and y-offset
	 parameter _X = 8'd128, _Y = 8'd128, _XOFF = 10'd0, _YOFF = 10'd0; 
	 
	 /**************************************/
    
    reg [31:0]x,y;
	 reg [13:0]rAddr;
	 reg [7:0]rRGB;
	 
	 wire isX = (qC1 > 128 + 88 + _XOFF && qC1 <= 128 + 88 + _XOFF +_X);
	 wire isY = (qC2 > 4 + 23 + _YOFF && qC2 <= 4 + 23 + _YOFF + _Y);
	 wire isReady = isX & isY;

    always @ ( posedge CLOCK or negedge RESET )
	     if( !RESET )
		      begin
				    x <= 32'd0;
					 y <= 32'd0;
				    rAddr <= 14'd0;
				    rRGB <= 8'd0;
				end
			else
			   begin
				
				    // step 1 : compute data address and index-n
					 if( isReady )
					     begin 
						      x = qC1 - _XOFF - 128 - 88 - 1; 
						      y = qC2 - _YOFF - 4 - 23 - 1;
					         rAddr <= (y << 7) + x; 
					     end
					 else
					     rAddr <= 14'd0;
					 
					 // step 2 : reading data from rom
					 // but do-nothing
					 
					 // step 3 : assign RGB_Sig
					 rRGB <= isReady ? ROM_Data : 8'd0;
					 
				end
				
	/****************************/
	
	assign VGA256 = rRGB;
	assign ROM_Addr = rAddr;
	
	/*****************************/

endmodule
