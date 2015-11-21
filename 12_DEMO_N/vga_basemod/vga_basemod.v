module vga_basemod
(
    input CLOCK_40M, RESET,
	 output VGA_HSYNC, VGA_VSYNC,
	 output [15:0]VGAD
);
	 
	 wire [10:0]qC1;
	 wire [9:0]qC2;
	 wire HSYNC, VSYNC;
	 
	 sync_funcmod U2
	 (
	   .CLOCK( CLOCK_40M ), 
		.RESET( RESET ),
		.VGA_HSYNC( HSYNC ), 
		.VGA_VSYNC( VSYNC ),
	   .qC1( qC1 ),
	   .qC2( qC2 )
	 );			 
	 
	 wire [7:0]ROM_Data;
	 
	 vga_savemod U3
	 (
	    .address ( ROM_Addr ),
	    .clock ( CLOCK_40M ),
	    .q ( ROM_Data )
    );
    
	 wire [13:0]ROM_Addr;
	 wire [7:0]VGA256;
	 
	 vga_ctrlmod U4
	 (
	     .CLOCK( CLOCK_40M ),
		  .RESET( RESET ),
	     .qC1( qC1 ),
	     .qC2( qC2 ),
	     .VGA256( VGA256 ),
	     .ROM_Data( ROM_Data ),
	     .ROM_Addr( ROM_Addr )
	 );
	 
	 reg [1:0]rBP1,rBP2,rBP3;
	 
    always @ ( posedge CLOCK_40M or negedge RESET )
	     if( !RESET )
		      { rBP3, rBP2, rBP1 } <= 6'b11_11_11;
		  else
		      begin
				    rBP1 <= { HSYNC, VSYNC };
				    rBP2 <= rBP1;
					 rBP3 <= rBP2;
				end	
	 
	 /**************************/
	 
	 assign { VGA_HSYNC, VGA_VSYNC } = rBP3;
	 assign VGAD = { VGA256[7:5], 2'b00, VGA256[4:2], 3'b000, VGA256[1:0], 3'b000 }; 
	 
endmodule