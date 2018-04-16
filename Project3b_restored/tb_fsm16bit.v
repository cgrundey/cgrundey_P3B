////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename:    tb_fsm16bit.v
// Author:      Colin Grundey
// Date:        4 April 2018
// Version:     1
// Description: FSM testbench.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/100 ps

module tb_fsm16bit();
	reg         reset, clock;
	reg         enable, check, mode, direction;
	reg   [3:0] value;
	wire [15:0] count;
	
	parameter MYDEL = 10; // 50MHz
	
	always begin
		#MYDEL;
		clock = ~clock;
	end 
	
	// Instantiate counter.
	fsm16bit dut(clock, reset, enable, check, mode, direction, value, count);	
			
	initial begin
		
		reset = 1'b0;
		#5;
		reset = 1'b1;
				
		clock = 1'b1;
		
		check = 1'b1;
		mode = 1'b0;
		direction = 1'b0;
		value = 4'b0000;
		
		enable = 1'b1;
		#MYDEL;
		enable = 1'b0;
		// Count should be 16'h1382
		
		check = 1'b0;
		mode = 1'b1;
		direction = 1'b0;
		value = 4'b0110;
		//Increment by 6
		
		//KEY[0] press 5 times
		repeat(5) begin
			enable = 1'b1;
			#MYDEL;
			enable = 1'b0;
			#MYDEL;
		end
		
		reset = 1'b0;
		#MYDEL;
		reset = 1'b1;
		#MYDEL;
		
		check = 1'b0;
		mode = 1'b1;
		direction = 1'b1;
		value = 4'b0011;
		// decrement by 3
		
		//KEY[0] press 5 times
		repeat(5) begin
			enable = 1'b1;
			#MYDEL;
			enable = 1'b0;
			#MYDEL;
		end
		
		check = 1'b0;
		mode = 1'b0;
		direction = 1'b0;
		// shift left

		//KEY[0] press 5 times
		repeat(5) begin
			enable = 1'b1;
			#MYDEL;
			enable = 1'b0;
			#MYDEL;
		end
		
		check = 1'b0;
		mode = 1'b0;
		direction = 1'b1;
		// shift right
		
		//KEY[0] press 5 times
		repeat(5) begin
			enable = 1'b1;
			#MYDEL;
			enable = 1'b0;
			#MYDEL;
		end
		
		
		// Custom Tests
		
		check = 1'b1;
		mode = 1'b0;
		direction = 1'b1;
		// shift right but check is enabled
		
		// shift right
		repeat(4) begin
			enable = 1'b1;
			#MYDEL;
			enable = 1'b0;
			#MYDEL;
		end
		// Cant shift right because check is enabled
		
		reset = 1'b0;
		#MYDEL;
		reset = 1'b1;
		#MYDEL;
		
		check = 1'b0;
		mode = 1'b1;
		direction = 1'b0; 
		value = 4'b0001;
		// increment by 1
		
		enable = 1'b1;
		#MYDEL;
		enable = 1'b0;
		#MYDEL;
		
		mode = 1'b0;
		// shift left 4 times
		
		repeat(4) begin
			enable = 1'b1;
			#MYDEL;
			enable = 1'b0;
			#MYDEL;
		end
		
		
	end

endmodule
