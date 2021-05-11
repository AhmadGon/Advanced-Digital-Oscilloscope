//================================================================
//     Custom String module
//		 
//		 This module is a submodule of Memory Management Module, it
//		 contains custom strings configurations to be displayed as  
//		 data chunks to screen
//================================================================
module Strings(
	input VGA_CLK,
	input [3:0] String_Address,
	output reg[15:0] String_Data 
);
always @(posedge VGA_CLK)
	begin
	case(String_Address)
	// Hz
	00: String_Data <= 16'b1100011000000000;
	01: String_Data <= 16'b1100011000000000;
	02: String_Data <= 16'b1100011000000000;
	03: String_Data <= 16'b1100011011111110;
	04: String_Data <= 16'b1111111011001100;
	05: String_Data <= 16'b1100011000011000;
	06: String_Data <= 16'b1100011000110000;
	07: String_Data <= 16'b1100011001100000;
	08: String_Data <= 16'b1100011011000110;
	09: String_Data <= 16'b1100011011111110;
	10: String_Data <= 16'b0000000000000000;
	11: String_Data <= 16'b0000000000000000;
	12: String_Data <= 16'b0000000000000000;
	13: String_Data <= 16'b0000000000000000;
	14: String_Data <= 16'b0000000000000000;
	15: String_Data <= 16'b0000000000000000;
	endcase
	end
endmodule 