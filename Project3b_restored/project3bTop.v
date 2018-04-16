////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename: project3bTop.v
// Author:   Colin Grundey
// Date:     4 April 2018
// Revision: 1
//
// This is the top-level module for ECE 3544 Project 3b.
// Do not modify the module declaration or ports in this file.
// When synthesizing to the DE1-SoC, this file should be used with the provided
// Quartus project so that the FPGA pin assignments are made correctly.
//
// YOU MUST MAKE THE PIN ASSIGNMENTS FOR THE INPUTS AND OUTPUTS OF THIS MODULE.
// FOLLOW THE INSTRUCTIONS IN THE DOCUMENT ON PIN PLACEMENT.
// CONSULT THE DE1-SOC MANUAL FOR INFORMATION ON THE PIN LOCATIONS.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module project3bTop(CLOCK_50, SW, KEY, HEX3, HEX2, HEX1, HEX0);
   input         CLOCK_50;						// 50 MHz FPGA Clock
	input   [6:0] SW;								// Switch SW[6] permits the display of the Student ID Number.
														// Switch SW[5] determines the mode.
														// Switch SW[4] determines the direction.
														// Switch SW[3:0] determines the count value.
	input   [1:0] KEY;							// KEY[1] is the system reset.
														// KEY[0] provides the enable input
	output  [6:0] HEX3, HEX2, HEX1, HEX0;	// These are the seven-segment display driver outputs for the COUNT VALUE.

   wire          enable;						// The buttonpressed pulse_out drives the FSM enable input.
   wire   [15:0] hexDigits;					// The FSM output drives the seven-segment display driver inputs.
		
	// Compare the instantiation of the two state machines to their module declarations.
	// Use this comparison to verify that the I/O interface matches the block diagram in the spec.
	
	buttonpressed U1(CLOCK_50, KEY[1], KEY[0], enable);
	fsm16bit      U2(CLOCK_50, KEY[1], enable, SW[6], SW[5], SW[4], SW[3:0], hexDigits); 
	
	// Display Drivers
	seven_segment_display_driver_cgrundey D1(hexDigits[15:12], HEX3);
	seven_segment_display_driver_cgrundey D2(hexDigits[11:8], HEX2);
	seven_segment_display_driver_cgrundey D3(hexDigits[7:4], HEX1);
	seven_segment_display_driver_cgrundey D4(hexDigits[3:0], HEX0);
	
	
endmodule
