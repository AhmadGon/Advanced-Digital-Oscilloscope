/*   ////=====================================       
 *             Digital Oscilloscope   
 *   =====================================////         
 */                                                  

module Top(
	/** Clock and reset */
	input Main_CLK, Reset,
	/** ADC input signals*/
	input SData_A, SData_B, 
	/** Scope's user controls */
	input ScreenCapture, Pause, TimeScale_1, TimeScale_2, TimeScale_3, TimeScale_4, TimeScale_5, Cursors_Enable,
	input Cursor_Channel_Switch, Cursor_Right_Left_Switch, Cursor_Direction_Switch, Cursor_Moving_Button,
	input Move_Up_Down_Drawn_Signal, Signal_Move_Button, Cursor_Up_Down_Switch, Amplitude_Cursor_Direction_Switch,
	input Amplitude_Cursor_Moving_Button, Guide,
	input [2:0] Amplitude_Binary,
	/** VGA control signals */
	output VGA_CLK, Hsync, Vsync, Sync_N, Blank_N,
	/**ADC control signals*/
	output CS, ADC_SCLK,
	/** VGA output signals */
	output [7:0] Red, Green, Blue,
	/** SRAM Signals */
	inout reg [15:0] SRAM_Data,
	output[19:0] Address,
	output OE_N, CE_N, LB_N, UB_N, WE_N,
	/** SDRAM signals */
	output [12:0] SDRAM_Address,
	output [1:0] SDRAM_BA,
	output SDRAM_CAS, SDRAM_CKE, SDRAM_CS,
	inout [31:0] SDRAM_DATA,
	output [3:0] SDRAM_DQM,
	output SDRAM_RAS, SDRAM_WE, SDRAM_CLK
	
);

wire[9:0] H_Pixel, V_Pixel;
wire[11:0] ADC_Out_A,ADC_Out_B;
wire[2:0] Event_Register, Response_Register;
wire SRAM_CLK; /** This 100MHz clock */
wire WriteFinish_Flag;
wire[19:0] Read_Address;
wire[15:0] Read_Data;
wire[15:0] Write_Data;
wire Nios_Finish_Reading_Flag, Response_1, Response_2, ScreenActiveStart_Flag, ScreenActiveFinish_Flag;
wire[10:0] Font_Address;
wire[7:0] Font_Out;
wire[3:0] String_Address;
wire[4:0] Long_String_Address;
wire[15:0] String_Data;
wire[71:0] Long_String_Data;
wire[6:0] Loading_Percentage;
wire[13:0] Address_CH_read;
wire[11:0] Address_Fig_AMP, Address_Fig_Freq;
wire[18:0] Address_Guide;
wire[2:0] Key_Fig;
wire[23:0] Color_Of_Images;
wire[11:0] Data_CH_1, Data_CH_2;

/** Debounced wires coming from debouncer module */
wire ScreenCapture_Activated, Pause_Activated, Reset_Activated, TimeScale_1_Activated, TimeScale_2_Activated, TimeScale_3_Activated;
wire TimeScale_4_Activated, TimeScale_5_Activated, Cursor_Channel_Switch_Activated, Cursor_Right_Left_Switch_Activated;
wire Cursor_Direction_Switch_Activated, Cursor_Moving_Button_Activated, Cursors_Enable_Activated, Move_Up_Down_Drawn_Signal_Activated;
wire Signal_Move_Button_Activated, Cursor_Up_Down_Switch_Activated, Amplitude_Cursor_Direction_Switch_Activated;
wire Amplitude_Cursor_Moving_Button_Activated, Guide_Activated;
wire [2:0] Amplitude_Binary_Activated;

always @(posedge SRAM_CLK)
	begin
	if (WE_N) SRAM_Data <= 16'hzzzz;
	else SRAM_Data <= Write_Data;
	end

assign Read_Data = SRAM_Data;
assign Event_Register[0] = WriteFinish_Flag;
assign Event_Register[1] = 0;
assign Event_Register[2] = 0;

assign Nios_Finish_Reading_Flag = Response_Register[0];
assign Response_1 = 0;
assign Response_2 = 0;

DeBouncer DeBouncer_Inst(
	.Main_CLK(Main_CLK),
	/** Input switches (pins) */
	.Reset(Reset),
	.Pause(Pause),
	.ScreenCapture(ScreenCapture),
	.TimeScale_1(TimeScale_1),
	.TimeScale_2(TimeScale_2),
	.TimeScale_3(TimeScale_3),
	.TimeScale_4(TimeScale_4),
	.TimeScale_5(TimeScale_5),
	.Cursors_Enable(Cursors_Enable),
	.Cursor_Channel_Switch(Cursor_Channel_Switch),
	.Cursor_Right_Left_Switch(Cursor_Right_Left_Switch),
	.Cursor_Direction_Switch(Cursor_Direction_Switch),
	.Cursor_Moving_Button(Cursor_Moving_Button),
	.Move_Up_Down_Drawn_Signal(Move_Up_Down_Drawn_Signal),
	.Signal_Move_Button(Signal_Move_Button),
	.Amplitude_Binary(Amplitude_Binary),
	.Cursor_Up_Down_Switch(Cursor_Up_Down_Switch),
	.Amplitude_Cursor_Direction_Switch(Amplitude_Cursor_Direction_Switch),
	.Amplitude_Cursor_Moving_Button(Amplitude_Cursor_Moving_Button),
	.Guide(Guide),
	/** Output debounced signals */
	.Reset_Activated(Reset_Activated),
	.Pause_Activated(Pause_Activated),
	.ScreenCapture_Activated(ScreenCapture_Activated),
	.TimeScale_1_Activated(TimeScale_1_Activated),
	.TimeScale_2_Activated(TimeScale_2_Activated),
	.TimeScale_3_Activated(TimeScale_3_Activated),
	.TimeScale_4_Activated(TimeScale_4_Activated),
	.TimeScale_5_Activated(TimeScale_5_Activated),
	.Cursors_Enable_Activated(Cursors_Enable_Activated),
	.Cursor_Channel_Switch_Activated(Cursor_Channel_Switch_Activated),
	.Cursor_Right_Left_Switch_Activated(Cursor_Right_Left_Switch_Activated),
	.Cursor_Direction_Switch_Activated(Cursor_Direction_Switch_Activated),
	.Cursor_Moving_Button_Activated(Cursor_Moving_Button_Activated),
	.Move_Up_Down_Drawn_Signal_Activated(Move_Up_Down_Drawn_Signal_Activated),
	.Signal_Move_Button_Activated(Signal_Move_Button_Activated),
	.Amplitude_Binary_Activated(Amplitude_Binary_Activated),
	.Cursor_Up_Down_Switch_Activated(Cursor_Up_Down_Switch_Activated),
	.Amplitude_Cursor_Direction_Switch_Activated(Amplitude_Cursor_Direction_Switch_Activated),
	.Amplitude_Cursor_Moving_Button_Activated(Amplitude_Cursor_Moving_Button_Activated),
	.Guide_Activated(Guide_Activated)
);

Nios_Screen_Reader u0 (
        .clk_clk                   (Main_CLK),                   //                  clk.clk
        .clock_bridge_out_clk_clk  (SRAM_CLK),  					  // clock_bridge_out_clk.clk
        .events_export             (Event_Register),             //               events.export
        .input_data_export         (Read_Data),         			  //           input_data.export
        .loading_percentage_export (Loading_Percentage), 		  //   loading_percentage.export
        .output_address_export     (Read_Address),     			  //       output_address.export
        .reset_reset_n             (Reset_Activated),            //                reset.reset_n
        .response_export           (Response_Register),          //             response.export
        .sdram_addr                (SDRAM_Address),              //                sdram.addr
        .sdram_ba                  (SDRAM_BA),                   //                     .ba
        .sdram_cas_n               (SDRAM_CAS),                  //                     .cas_n
        .sdram_cke                 (SDRAM_CKE),                  //                     .cke
        .sdram_cs_n                (SDRAM_CS),                   //                     .cs_n
        .sdram_dq                  (SDRAM_DATA),                 //                     .dq
        .sdram_dqm                 (SDRAM_DQM),                  //                     .dqm
        .sdram_ras_n               (SDRAM_RAS),               	  //                     .ras_n
        .sdram_we_n                (SDRAM_WE),                   //                     .we_n
        .sdram_clk_clk             (SDRAM_CLK)                   //            sdram_clk.clk
    );

VGA_Controls VGA_Controls_Inst(
	.Main_CLK(Main_CLK),
	.Reset(Reset_Activated),
	.H_Pixel(H_Pixel),
	.V_Pixel(V_Pixel),
	.VGA_CLK(VGA_CLK),
	.Hsync(Hsync),
	.Vsync(Vsync),
	.Blank_N(Blank_N),
	.Sync_N(Sync_N),
	.ScreenActiveStart_Flag(ScreenActiveStart_Flag),
	.ScreenActiveFinish_Flag(ScreenActiveFinish_Flag)
);

ADC_Controls ADC_Controls_Inst( 
	.Main_CLK(Main_CLK),
	.Reset(Reset_Activated),
	.Data_In_A(SData_A),
	.Data_In_B(SData_B),
	.CS(CS),
	.SCLK(ADC_SCLK),
	//.Data_Out_A(ADC_Out_A),// Note : this two signals go to another modules.  
	//.Data_Out_B(ADC_Out_B) //
);

GUI GUI_Inst(
	.Main_CLK(Main_CLK),
	.VGA_CLK(VGA_CLK),
	.Reset(Reset_Activated),
	.Blank_N(Blank_N),
	.H_Pixel(H_Pixel),
	.V_Pixel(V_Pixel),
	.Color_Of_Images(Color_Of_Images),
	.Data_CH_1(Data_CH_1),
	.Data_CH_2(Data_CH_2),
	.Address_CH_read(Address_CH_read),
	.Address_Fig_AMP(Address_Fig_AMP),
	.Address_Fig_Freq(Address_Fig_Freq),
	.Address_Guide(Address_Guide),
	.Key_Fig(Key_Fig),
	.TimeScale_1(TimeScale_1_Activated),
	.TimeScale_2(TimeScale_2_Activated),
	.TimeScale_3(TimeScale_3_Activated),
	.TimeScale_4(TimeScale_4_Activated),
	.TimeScale_5(TimeScale_5_Activated),
	.Cursors_Enable(Cursors_Enable_Activated),
	.Cursor_Channel_Switch(Cursor_Channel_Switch_Activated),
	.Cursor_Right_Left_Switch(Cursor_Right_Left_Switch_Activated),
	.Cursor_Direction_Switch(Cursor_Direction_Switch_Activated),
	.Cursor_Moving_Button(Cursor_Moving_Button_Activated),
	.ScreenCapture(ScreenCapture_Activated),
	.Move_Up_Down_Drawn_Signal(Move_Up_Down_Drawn_Signal_Activated),
	.Signal_Move_Button(Signal_Move_Button_Activated),
	.Amplitude_Binary(Amplitude_Binary_Activated),
	.Cursor_Up_Down_Switch(Cursor_Up_Down_Switch_Activated),
	.Amplitude_Cursor_Direction_Switch(Amplitude_Cursor_Direction_Switch_Activated),
	.Amplitude_Cursor_Moving_Button(Amplitude_Cursor_Moving_Button_Activated),
	.Guide_Activated(Guide_Activated),
	.Font_Address(Font_Address),
	.Font_Out(Font_Out),
	.String_Address(String_Address),
	.String_Data(String_Data),
	.Long_String_Address(Long_String_Address),
	.Long_String_Data(Long_String_Data),
	.Loading_Percentage(Loading_Percentage),
	.Nios_Finish_Reading_Flag(Nios_Finish_Reading_Flag),
	.ScreenActiveStart_Flag(ScreenActiveStart_Flag),
	.ScreenActiveFinish_Flag(ScreenActiveFinish_Flag),
	.Red(Red),
	.Green(Green),
	.Blue(Blue)
);

SRAM_Control SRAM_Control_Inst(
	.VGA_CLK(VGA_CLK),
	.Main_CLK(Main_CLK),
	.SRAM_CLK(SRAM_CLK),
	.Reset(Reset_Activated),
	.H_Pixel(H_Pixel),
	.V_Pixel(V_Pixel),
	.ScreenCapture(ScreenCapture_Activated),
	.Nios_Finish_Reading_Flag(Nios_Finish_Reading_Flag),
	.Read_Address(Read_Address),
	.Pixel_Data({Red,Green,Blue}),
	.Data_Chunk(Write_Data),
	.Address(Address),
	.OE_N(OE_N),
	.CE_N(CE_N),
	.LB_N(LB_N),
	.UB_N(UB_N),
	.WriteFinish_Flag(WriteFinish_Flag),
	.WE_N(WE_N),
	.Blank_N(Blank_N),
	.ScreenActiveStart_Flag(ScreenActiveStart_Flag),
	.ScreenActiveFinish_Flag(ScreenActiveFinish_Flag)
);

Memory_Management Memory_Management_Inst(
	.Vsync(Vsync),
	.Reset(Reset_Activated),
	.CS(CS),
	.Pause(Pause_Activated),
	.VGA_CLK(VGA_CLK),
	.Address_CH_read(Address_CH_read),
	.Address_Fig_AMP(Address_Fig_AMP),
	.Address_Fig_Freq(Address_Fig_Freq),
	.Address_Guide(Address_Guide),
	.Key_Fig(Key_Fig),
	.ADC_Out_A(ADC_Out_A),
	.ADC_Out_B(ADC_Out_B),
	.Data_CH_1(Data_CH_1),
	.Data_CH_2(Data_CH_2),
	.Font_Address(Font_Address),
	.Font_Out(Font_Out),
	.String_Address(String_Address),
	.String_Data(String_Data),
	.Long_String_Address(Long_String_Address),
	.Long_String_Data(Long_String_Data),
	.Color_Of_Images(Color_Of_Images)
);
//=========================================
//For Test
Test Test_Inst(
	.CS(CS),
	.VGA_CLK(VGA_CLK),
	.CH1_Third_Stage(ADC_Out_A),
	.CH2_Third_Stage(ADC_Out_B)
	//.test_3(CS)
);
//=========================================
endmodule 
