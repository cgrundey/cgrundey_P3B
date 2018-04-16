
// Filename:	seven_segment_display_driver_cgrundey.v
// Author:		Colin Grundey
// Date:			29 March 2018
// Version:		1
// Description: Generates 7-bit output to display corresponding 
//              to given 4-bit decimal number.

module seven_segment_display_driver_cgrundey(hex_digit, hex_display);
	input [3:0] hex_digit;
	output [6:0] hex_display;

	assign hex_display = (hex_digit == 4'h0) ? (7'b1000000) :
								(hex_digit == 4'h1) ? (7'b1111001) :
								(hex_digit == 4'h2) ? (7'b0100100) :
								(hex_digit == 4'h3) ? (7'b0110000) :
								(hex_digit == 4'h4) ? (7'b0011001) :
								(hex_digit == 4'h5) ? (7'b0010010) :
								(hex_digit == 4'h6) ? (7'b0000010) :
								(hex_digit == 4'h7) ? (7'b1111000) :
								(hex_digit == 4'h8) ? (7'b0000000) :
								(hex_digit == 4'h9) ? (7'b0011000) :
								(hex_digit == 4'hA) ? (7'b0001000) :
								(hex_digit == 4'hB) ? (7'b0000011) :
								(hex_digit == 4'hC) ? (7'b1000110) :
								(hex_digit == 4'hD) ? (7'b0100001) :
								(hex_digit == 4'hE) ? (7'b0000110) :
								(hex_digit == 4'hF) ? (7'b0001110) : (7'bxxxxxxx);

endmodule 