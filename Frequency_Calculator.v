//================================================================
//     Frequency Calculator Module
//		 
//		 This module is responsible for calculating the frequency
//		 of the two analog channels
//================================================================
module Frequency_Calculator(
	input Main_CLK,
	input [5:0] TimeScale,
	input [8:0] CH1_Right_Time_Cursor, CH1_Left_Time_Cursor, CH2_Right_Time_Cursor, CH2_Left_Time_Cursor,
	output reg [19:0] CH1_BCD, CH2_BCD
);
reg [15:0] CH1_Binary, CH2_Binary;
//====================================
/** Channel 1 binary */
always @(posedge Main_CLK)
	begin
	if (CH1_Right_Time_Cursor > CH1_Left_Time_Cursor) 
		begin
		CH1_Binary <= 96 * 15360 / (TimeScale * (CH1_Right_Time_Cursor - CH1_Left_Time_Cursor));
		end
	else 
		begin
		CH1_Binary <= 96 * 15360 / (TimeScale * (CH1_Left_Time_Cursor - CH1_Right_Time_Cursor));
		end
	end
//====================================
/** Channel 2 binary */
always @(posedge Main_CLK)
	begin
	if (CH2_Right_Time_Cursor > CH2_Left_Time_Cursor) 
		begin
		CH2_Binary <= 96 * 15360 / (TimeScale * (CH2_Right_Time_Cursor - CH2_Left_Time_Cursor));
		end
	else 
		begin
		CH2_Binary <= 96 * 15360 / (TimeScale * (CH2_Left_Time_Cursor - CH2_Right_Time_Cursor));
		end
	end
//====================================
/** Channel 1 BCD */
integer i;
always @(CH1_Binary)
   begin
   CH1_BCD = 0; //initialize bcd to zero.
   for (i = 0; i < 16; i = i+1) //run for 16 iterations
      begin
      CH1_BCD = {CH1_BCD[18:0],CH1_Binary[15-i]}; //concatenation                  
      //if a hex digit of 'bcd' is more than 4, add 3 to it.  
      if(i < 15 && CH1_BCD[3:0] > 4) 
      CH1_BCD[3:0] = CH1_BCD[3:0] + 3;
      if(i < 15 && CH1_BCD[7:4] > 4)
      CH1_BCD[7:4] = CH1_BCD[7:4] + 3;
      if(i < 15 && CH1_BCD[11:8] > 4)
      CH1_BCD[11:8] = CH1_BCD[11:8] + 3;  
	   if(i < 15 && CH1_BCD[15:12] > 4)
      CH1_BCD[15:12] = CH1_BCD[15:12] + 3;
		if(i < 15 && CH1_BCD[19:16] > 4)
      CH1_BCD[19:16] = CH1_BCD[19:16] + 3;  
      end
   end
//====================================
/** Channel 2 BCD */
integer x;
always @(CH2_Binary)
   begin
   CH2_BCD = 0; //initialize bcd to zero.
   for (x = 0; x < 16; x = x+1) //run for 16 iterations
      begin
      CH2_BCD = {CH2_BCD[18:0],CH2_Binary[15-x]}; //concatenation                  
      //if a hex digit of 'bcd' is more than 4, add 3 to it.  
      if(x < 15 && CH2_BCD[3:0] > 4) 
      CH2_BCD[3:0] = CH2_BCD[3:0] + 3;
      if(x < 15 && CH2_BCD[7:4] > 4)
      CH2_BCD[7:4] = CH2_BCD[7:4] + 3;
      if(x < 15 && CH2_BCD[11:8] > 4)
      CH2_BCD[11:8] = CH2_BCD[11:8] + 3;  
	   if(x < 15 && CH2_BCD[15:12] > 4)
      CH2_BCD[15:12] = CH2_BCD[15:12] + 3;
		if(x < 15 && CH2_BCD[19:16] > 4)
      CH2_BCD[19:16] = CH2_BCD[19:16] + 3;  
      end
   end
endmodule 