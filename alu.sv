// One alu module that takes in a bit from bus a and a bit from bus b
// and a control signal to perform an operation.

// TODO: assign, equals, and with 1, initial begin, always_comb?
// TODO: implement a+b, a-b with adder and muxes

module alu(a, b, cin, cout, out, control);
	input a, b, cin; //Bus A, Bus B, carry in
	output cout, out; //carry out, output
	input [2:0] control; //control signal
	wire [1:0] carryOut; // all carry outs
	wire [7:0] results; // all resulting operations
	
	// 000 b
	assign results[0] = b;
	
	// 010 a+b, TO DO: implement these with adder
	assign results[2] = 0;
	assign carryOut[0] = 0;
	
	// 011 a-b, TO DO: implement these with adder
	assign results[3] = 0;
	assign carryOut[1] = 0;

	// 100 a&b
	and aANDb(results[4], a, b);
	
	// 101 a|b
	or aORb(results[6], a, b);
	
	// 110 a^b
	xor xorGate(results[6], a, b);
endmodule

// alu testbench module
module alu_testbench();
	reg a, b, cin; //Bus A, Bus B, carry in
	wire cout, out; //carry out, output
	reg [2:0] control; //control signal
	
	alu dut(.a, .b, .cin, .cout, .out, .control);
	
	integer i;
	initial begin
		for (i=0; i<2**6; i++) begin
			{a, b, cin, control[0], control[1], control[2]} = i; #10;
		end
	end
endmodule