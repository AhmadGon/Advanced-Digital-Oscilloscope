//================================================================
//     Bit range extractor Module
//		 
//		 This module extracts the wanted range of bits out of a bit
//		 vector, note: this module accepts bit number not bit index
//		 for example : 1101 to get the 110 you set StartBit = 2 and
//							EndBit = 4
//================================================================
module BitRangeExtractor(
	input Main_CLK, Module_Enable,
	input [7:0] StartBit, EndBit, Exponent,
	input [31:0] InputToExtractFrom,
	output [7:0] Fraction_BCD,
	output reg Valid_Output
); 
Fraction_BCD_LUT Fraction_BCD_LUT_Inst(
	.Main_CLK(Main_CLK),
	.Exponent(Exponent),
	.Fraction_Binary(ExtractedBits_Valid),
	.Fraction_BCD(Fraction_BCD)
); 
reg [7:0] Bit_Counter;
reg [7:0] Bit_Start;
reg [31:0] ExtractedBits;
wire [7:0] Bit_End;
wire [31:0] ExtractedBits_Valid;
assign ExtractedBits_Valid = (Valid_Output)? ExtractedBits: ExtractedBits;
assign Bit_End = (Module_Enable)? EndBit - 1 : 0;
always @(posedge Main_CLK)
	begin
	if (Module_Enable && Exponent > 127)
		begin
		if (Bit_Start <= Bit_End)
			begin
			ExtractedBits[Bit_Counter] <= InputToExtractFrom[Bit_Start];
			end
		else ExtractedBits[Bit_Counter] <= 0;
		end
	if (Module_Enable && Exponent == 127) ExtractedBits <= InputToExtractFrom[22:15];
	if (Module_Enable && Exponent < 127) ExtractedBits <= InputToExtractFrom[26:19];
	end
always @(posedge Main_CLK)
	begin
	if (Module_Enable)
		begin
		if (Bit_Counter == 0) Bit_Start <= StartBit;
		else Bit_Start <= Bit_Start + 1;
		Bit_Counter <= Bit_Counter + 1;
		end
	else
		begin
		Bit_Start <= 0;
		Bit_Counter <= 0;
		end
	end
always @(Main_CLK)
	begin
	if (Module_Enable)
		begin
		if (Bit_Start > Bit_End && Module_Enable) Valid_Output <= 1;
		else Valid_Output <= 0;
		end
	end
endmodule 