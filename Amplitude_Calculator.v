//================================================================
//     Amplitude calculator Module
//		 
//		 This module is responsible for deeling with IEEE 754 floating
//		 point result from amplitude p-p calculations 
//================================================================
module Amplitude_Calculator(
	input Main_CLK,
	input [6:0] Amplitude_Scale,
	input [8:0] CH1_Up_Amplitude_Cursor, CH1_Down_Amplitude_Cursor, CH2_Up_Amplitude_Cursor, CH2_Down_Amplitude_Cursor,
	output [19:0] CH1_BCD, CH2_BCD
);

reg [31:0] CH1_Numerator, CH2_Numerator;
reg [31:0] CH1_FP_Result_Valid, CH2_FP_Result_Valid;
wire [31:0] CH1_Result, CH2_Result, CH1_FP_Result, CH2_FP_Result, CH1_Numerator_FP, CH2_Numerator_FP;

assign CH1_BCD = {CH1_Integer_BCD, CH1_Fraction_BCD};
assign CH2_BCD = {CH2_Integer_BCD, CH2_Fraction_BCD};

Integer_To_Float	Integer_To_Float_CH1_inst (
	.clock (Main_CLK),
	.dataa (CH1_Numerator),
	.result (CH1_Numerator_FP)
	);

Integer_To_Float	Integer_To_Float_CH2_inst (
	.clock (Main_CLK),
	.dataa (CH2_Numerator),
	.result (CH2_Numerator_FP)
	);
	
FP_CH1_DIV	FP_CH1_DIV_inst (
	.clock (Division_Clock),
	.dataa (CH1_Numerator_FP),
	.datab (32'h45000000), // 2048 in decimal, this number is in IEEE 754 floating point format
	.result (CH1_FP_Result)
	);

FP_CH2_DIV	FP_CH2_DIV_inst (
	.clock (Division_Clock),
	.dataa (CH2_Numerator_FP),
	.datab (32'h45000000),
	.result (CH2_FP_Result)
	);
assign CH1_Result = CH1_FP_Result & CH1_FP_Result_Valid;
assign CH2_Result = CH2_FP_Result & CH2_FP_Result_Valid;
//====================================
/** Generate wait signal for floating point Division */
reg [5:0] CH1_Wait_Counter, CH2_Wait_Counter;
reg [8:0] CH1_Up_Cursor_Changing_Detector [1:0];
reg [8:0] CH1_Down_Cursor_Changing_Detector [1:0];
reg [8:0] CH2_Up_Cursor_Changing_Detector [1:0];
reg [8:0] CH2_Down_Cursor_Changing_Detector [1:0];
reg Check_Enable_Flag, CH1_Change_Detected, CH2_Change_Detected, CH1_Change_Hold_Flag, CH2_Change_Hold_Flag;
assign Division_Clock = (CH1_Wait_Counter > 15)? Main_CLK : 0; 
always @(posedge Main_CLK)
	begin
	if (Check_Enable_Flag)
		begin
		CH1_Up_Cursor_Changing_Detector[0] <= CH1_Up_Amplitude_Cursor;
		CH1_Down_Cursor_Changing_Detector[0] <= CH1_Down_Amplitude_Cursor;
		CH2_Up_Cursor_Changing_Detector[0] <= CH2_Up_Amplitude_Cursor;
		CH2_Down_Cursor_Changing_Detector[0] <= CH2_Down_Amplitude_Cursor;
		end
	else
		begin
		CH1_Up_Cursor_Changing_Detector[1] <= CH1_Up_Amplitude_Cursor;
		CH1_Down_Cursor_Changing_Detector[1] <= CH1_Down_Amplitude_Cursor;
		CH2_Up_Cursor_Changing_Detector[1] <= CH2_Up_Amplitude_Cursor;
		CH2_Down_Cursor_Changing_Detector[1] <= CH2_Down_Amplitude_Cursor;
		end
	Check_Enable_Flag <= !Check_Enable_Flag;
	end
always @(posedge Main_CLK)
	begin
	if (CH1_Up_Cursor_Changing_Detector[0] != CH1_Up_Cursor_Changing_Detector[1] || CH1_Down_Cursor_Changing_Detector[0] != CH1_Down_Cursor_Changing_Detector[1])
		begin
		CH1_Change_Detected <= 1;
		end
	else CH1_Change_Detected <= 0;
	if (CH2_Up_Cursor_Changing_Detector[0] != CH2_Up_Cursor_Changing_Detector[1] || CH2_Down_Cursor_Changing_Detector[0] != CH2_Down_Cursor_Changing_Detector[1])
		begin
		CH2_Change_Detected <= 1;
		end
	else CH2_Change_Detected <= 0;
	end
always @(posedge Main_CLK)
	begin
	if (CH1_Change_Detected) CH1_Change_Hold_Flag <= 1;
	if (CH1_Wait_Counter == 62) CH1_Change_Hold_Flag <= 0;
	end
always @(posedge Main_CLK)
	begin
	if (CH2_Change_Detected) CH2_Change_Hold_Flag <= 1;
	if (CH2_Wait_Counter == 62) CH2_Change_Hold_Flag <= 0;
	end
always @(posedge Main_CLK)
	begin
	if (CH1_Change_Hold_Flag) 
		begin
		CH1_Wait_Counter <= CH1_Wait_Counter + 1;
		if (CH1_Wait_Counter == 21) CH1_FP_Result_Valid <= 32'hFFFFFFFF;
		end
	if (CH1_Change_Detected) 
		begin
		CH1_Wait_Counter <= 0;
		CH1_FP_Result_Valid <= 0;
		end
	end
always @(posedge Main_CLK)
	begin
	if (CH2_Change_Hold_Flag) 
		begin
		CH2_Wait_Counter <= CH2_Wait_Counter + 1;
		if (CH2_Wait_Counter == 21) CH2_FP_Result_Valid <= 32'hFFFFFFFF;
		end
	if (CH2_Change_Detected) 
		begin
		CH2_Wait_Counter <= 0;
		CH2_FP_Result_Valid <= 0;
		end
	end
//==========================================
/** Extract integer and fraction values from the floating point result */
/** Solution strategy:  
  * 	Since all values are positive (Vp-p always positive) the first bit of the IEEE 754 format is ignored 
  *	The next 8 bits of the format are the exponent bits which will tell us if the number is greater than
  *	1 or not or if it equals to 1, getting the exponent number by subtracting the decimal value by 127, 
  *	for the fraction number we do this:
  *
  *	for values > 2: fraction BCD = mantissa[22-exponent number:22-exponent number - 8], why 8? because our LUT is for 8 bit precision
  *	for values < 2 && values > 1: fraction BCD = mantissa[23:16]
  *	for values < 1: fraction BCD = mantissa[26:19]
  *
  *	Remember our precision is 8-bit so our LUTs are.
  */
//==========================================
/** Channel 1 */
wire [7:0] CH1_Fraction_BCD;
wire CH1_BitExtractor_Enable;
wire [7:0] CH1_Exponent;
wire [31:0] CH1_Integer;
reg [7:0] CH1_StartBit, CH1_EndBit;
reg [7:0] CH1_Exponent_Number;
reg [19:0] CH1_Integer_BCD;
reg [31:0] CH1_Integer_Result;

// For CH1 Mantissa
BitRangeExtractor BitRangeExtractor_CH1_Inst(
	.Main_CLK(Main_CLK),
	.Module_Enable(CH1_BitExtractor_Enable),
	.Exponent(CH1_Exponent),
	.StartBit(CH1_StartBit),
	.EndBit(CH1_EndBit),
	.InputToExtractFrom(CH1_Result),
	.Fraction_BCD(CH1_Fraction_BCD),
	.Valid_Output(CH1_Fraction_Valid_Output)
);

//-------------------------------
// For CH1 Integer
integer i;
Float_To_Integer	Float_To_Integer_CH1_inst (
	.clock (Main_CLK),
	.dataa (CH1_Result),
	.result (CH1_Integer)
	);
always @(CH1_Integer)
   begin
	CH1_Integer_Result = CH1_Integer;
   CH1_Integer_BCD = 0; //initialize bcd to zero.
	if (CH1_Fraction_BCD[7:4] >= 5 && CH1_Integer >= 1) CH1_Integer_Result = CH1_Integer_Result- 1;
   for (i = 0; i < 16; i = i+1) //run for 16 iterations
      begin
      CH1_Integer_BCD = {CH1_Integer_BCD[18:0],CH1_Integer_Result[15-i]}; //concatenation                  
      //if a hex digit of 'bcd' is more than 4, add 3 to it.  
      if(i < 15 && CH1_Integer_BCD[3:0] > 4) 
      CH1_Integer_BCD[3:0] = CH1_Integer_BCD[3:0] + 3;
      if(i < 15 && CH1_Integer_BCD[7:4] > 4)
      CH1_Integer_BCD[7:4] = CH1_Integer_BCD[7:4] + 3;
      if(i < 15 && CH1_Integer_BCD[11:8] > 4)
      CH1_Integer_BCD[11:8] = CH1_Integer_BCD[11:8] + 3;  
	   if(i < 15 && CH1_Integer_BCD[15:12] > 4)
      CH1_Integer_BCD[15:12] = CH1_Integer_BCD[15:12] + 3;
		if(i < 15 && CH1_Integer_BCD[19:16] > 4)
      CH1_Integer_BCD[19:16] = CH1_Integer_BCD[19:16] + 3;  
      end
   end

	/** Once CH1 floating point output is valid start the bit extractor module */
assign CH1_Exponent = (CH1_BitExtractor_Enable)? CH1_Result[30:23] : CH1_Result[30:23];
assign CH1_BitExtractor_Enable = (CH1_FP_Result_Valid == 32'hFFFFFFFF)? 1 : 0;

/** Calculate the exponent number of CH1 */
always @(posedge Main_CLK)
	begin
	if (CH1_BitExtractor_Enable)
		begin
		if (CH1_Exponent > 127) CH1_Exponent_Number <= CH1_Exponent - 127;
		else if (CH1_Exponent == 127) CH1_Exponent_Number <= 0;
		else if (CH1_Exponent < 127) CH1_Exponent_Number <= 127 - CH1_Exponent;
		else CH1_Exponent_Number <= 0;
		end
	end
always @(posedge Main_CLK)
	begin
	/** CH1_StartBit and CH1_EndBit are determined based on exponent number */
	/** We only take 8 bits of fraction which is enough to produce accuarte results */
	if (CH1_BitExtractor_Enable)
		begin
		/** If float result is bigger than 2 */
		if (CH1_Exponent > 127)
			begin
			CH1_StartBit <= 23 - CH1_Exponent_Number - 7;
			CH1_EndBit <= 23 - CH1_Exponent_Number;
			if (CH1_Wait_Counter > 25) CH1_EndBit <= CH1_EndBit;
			end
		/** If float result is between 1 and 2 */
		else if (CH1_Exponent == 127)
			begin
			CH1_StartBit <= 23;
			CH1_EndBit <= 16;
			end
		/** If float result is less than 1 */
		else if (CH1_Exponent < 127)
			begin
			CH1_StartBit <= 20;
			CH1_EndBit <= 27;
			end
		end
	end
//==========================================
/** Channel 2 */
wire [7:0] CH2_Fraction_BCD;
wire CH2_BitExtractor_Enable;
wire [7:0] CH2_Exponent;
wire [31:0] CH2_Integer;
reg [7:0] CH2_StartBit, CH2_EndBit;
reg [7:0] CH2_Exponent_Number;
reg [19:0] CH2_Integer_BCD;
reg [31:0] CH2_Integer_Result;

// For CH2 Mantissa
BitRangeExtractor BitRangeExtractor_CH2_Inst(
	.Main_CLK(Main_CLK),
	.Module_Enable(CH2_BitExtractor_Enable),
	.Exponent(CH2_Exponent),
	.StartBit(CH2_StartBit),
	.EndBit(CH2_EndBit),
	.InputToExtractFrom(CH2_Result),
	.Fraction_BCD(CH2_Fraction_BCD),
	.Valid_Output(CH2_Fraction_Valid_Output)
);

//-------------------------------
// For CH2 Integer
integer x;
Float_To_Integer	Float_To_Integer_CH2_inst (
	.clock (Main_CLK),
	.dataa (CH2_Result),
	.result (CH2_Integer)
	);
always @(CH2_Integer)
   begin
	CH2_Integer_Result = CH2_Integer;
   CH2_Integer_BCD = 0; //initialize bcd to zero.
	if (CH2_Fraction_BCD[7:4] >= 5 && CH2_Integer >= 1) CH2_Integer_Result = CH2_Integer_Result- 1;
   for (x = 0; x < 16; x = x+1) //run for 16 iterations
      begin
      CH2_Integer_BCD = {CH2_Integer_BCD[18:0],CH2_Integer_Result[15-x]}; //concatenation                  
      //if a hex digit of 'bcd' is more than 4, add 3 to it.  
      if(x < 15 && CH2_Integer_BCD[3:0] > 4) 
      CH2_Integer_BCD[3:0] = CH2_Integer_BCD[3:0] + 3;
      if(x < 15 && CH2_Integer_BCD[7:4] > 4)
      CH2_Integer_BCD[7:4] = CH2_Integer_BCD[7:4] + 3;
      if(x < 15 && CH2_Integer_BCD[11:8] > 4)
      CH2_Integer_BCD[11:8] = CH2_Integer_BCD[11:8] + 3;  
	   if(x < 15 && CH2_Integer_BCD[15:12] > 4)
      CH2_Integer_BCD[15:12] = CH2_Integer_BCD[15:12] + 3;
		if(x < 15 && CH2_Integer_BCD[19:16] > 4)
      CH2_Integer_BCD[19:16] = CH2_Integer_BCD[19:16] + 3;  
      end
   end

	/** Once CH2 floating point output is valid start the bit extractor module */
assign CH2_Exponent = (CH2_BitExtractor_Enable)? CH2_Result[30:23] : CH2_Result[30:23];
assign CH2_BitExtractor_Enable = (CH2_FP_Result_Valid == 32'hFFFFFFFF)? 1 : 0;

/** Calculate the exponent number of CH2 */
always @(posedge Main_CLK)
	begin
	if (CH2_BitExtractor_Enable)
		begin
		if (CH2_Exponent > 127) CH2_Exponent_Number <= CH2_Exponent - 127;
		else if (CH2_Exponent == 127) CH2_Exponent_Number <= 0;
		else if (CH2_Exponent < 127) CH2_Exponent_Number <= 127 - CH2_Exponent;
		else CH2_Exponent_Number <= 0;
		end
	end
always @(posedge Main_CLK)
	begin
	/** CH2_StartBit and CH2_EndBit are determined based on exponent number */
	/** We only take 8 bits of fraction which is enough to produce accuarte results */
	if (CH2_BitExtractor_Enable)
		begin
		/** If float result is bigger than 2 */
		if (CH2_Exponent > 127)
			begin
			CH2_StartBit <= 23 - CH2_Exponent_Number - 7;
			CH2_EndBit <= 23 - CH2_Exponent_Number;
			if (CH2_Wait_Counter > 25) CH2_EndBit <= CH2_EndBit;
			end
		/** If float result is between 1 and 2 */
		else if (CH2_Exponent == 127)
			begin
			CH2_StartBit <= 23;
			CH2_EndBit <= 16;
			end
		/** If float result is less than 1 */
		else if (CH2_Exponent < 127)
			begin
			CH2_StartBit <= 20;
			CH2_EndBit <= 27;
			end
		end
	end
//====================================
/** Calculate CH1 numerator integer value */
always @(posedge Main_CLK)
	begin
	if (CH1_Up_Amplitude_Cursor > CH1_Down_Amplitude_Cursor)
		begin
		CH1_Numerator <= Amplitude_Scale * (CH1_Up_Amplitude_Cursor - CH1_Down_Amplitude_Cursor) * 10;
		end
	else
		begin
		CH1_Numerator <= Amplitude_Scale * (CH1_Down_Amplitude_Cursor - CH1_Up_Amplitude_Cursor) * 10;
		end
	end
//====================================
/** Calculate CH2 numerator integer value */
always @(posedge Main_CLK)
	begin
	if (CH2_Up_Amplitude_Cursor > CH2_Down_Amplitude_Cursor)
		begin
		CH2_Numerator <= Amplitude_Scale * (CH2_Up_Amplitude_Cursor - CH2_Down_Amplitude_Cursor) * 10;
		end
	else
		begin
		CH2_Numerator <= Amplitude_Scale * (CH2_Down_Amplitude_Cursor - CH2_Up_Amplitude_Cursor) * 10;
		end
	end
endmodule 