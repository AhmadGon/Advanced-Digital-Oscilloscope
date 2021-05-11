//================================================================
//     Bit shifter Module
//		 
//		 This module shifts the input integer to the right or to the
//		 left with the wanted amount 
//================================================================
module BitShifter(
	input Main_CLK, RightLeftShift_Switch, Module_Enable,
	input [7:0] InputToShift, ShiftNumber,
	output [31:0] ShiftedOutput,
	output reg Valid_Output
);
reg [7:0] Shift_Counter;
reg [31:0] ShiftedNumber;
reg WaitSingleCLKPulse;
assign ShiftedOutput = (Valid_Output)? ShiftedNumber : 32'hFFFFFFFF;
always @(posedge Main_CLK)
	begin
	if (Module_Enable)
		begin
		if (Shift_Counter < ShiftNumber && WaitSingleCLKPulse) Shift_Counter <= Shift_Counter + 1;
		end
	else
		begin
		Shift_Counter <= 0;
		end
	end
always @(posedge Main_CLK)
	begin
	ShiftedNumber <= InputToShift;
	if (Module_Enable && WaitSingleCLKPulse)
		begin
		if (Shift_Counter < ShiftNumber) 
			begin
			if (RightLeftShift_Switch) ShiftedNumber <= ShiftedNumber * 2;
			else ShiftedNumber <= ShiftedNumber / 2;
			end
		else ShiftedNumber <= ShiftedNumber;
		end
	end
always @(posedge Main_CLK)
	begin
	if (Module_Enable)
		begin
		if (Shift_Counter == ShiftNumber) Valid_Output <= 1;
		else Valid_Output <= 0;
		end
	else Valid_Output <= 0;
	end
always @(posedge Main_CLK)
	begin
	if (Module_Enable) WaitSingleCLKPulse <= 1;
	else WaitSingleCLKPulse <= 0;
	end
endmodule 