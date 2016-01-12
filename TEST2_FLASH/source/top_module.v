module top_module
(
    CLK,RSTn,FLASH_LED,FLOW_LED
);

//**********************************************
//IO

input CLK;
input RSTn;
output FLASH_LED;
output[2:0]FLOW_LED;

//**********************************************
//include module

wire wFLASH_LED;

flash_module U1
(
    .CLK(CLK),
	.RSTn(RSTn),
	.LED_Out(wFLASH_LED)
);

wire [2:0]wFLOW_LED;

flow_module U2
(
    .CLK(CLK),
	.RSTn(RSTn),
	.LED_Out(wFLOW_LED)
);

//**********************************************

assign FLASH_LED = wFLASH_LED;
assign FLOW_LED = wFLOW_LED;

//**********************************************

endmodule











