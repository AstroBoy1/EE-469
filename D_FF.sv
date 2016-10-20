module D_FF (q, d, reset, clk);
	output reg q;
	input d, reset, clk;
	always_ff @(posedge clk)
	if (reset)
	q <= 0; // On reset, set to 0
	else
	q <= d; // Otherwise out = d
endmodule

module  D_FF_testbench();
	reg d, reset, clk;
	wire q;
	
	// Set up the clock.
	parameter CLOCK_PERIOD=2;
	initial clk=1;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	
	D_FF dut (q, d, reset, clk);
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
														
		reset = 1; d = 0;	@(posedge clk);
								@(posedge clk);
		reset = 0;			@(posedge clk);
		d = 1;				@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		d = 0;				@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		d = 1;				@(posedge clk);
								@(posedge clk);
		
																										
		$stop; // End the simulation.
	end
endmodule