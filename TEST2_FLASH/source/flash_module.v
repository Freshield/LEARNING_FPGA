module flash_module
(
	CLK,RSTn,LED_Out
);

//**********************************************
input CLK;
input RSTn;
output LED_Out;

//**********************************************
//50Mhz,50MS = 25 000 000 - 1 = 24 999 999
parameter T50MS = 25'd24_999_999;

reg [24:0]Count1;
//**********************************************
always@(posedge CLK or negedge RSTn)

if(!RSTn)
    Count1<=25'd0;
else if(Count1 == T50MS)
    Count1<=25'd0;
else
    Count1 = Count1 + 1'b1;

//**********************************************

reg rLED_Out;

always@(posedge CLK or negedge RSTn)
if(!RSTn)
    rLED_Out<=1'b0;
else if(Count1 == T50MS)
    rLED_Out<=~rLED_Out;

//**********************************************

assign LED_Out = rLED_Out;

//**********************************************
endmodule



















