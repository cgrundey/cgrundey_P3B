////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    fsm16bit.v
// Author:      Colin Grundey
// Date:        4 April 2018
// Version:     1
// Description: A 16-bit synchronous FSM Project 3B. Has counter mode, shift 
//					 register mode, reset, and can display last 4 digits of PID.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//     fsm16bit(CLOCK_50, KEY[1], enable, SW[6], SW[5],     SW[4], SW[3:0], hexDigits);
module fsm16bit(clock,     reset, enable, check,  mode, direction,   value, count);
	input         clock, reset;
	input         enable, check, mode, direction;
	input   [3:0] value;
	output [15:0] count;
	reg    [15:0] counter_state;

	
	always @(posedge clock or negedge reset) begin

		if(reset == 1'b0)
			counter_state <= 16'b0;

		else if(enable) begin
		   
			if (check)
				counter_state <= 16'h1382; // Last 4-digits of PID
			
			else begin
				if (mode) // counter mode
					counter_state <= (direction) ? counter_state - {12'h000, value} :
															 counter_state + {12'h000, value} ;
				
				else // shift register mode
					counter_state <= (direction) ? counter_state >> 1 :
															 counter_state << 1 ;
			end
		end
		
	end
	
	assign count = counter_state; 

endmodule
