module led3_module
(
    CLK,RSTn,LED_Out
);

input CLK;
input RSTn;
output LED_Out;

parameter T500MS = 25'd25_000_000;

reg[24:0]Count1;

always@(posedge CLK or negedge RSTn)
if(!RSTn)
    Count1<=25'd0;
else if(Count1 == T500MS)
    Count1<=25'd0;
else
    Count1<=Count1+1'b1;
	
	
reg rLED_Out;

always@(posedge CLK or negedge RSTn)
if(!RSTn)
    rLED_Out<=1'b0;
else if(Count1>=25'd18_250_000 && Count1<25'd25_000_000)
    rLED_Out<=1'b1;
else
    rLED_Out<=1'b0;
	
assign LED_Out=rLED_Out;

endmodule












