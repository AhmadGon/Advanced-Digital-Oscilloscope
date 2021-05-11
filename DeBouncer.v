//================================================================
//     DeBouncer Module
//		 
//		 This module is responsible for debouncing switching events
//		 in other words wait enough time for the input switch/push
//		 button to settle down to stable state before taking its 
//		 value
//================================================================
module DeBouncer(
	input Main_CLK, 
	/** Bounced input pins */
	input Reset, ScreenCapture, Pause, TimeScale_1, TimeScale_2, TimeScale_3, TimeScale_4, TimeScale_5, Cursors_Enable,
	input Cursor_Channel_Switch, Cursor_Right_Left_Switch, Cursor_Direction_Switch, Cursor_Moving_Button,
	input Move_Up_Down_Drawn_Signal, Signal_Move_Button, Cursor_Up_Down_Switch, Amplitude_Cursor_Direction_Switch,
	input Amplitude_Cursor_Moving_Button,
	input [2:0] Amplitude_Binary,
	input Guide,
	/** Debounced output signals */
	output ScreenCapture_Activated, Pause_Activated, Reset_Activated, TimeScale_1_Activated, TimeScale_2_Activated, TimeScale_3_Activated,
	output TimeScale_4_Activated, TimeScale_5_Activated, Cursor_Channel_Switch_Activated, Cursor_Right_Left_Switch_Activated,
	output Cursor_Direction_Switch_Activated, Cursor_Moving_Button_Activated, Cursors_Enable_Activated,
	output Move_Up_Down_Drawn_Signal_Activated, Signal_Move_Button_Activated, Cursor_Up_Down_Switch_Activated,
	output Amplitude_Cursor_Direction_Switch_Activated, Amplitude_Cursor_Moving_Button_Activated,
	output [2:0] Amplitude_Binary_Activated,
	output Guide_Activated
);

/* Note: To add a new debouncer for your switch follow the below steps:
 * 		1. Declare a 13-bit debouncer counter for your switch.
 *			2. Name the output of the debouncer (SwithcName_Activated).
 *			3. Copy the first always block with doing name changes to be
 *			   compatible with your switch.
 */
assign ScreenCapture_Activated = ScreenCapture_Flag;
assign Pause_Activated = Pause_Flag;
assign Reset_Activated = !Reset_Flag;
assign TimeScale_1_Activated = TimeScale_1_Flag;
assign TimeScale_2_Activated = TimeScale_2_Flag;
assign TimeScale_3_Activated = TimeScale_3_Flag;
assign TimeScale_4_Activated = TimeScale_4_Flag;
assign TimeScale_5_Activated = TimeScale_5_Flag;
assign Cursor_Channel_Switch_Activated = Cursor_Channel_Switch_Flag;
assign Cursor_Right_Left_Switch_Activated = Cursor_Right_Left_Switch_Flag;
assign Cursor_Direction_Switch_Activated = Cursor_Direction_Switch_Flag;
assign Cursor_Moving_Button_Activated = Cursor_Moving_Button_Flag;
assign Cursors_Enable_Activated = Cursors_Enable_Flag;
assign Move_Up_Down_Drawn_Signal_Activated = Move_Up_Down_Drawn_Signal_Flag;
assign Signal_Move_Button_Activated = Signal_Move_Button_Flag;
assign Cursor_Up_Down_Switch_Activated = Cursor_Up_Down_Switch_Flag;
assign Amplitude_Cursor_Direction_Switch_Activated = Amplitude_Cursor_Direction_Switch_Flag;
assign Amplitude_Cursor_Moving_Button_Activated = Amplitude_Cursor_Moving_Button_Flag;
assign Amplitude_Binary_Activated = Amplitude_Binary_Flag;
assign Guide_Activated = Guide_Flag;

reg ScreenCapture_Flag, Pause_Flag, Reset_Flag, TimeScale_1_Flag, TimeScale_2_Flag, TimeScale_3_Flag, TimeScale_4_Flag, TimeScale_5_Flag;
reg Cursor_Channel_Switch_Flag, Cursor_Right_Left_Switch_Flag, Cursor_Direction_Switch_Flag, Cursor_Moving_Button_Flag;
reg Cursors_Enable_Flag, Move_Up_Down_Drawn_Signal_Flag, Signal_Move_Button_Flag, Cursor_Up_Down_Switch_Flag;
reg Amplitude_Cursor_Direction_Switch_Flag, Amplitude_Cursor_Moving_Button_Flag, Guide_Flag;
reg [2:0] Amplitude_Binary_Flag;
//====================================
/** Debouncer for ScreenCapture switch */
reg[12:0] ScreenCaptureDeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) ScreenCapture_Flag <= 0;
	else
		begin
		if (ScreenCapture && !ScreenCapture_Flag)
			begin
			ScreenCaptureDeBounce_Counter <= ScreenCaptureDeBounce_Counter + 1;
			if (ScreenCaptureDeBounce_Counter == 7999) ScreenCapture_Flag <= 1;
			else ScreenCapture_Flag <= 0;
			end
		else if (!ScreenCapture) 
			begin
			ScreenCapture_Flag <= 0;
			ScreenCaptureDeBounce_Counter <= 0;
			end
		else ScreenCaptureDeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for Pause switch */
reg[12:0] PauseDeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) Pause_Flag <= 0;
	else
		begin
		if (Pause && !Pause_Flag)
			begin
			PauseDeBounce_Counter <= PauseDeBounce_Counter + 1;
			if (PauseDeBounce_Counter == 7999) Pause_Flag <= 1;
			else Pause_Flag <= 0;
			end
		else if (!Pause) 
			begin
			Pause_Flag <= 0;
			PauseDeBounce_Counter <= 0;
			end
		else PauseDeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for Reset switch */
reg[12:0] ResetDeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset && !Reset_Flag)
		begin
		ResetDeBounce_Counter <= ResetDeBounce_Counter + 1;
		if (ResetDeBounce_Counter == 7999) Reset_Flag <= 1;
		else Reset_Flag <= 0;
		end
	else if (Reset) 
		begin
		Reset_Flag <= 0;
		ResetDeBounce_Counter <= 0;
		end
	else ResetDeBounce_Counter <= 0;
	end
//====================================
/** Debouncer for TimeScale_1 switch */
reg[12:0] TimeScale_1_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) TimeScale_1_Flag <= 0;
	else
		begin
		if (TimeScale_1 && !TimeScale_1_Flag)
			begin
			TimeScale_1_DeBounce_Counter <= TimeScale_1_DeBounce_Counter + 1;
			if (TimeScale_1_DeBounce_Counter == 7999) TimeScale_1_Flag <= 1;
			else TimeScale_1_Flag <= 0;
			end
		else if (!TimeScale_1) 
			begin
			TimeScale_1_Flag <= 0;
			TimeScale_1_DeBounce_Counter <= 0;
			end
		else TimeScale_1_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for TimeScale_2 switch */
reg[12:0] TimeScale_2_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) TimeScale_2_Flag <= 0;
	else
		begin
		if (TimeScale_2 && !TimeScale_2_Flag)
			begin
			TimeScale_2_DeBounce_Counter <= TimeScale_2_DeBounce_Counter + 1;
			if (TimeScale_2_DeBounce_Counter == 7999) TimeScale_2_Flag <= 1;
			else TimeScale_2_Flag <= 0;
			end
		else if (!TimeScale_2) 
			begin
			TimeScale_2_Flag <= 0;
			TimeScale_2_DeBounce_Counter <= 0;
			end
		else TimeScale_2_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for TimeScale_3 switch */
reg[12:0] TimeScale_3_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) TimeScale_3_Flag <= 0;
	else
		begin
		if (TimeScale_3 && !TimeScale_3_Flag)
			begin
			TimeScale_3_DeBounce_Counter <= TimeScale_3_DeBounce_Counter + 1;
			if (TimeScale_3_DeBounce_Counter == 7999) TimeScale_3_Flag <= 1;
			else TimeScale_3_Flag <= 0;
			end
		else if (!TimeScale_3) 
			begin
			TimeScale_3_Flag <= 0;
			TimeScale_3_DeBounce_Counter <= 0;
			end
		else TimeScale_3_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for TimeScale_4 switch */
reg[12:0] TimeScale_4_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) TimeScale_4_Flag <= 0;
	else
		begin
		if (TimeScale_4 && !TimeScale_4_Flag)
			begin
			TimeScale_4_DeBounce_Counter <= TimeScale_4_DeBounce_Counter + 1;
			if (TimeScale_4_DeBounce_Counter == 7999) TimeScale_4_Flag <= 1;
			else TimeScale_4_Flag <= 0;
			end
		else if (!TimeScale_4) 
			begin
			TimeScale_4_Flag <= 0;
			TimeScale_4_DeBounce_Counter <= 0;
			end
		else TimeScale_4_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for TimeScale_5 switch */
reg[12:0] TimeScale_5_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) TimeScale_5_Flag <= 0;
	else
		begin
		if (TimeScale_5 && !TimeScale_5_Flag)
			begin
			TimeScale_5_DeBounce_Counter <= TimeScale_5_DeBounce_Counter + 1;
			if (TimeScale_5_DeBounce_Counter == 7999) TimeScale_5_Flag <= 1;
			else TimeScale_5_Flag <= 0;
			end
		else if (!TimeScale_5) 
			begin
			TimeScale_5_Flag <= 0;
			TimeScale_5_DeBounce_Counter <= 0;
			end
		else TimeScale_5_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for Cursors_Enable switch */
reg[12:0] Cursors_Enable_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) Cursors_Enable_Flag <= 0;
	else
		begin
		if (Cursors_Enable && !Cursors_Enable_Flag)
			begin
			Cursors_Enable_DeBounce_Counter <= Cursors_Enable_DeBounce_Counter + 1;
			if (Cursors_Enable_DeBounce_Counter == 7999) Cursors_Enable_Flag <= 1;
			else Cursors_Enable_Flag <= 0;
			end
		else if (!Cursors_Enable) 
			begin
			Cursors_Enable_Flag <= 0;
			Cursors_Enable_DeBounce_Counter <= 0;
			end
		else Cursors_Enable_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for Cursor_Channel_Switch switch */
reg[12:0] Cursor_Channel_Switch_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) Cursor_Channel_Switch_Flag <= 0;
	else
		begin
		if (Cursor_Channel_Switch && !Cursor_Channel_Switch_Flag)
			begin
			Cursor_Channel_Switch_DeBounce_Counter <= Cursor_Channel_Switch_DeBounce_Counter + 1;
			if (Cursor_Channel_Switch_DeBounce_Counter == 7999) Cursor_Channel_Switch_Flag <= 1;
			else Cursor_Channel_Switch_Flag <= 0;
			end
		else if (!Cursor_Channel_Switch) 
			begin
			Cursor_Channel_Switch_Flag <= 0;
			Cursor_Channel_Switch_DeBounce_Counter <= 0;
			end
		else Cursor_Channel_Switch_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for Cursor_Channel_Switch switch */
reg[12:0] Cursor_Right_Left_Switch_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) Cursor_Right_Left_Switch_Flag <= 0;
	else
		begin
		if (Cursor_Right_Left_Switch && !Cursor_Right_Left_Switch_Flag)
			begin
			Cursor_Right_Left_Switch_DeBounce_Counter <= Cursor_Right_Left_Switch_DeBounce_Counter + 1;
			if (Cursor_Right_Left_Switch_DeBounce_Counter == 7999) Cursor_Right_Left_Switch_Flag <= 1;
			else Cursor_Right_Left_Switch_Flag <= 0;
			end
		else if (!Cursor_Right_Left_Switch) 
			begin
			Cursor_Right_Left_Switch_Flag <= 0;
			Cursor_Right_Left_Switch_DeBounce_Counter <= 0;
			end
		else Cursor_Right_Left_Switch_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for Cursor_Direction_Switch switch */
reg[12:0] Cursor_Direction_Switch_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) Cursor_Direction_Switch_Flag <= 0;
	else
		begin
		if (Cursor_Direction_Switch && !Cursor_Direction_Switch_Flag)
			begin
			Cursor_Direction_Switch_DeBounce_Counter <= Cursor_Direction_Switch_DeBounce_Counter + 1;
			if (Cursor_Direction_Switch_DeBounce_Counter == 7999) Cursor_Direction_Switch_Flag <= 1;
			else Cursor_Direction_Switch_Flag <= 0;
			end
		else if (!Cursor_Direction_Switch) 
			begin
			Cursor_Direction_Switch_Flag <= 0;
			Cursor_Direction_Switch_DeBounce_Counter <= 0;
			end
		else Cursor_Direction_Switch_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for Cursor_Moving_Button switch */
reg[12:0] Cursor_Moving_Button_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) Cursor_Moving_Button_Flag <= 0;
	else
		begin
		if (Cursor_Moving_Button && !Cursor_Moving_Button_Flag)
			begin
			Cursor_Moving_Button_DeBounce_Counter <= Cursor_Moving_Button_DeBounce_Counter + 1;
			if (Cursor_Moving_Button_DeBounce_Counter == 7999) Cursor_Moving_Button_Flag <= 1;
			else Cursor_Moving_Button_Flag <= 0;
			end
		else if (!Cursor_Moving_Button) 
			begin
			Cursor_Moving_Button_Flag <= 0;
			Cursor_Moving_Button_DeBounce_Counter <= 0;
			end
		else Cursor_Moving_Button_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for Move_Up_Down_Drawn_Signal switch */
reg[12:0] Move_Up_Down_Drawn_Signal_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) Move_Up_Down_Drawn_Signal_Flag <= 0;
	else
		begin
		if (Move_Up_Down_Drawn_Signal && !Move_Up_Down_Drawn_Signal_Flag)
			begin
			Move_Up_Down_Drawn_Signal_DeBounce_Counter <= Move_Up_Down_Drawn_Signal_DeBounce_Counter + 1;
			if (Move_Up_Down_Drawn_Signal_DeBounce_Counter == 7999) Move_Up_Down_Drawn_Signal_Flag <= 1;
			else Move_Up_Down_Drawn_Signal_Flag <= 0;
			end
		else if (!Move_Up_Down_Drawn_Signal) 
			begin
			Move_Up_Down_Drawn_Signal_Flag <= 0;
			Move_Up_Down_Drawn_Signal_DeBounce_Counter <= 0;
			end
		else Move_Up_Down_Drawn_Signal_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for Signal_Move_Button switch */
reg[12:0] Signal_Move_Button_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) Signal_Move_Button_Flag <= 0;
	else
		begin
		if (Signal_Move_Button && !Signal_Move_Button_Flag)
			begin
			Signal_Move_Button_DeBounce_Counter <= Signal_Move_Button_DeBounce_Counter + 1;
			if (Signal_Move_Button_DeBounce_Counter == 7999) Signal_Move_Button_Flag <= 1;
			else Signal_Move_Button_Flag <= 0;
			end
		else if (!Signal_Move_Button) 
			begin
			Signal_Move_Button_Flag <= 0;
			Signal_Move_Button_DeBounce_Counter <= 0;
			end
		else Signal_Move_Button_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for Cursor_Up_Down_Switch switch */
reg[12:0] Cursor_Up_Down_Switch_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) Cursor_Up_Down_Switch_Flag <= 0;
	else
		begin
		if (Cursor_Up_Down_Switch && !Cursor_Up_Down_Switch_Flag)
			begin
			Cursor_Up_Down_Switch_DeBounce_Counter <= Cursor_Up_Down_Switch_DeBounce_Counter + 1;
			if (Cursor_Up_Down_Switch_DeBounce_Counter == 7999) Cursor_Up_Down_Switch_Flag <= 1;
			else Cursor_Up_Down_Switch_Flag <= 0;
			end
		else if (!Cursor_Up_Down_Switch) 
			begin
			Cursor_Up_Down_Switch_Flag <= 0;
			Cursor_Up_Down_Switch_DeBounce_Counter <= 0;
			end
		else Cursor_Up_Down_Switch_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for Amplitude_Cursor_Direction_Switch switch */
reg[12:0] Amplitude_Cursor_Direction_Switch_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) Amplitude_Cursor_Direction_Switch_Flag <= 0;
	else
		begin
		if (Amplitude_Cursor_Direction_Switch && !Amplitude_Cursor_Direction_Switch_Flag)
			begin
			Amplitude_Cursor_Direction_Switch_DeBounce_Counter <= Amplitude_Cursor_Direction_Switch_DeBounce_Counter + 1;
			if (Amplitude_Cursor_Direction_Switch_DeBounce_Counter == 7999) Amplitude_Cursor_Direction_Switch_Flag <= 1;
			else Amplitude_Cursor_Direction_Switch_Flag <= 0;
			end
		else if (!Amplitude_Cursor_Direction_Switch) 
			begin
			Amplitude_Cursor_Direction_Switch_Flag <= 0;
			Amplitude_Cursor_Direction_Switch_DeBounce_Counter <= 0;
			end
		else Amplitude_Cursor_Direction_Switch_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for Amplitude_Cursor_Moving_Button switch */
reg[12:0] Amplitude_Cursor_Moving_Button_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) Amplitude_Cursor_Moving_Button_Flag <= 0;
	else
		begin
		if (Amplitude_Cursor_Moving_Button && !Amplitude_Cursor_Moving_Button_Flag)
			begin
			Amplitude_Cursor_Moving_Button_DeBounce_Counter <= Amplitude_Cursor_Moving_Button_DeBounce_Counter + 1;
			if (Amplitude_Cursor_Moving_Button_DeBounce_Counter == 7999) Amplitude_Cursor_Moving_Button_Flag <= 1;
			else Amplitude_Cursor_Moving_Button_Flag <= 0;
			end
		else if (!Amplitude_Cursor_Moving_Button) 
			begin
			Amplitude_Cursor_Moving_Button_Flag <= 0;
			Amplitude_Cursor_Moving_Button_DeBounce_Counter <= 0;
			end
		else Amplitude_Cursor_Moving_Button_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for Amplitude_Binary_[0] switches */
reg[12:0] Amplitude_Binary_0_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) Amplitude_Binary_Flag[0] <= 0;
	else
		begin
		if ((Amplitude_Binary[0]) && !Amplitude_Binary_Flag[0])
			begin
			Amplitude_Binary_0_DeBounce_Counter <= Amplitude_Binary_0_DeBounce_Counter + 1;
			if (Amplitude_Binary_0_DeBounce_Counter == 7999) Amplitude_Binary_Flag[0] <= 1;
			else Amplitude_Binary_Flag[0] <= 0;
			end
		else if (!Amplitude_Binary[0]) 
			begin
			Amplitude_Binary_Flag[0] <= 0;
			Amplitude_Binary_0_DeBounce_Counter <= 0;
			end
		else Amplitude_Binary_0_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for Amplitude_Binary_[1] switches */
reg[12:0] Amplitude_Binary_1_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) Amplitude_Binary_Flag[1] <= 0;
	else
		begin
		if ((Amplitude_Binary[1]) && !Amplitude_Binary_Flag[1])
			begin
			Amplitude_Binary_1_DeBounce_Counter <= Amplitude_Binary_1_DeBounce_Counter + 1;
			if (Amplitude_Binary_1_DeBounce_Counter == 7999) Amplitude_Binary_Flag[1] <= 1;
			else Amplitude_Binary_Flag[1] <= 0;
			end
		else if (!Amplitude_Binary[1]) 
			begin
			Amplitude_Binary_Flag[1] <= 0;
			Amplitude_Binary_1_DeBounce_Counter <= 0;
			end
		else Amplitude_Binary_1_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for Amplitude_Binary_[2] switches */
reg[12:0] Amplitude_Binary_2_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) Amplitude_Binary_Flag[2] <= 0;
	else
		begin
		if ((Amplitude_Binary[2]) && !Amplitude_Binary_Flag[2])
			begin
			Amplitude_Binary_2_DeBounce_Counter <= Amplitude_Binary_2_DeBounce_Counter + 1;
			if (Amplitude_Binary_2_DeBounce_Counter == 7999) Amplitude_Binary_Flag[2] <= 1;
			else Amplitude_Binary_Flag[2] <= 0;
			end
		else if (!Amplitude_Binary[2]) 
			begin
			Amplitude_Binary_Flag[2] <= 0;
			Amplitude_Binary_2_DeBounce_Counter <= 0;
			end
		else Amplitude_Binary_2_DeBounce_Counter <= 0;
		end
	end
//====================================
/** Debouncer for Guide switch */
reg[12:0] Guide_DeBounce_Counter;
always @(posedge Main_CLK)
	begin
	if (!Reset_Activated) Guide_Flag <= 0;
	else
		begin
		if (Guide && !Guide_Flag)
			begin
			Guide_DeBounce_Counter <= Guide_DeBounce_Counter + 1;
			if (Guide_DeBounce_Counter == 7999) Guide_Flag <= 1;
			else Guide_Flag <= 0;
			end
		else if (!Guide) 
			begin
			Guide_Flag <= 0;
			Guide_DeBounce_Counter <= 0;
			end
		else Guide_DeBounce_Counter <= 0;
		end
	end
endmodule 