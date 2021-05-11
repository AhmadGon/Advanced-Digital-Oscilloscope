//================================================================
//     ADC Control Module
//		 
//		 This module generates necessary signals for controlling
//     AD7352 ADC with 1.5MSPS, SCLK = 25MHz.
//================================================================
module ADC_Controls(

	input Main_CLK, Reset, Data_In_A, Data_In_B, // Data_In : data from ADC to FPGA
	output reg CS, SCLK,
	output reg[11:0] Data_Out_A, Data_Out_B
);

reg[5:0] Counter;  // 50M / 1.5M = 33.3 then 6 bits 
reg[11:0] Data_Reg_A;
reg[11:0] Data_Reg_B;

//===========================================================
always @(posedge Main_CLK)
	begin
	if (!Reset) 
		begin
		Counter <= 6'b000000;
		SCLK <= 0;
		CS <= 0;
		end
	else 
		begin
		Counter <= Counter + 1;
		if (Counter <  6) begin SCLK <= 1; CS <= 1; end
		else if (Counter == 6) begin SCLK <= 1; CS <= 0; end // Setup time 20ns
		else if (Counter == 8)  SCLK <= 1; // pulse 1
		else if (Counter == 10) SCLK <= 1; // pulse 2
		else if (Counter == 12) SCLK <= 1; // pulse 3
		else if (Counter == 14) SCLK <= 1; // pulse 4
		else if (Counter == 16) SCLK <= 1; // pulse 5
		else if (Counter == 18) SCLK <= 1; // pulse 6
		else if (Counter == 20) SCLK <= 1; // pulse 7
		else if (Counter == 22) SCLK <= 1; // pulse 8
		else if (Counter == 24) SCLK <= 1; // pulse 9
		else if (Counter == 26) SCLK <= 1; // pulse 10
		else if (Counter == 28) SCLK <= 1; // pulse 11
		else if (Counter == 30) SCLK <= 1; // pulse 12
		else if (Counter == 32) SCLK <= 1; // pulse 13
		else 
			begin
			SCLK <= 0;
			CS <= 0;
			end
		if (Counter == 33) Counter <= 0; 
		end
	end
//===========================================================
always @ (posedge SCLK)
	begin 
	Data_Reg_A <= {Data_Reg_A [10:0], Data_In_A};
	Data_Reg_B <= {Data_Reg_B [10:0], Data_In_B};
	end
	
//===========================================================
always @ (posedge CS)
	begin
	Data_Out_A [11:0] <= Data_Reg_A [11:0];
	Data_Out_B [11:0] <= Data_Reg_B [11:0];
	end
endmodule
