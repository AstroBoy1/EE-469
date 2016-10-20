`timescale 1ns/10ps
///////////////////////////////////////////////////////////////////////////////////////////////////
// Module: alu_1bit.sv
// Description: One alu module that takes in a bit from bus a and a bit from bus b
// and a control signal to perform one of the operations below:
//
// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant
//
// Implmentation: Goal is to use generate statement to create the 64 bit alu from 64, 1 bit alu
// 
// Inputs:
// 	- [1:0] in: 2 bits to be added in the full adder 
// 	- cin: carry in from the add of the 2 previous bits 
//	
// Outputs:
// 	- s: sum from the add of 2 bits
//	 	- cout: carry out from the add of 2 bits 
//
// TODO: assign, equals, and with 1, initial begin, always_comb?
// TODO: implement a+b, a-b with adder and muxes
///
// Change history:
//
///////////////////////////////////////////////////////////////////////////////////////////////////
module alu_1bit(a, b, cin, cout, out, control);
	input a, b, cin; //Bus A, Bus B, carry in
	input [2:0] control; //control signal
	output cout, out; //carry out, output
	
	// wire [1:0] carryOut; // all carry outs {Why have [1:0] carryOut wire?}
	
	wire complement, computation, notb, complementb, temp;
	wire [7:0] results; // all resulting operations
	
	// 000 b
	assign results[0] = b;
	
	// 010 a+b and 011 a-b implemented with full adder and 2:1 mux 
	not TheNotGate0 (notb, b); // Inverts b as 1 input to 2:1 mux  
	// Full_Adder bcomplement(.s(complementb), .c(coutComplement), .in({complementb, 1}))
	
	mux2_1 addorsub(.a(b), .b(notb), .out(complement), .sel(control[0])); // 2:1 mux to determine whether addition or subtraction
	
	Full_Adder addsub(.in({a,complement}), .cin(cin), .s(computation), .cout(cout));  // Full adder performs addition
	assign results[2] = computation;
	assign results[3] = computation;
	
	// 100 a&b
	and #0.05 aANDb(results[4], a, b);
	
	// 101 a|b
	or #0.05 aORb(results[5], a, b);
	
	// 110 a^b
	xor #0.05 xorGate(results[6], a, b);
	
	// Assign results[7] and results [1] don't care
	assign results[7] = 1'bx;
	assign results[1] = 1'bx;
	
	// 8:1 mux that determines what is outputted from the 1 bit slice ALU 
	mux8_1 outALU(.in(results), .out(out), .sel(control));
	
endmodule

// alu testbench module
module alu_1bit_testbench();
	reg a, b, cin; //Bus A, Bus B, carry in
	wire cout, out; //carry out, output
	reg [2:0] control; //control signal
	
	alu_1bit dut(.a, .b, .cin, .cout, .out, .control);
	
	integer i;
	initial begin
		for (i=0; i<2**6; i++) begin
			{a, b, cin, control[0], control[1], control[2]} = i; #10;
		end
	end
endmodule