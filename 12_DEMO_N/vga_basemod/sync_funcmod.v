module sync_funcmod 
(
    input CLOCK, RESET,
	 output VGA_HSYNC, VGA_VSYNC,
	 output [10:0]qC1,
	 output [9:0]qC2
);
    reg [10:0]C1;
	 reg [9:0]C2;
	 reg rH,rV;
	 
	 always @ ( posedge CLOCK or negedge RESET )
	     if( !RESET )
		      begin
				    C1 <= 11'd0;
					 C2 <= 10'd0;
					 rH <= 1'b1;
					 rV <= 1'b1;
				end
		  else 
		      begin
				    
					 if( C1 == 1056 ) rH <= 1'b0; 
				     else if( C1 == 128  ) rH <= 1'b1;
				     //else if( C1 == 0 ) rH <= 1'b0;
					 
					 if( C2 == 628 ) rV <= 1'b0;
					 else if( C2 == 4  ) rV <= 1'b1;
					 //else if( C2 == 0 ) rV <= 1'b0;
					 
					 if( C2 == 628 ) C2 <= 10'd1;
					 else if( C1 == 1056 ) C2 <= C2 + 1'b1;
					 
				    if( C1 == 1056 ) C1 <= 11'd1;
					 else C1 <= C1 + 1'b1;
					 
				end
				
    /********************************/
    
	 assign qC1 = C1;
	 assign qC2 = C2;
	 
	 assign VGA_HSYNC = rH;
	 assign VGA_VSYNC = rV;
	 
	 /********************************/

endmodule
