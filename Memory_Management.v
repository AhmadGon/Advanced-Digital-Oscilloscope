//================================================================
//     Memory Management Module
//		 
//		 This module is responsible for storing all kinds of data to
//		 be displayed by the scope, we can say that this module is  
//		 the memory pool of the project
//================================================================
module Memory_Management(                          
	//CLKs and reset
	input CS, VGA_CLK, Reset, Vsync, Pause,
	//Control Signals
	input [13:0] Address_CH_read,
	input [11:0] Address_Fig_CH, Address_Fig_AMP, Address_Fig_Freq, Address_Fig_Screen,
	input [18:0] Address_Guide,
	input [2:0] Key_Fig,
	input [10:0] Font_Address,
	input [3:0] String_Address,
	output [15:0] String_Data,
	input [4:0] Long_String_Address,
	output [71:0] Long_String_Data,
	//input signals from ADC
	input [11:0] ADC_Out_A, ADC_Out_B,
	//Output signals to GUI
	output [7:0] Font_Out,
	output [11:0] Data_CH_1, Data_CH_2,
	output reg [23:0] Color_Of_Images
);
reg WREN_RAM1, WREN_RAM2;
reg [13:0] Address_CH_write;
// signal to control write in RAMs
reg Stop;
//to control WREN For RAMs
reg change_bit;
//Output data from memory Image 
wire [7:0]Data_Fig_Amplitude, Data_Fig_Freq, Data_Guide;
//Output color from memory Image
wire [23:0]Output_Color_Fig_Amplitude, Output_Color_Fig_Freq, Output_Color_Fig_Guide;
//Output signals from Channels memory
wire [11:0]Output_RAM1_CH1,Output_RAM2_CH1,Output_RAM1_CH2,Output_RAM2_CH2;
wire [13:0] Address_RAM1, Address_RAM2;
//====================================================
always@(posedge Vsync or negedge Reset)
	begin
	if (!Reset) 
		begin
		WREN_RAM1 = 0;
		WREN_RAM2 = 0;
		change_bit <= 0;
		end
	// RAM_1 write data from ADC at starting, between RAM_2 will read   
	else if(Pause == 0)
		begin
		if(change_bit == 0)
			begin
			WREN_RAM1 <= 1;
			WREN_RAM2 <= 0;
			change_bit <= 1;
			end
		else
			begin
			WREN_RAM1 <= 0;
			WREN_RAM2 <= 1;
			change_bit <= 0;
			end
		end
	else 
		begin
		WREN_RAM1 <= 0;
		WREN_RAM2 <= 1;
		end
	end
//====================================================
always@(Key_Fig)
	begin
	case(Key_Fig)
	2: Color_Of_Images = Output_Color_Fig_Guide;
	3: Color_Of_Images = Output_Color_Fig_Freq;
	4: Color_Of_Images = Output_Color_Fig_Amplitude;
	default: Color_Of_Images = 24'h000000;
	endcase
	end
//====================================================
always @ (posedge CS or negedge Reset)
	begin
	if (!Reset)
		begin 
		Address_CH_write <= 0;
		Stop <= 1;
		end
	else if(WREN_RAM1 & Stop)
		begin
		if(Address_CH_write == 15359) 
			begin
			Address_CH_write <= 0;
			Stop <= 0;
			end	
		else
			begin 
			Address_CH_write <= Address_CH_write + 1;
			Stop <= 1;
			end 
		end
	else if(WREN_RAM2 & !Stop)
		begin
		if(Address_CH_write == 15359) 
			begin
			Address_CH_write <= 0;
			Stop <= 1;
			end
		else
			begin 
			Address_CH_write <= Address_CH_write + 1;
			Stop <= 0;
			end 
		end
	end
//====================================================
//To select CLK of RAM
assign clock_RAM1 = (WREN_RAM1) ? ( CS ) : ( VGA_CLK );
assign clock_RAM2 = (WREN_RAM2) ? ( CS ) : ( VGA_CLK );

//To select Memory that will sent signals to VGA 
assign Data_CH_1 = (WREN_RAM2) ? ( Output_RAM1_CH1 ) : ( Output_RAM2_CH1 );
assign Data_CH_2 = (WREN_RAM2) ? ( Output_RAM1_CH2 ) : ( Output_RAM2_CH2 );
//To select address
assign Address_RAM1 = (WREN_RAM1) ? ( Address_CH_write ) : ( Address_CH_read );   
assign Address_RAM2 = (WREN_RAM2) ? ( Address_CH_write ) : ( Address_CH_read );
//====================================================
// Font ROM to write data to screen
Font_ROM	Font_ROM_inst (
	.address (Font_Address),
	.clock (VGA_CLK),
	.q (Font_Out)
	);
//====================================================
// Custom string ROM to write strings to screen
Strings Strings_Inst(
	.VGA_CLK(VGA_CLK),
	.String_Address(String_Address),
	.String_Data(String_Data)
);

Long_Strings Long_Strings_Inst(
	.VGA_CLK(VGA_CLK),
	.String_Address(Long_String_Address),
	.String_Data(Long_String_Data)
);
//====================================================
// Memory for CH 1
RAM1_CH1	RAM1_CH1_inst (
	.address (Address_RAM1),
	.clock (clock_RAM1),
	.data (ADC_Out_A),
	.wren (WREN_RAM1),
	.q (Output_RAM1_CH1)
	);
RAM2_CH1	RAM2_CH1_inst (
	.address (Address_RAM2),
	.clock (clock_RAM2),
	.data (ADC_Out_A),
	.wren (WREN_RAM2),
	.q (Output_RAM2_CH1)
	);
//====================================================
// Memory for CH 2
RAM1_CH2	RAM1_CH2_inst (
	.address (Address_RAM1),
	.clock (clock_RAM1),
	.data (ADC_Out_B),
	.wren (WREN_RAM1),
	.q (Output_RAM1_CH2)
	);
RAM2_CH2	RAM2_CH2_inst (
	.address (Address_RAM2),
	.clock (clock_RAM2),
	.data (ADC_Out_B),
	.wren (WREN_RAM2),
	.q (Output_RAM2_CH2)
	);
//====================================================
// amplitude Figure 
Fig_Amplitude_Data	Fig_Amplitude_Data_inst (
	.address (Address_Fig_AMP),
	.clock (VGA_CLK),
	.q (Data_Fig_Amplitude)
	);
Fig_Amplitude_ColorMap	Fig_Amplitude_ColorMap_inst (
	.address (Data_Fig_Amplitude),
	.clock (VGA_CLK),
	.q (Output_Color_Fig_Amplitude)
	);
//====================================================
// Frequency Figure 
Freq_Fig_Data	Freq_Fig_Data_inst (
	.address (Address_Fig_Freq),
	.clock (VGA_CLK),
	.q (Data_Fig_Freq)
	);
Freq_Fig_color	Freq_Fig_color_inst (
	.address (Data_Fig_Freq),
	.clock (VGA_CLK),
	.q (Output_Color_Fig_Freq)
	);
//====================================================
// Guide page
Guide_DATA	Guide_DATA_inst (
	.address (Address_Guide),
	.clock (VGA_CLK),
	.q (Data_Guide)
	);
Guide_Colormap	Guide_Colormap_inst (
	.address (Data_Guide),
	.clock (VGA_CLK),
	.q (Output_Color_Fig_Guide)
	);
endmodule 