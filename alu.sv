// this module instantiates 64 alu_1bit modules
// each one is the same, except the first one which takes a carry in of 1 for bus b if doing a subtract
// TODO: tbd

module alu(A, B, cntrl, result, negative, zero, overflow, carry_out); // a, b, cin, out, cin64, control
	input [63:0] A, B; //Bus A, Bus B,
	// input cin;  // carry in
	input [2:0] cntrl; //control signal
	// output cin64; // 64th bit carry out, 64th bit carry in
	output [63:0] result; // 64 bit output
	output negative, zero, overflow, carry_out;
	
	wire [63:0] cout; // each carry out
	
	alu_1bit zeroALU(.a(A[0]), .b(B[0]), .cin(cntrl[0]), .cout(cout[0]), .out(result[0]), .control(cntrl));
	
	genvar i;
	generate
		for(i=1; i<=62; i++) begin: eachPair
			alu_1bit eachALU(.a(A[i]), .b(B[i]), .cin(cout[i-1]), .cout(cout[i]), .out(result[i]), .control(cntrl));
		end
	endgenerate
	
	alu_1bit ALU63(.a(A[63]), .b(B[63]), .cin(cout[62]), .cout(cout[63]), .out(result[0]), .control(cntrl));
	
	flagCheck flags(.bits(result), .zero(zero), .over(overflow), .cOut(carry_out), .neg(negative), .cout64(cout[63]), .cin64(cout[62]));
endmodule

// Test bench for ALU
`timescale 1ns/10ps

// Meaning of signals in and out of the ALU:

// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

module alustim();

	parameter delay = 100000;

	logic		[63:0]	A, B;
	logic		[2:0]		cntrl;
	logic		[63:0]	result;
	logic					negative, zero, overflow, carry_out ;

	parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
	

	alu dut (.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	integer i;
	logic [63:0] test_val;
	initial begin
	
		$display("%t testing PASS_A operations", $time);
		cntrl = ALU_PASS_B;
		for (i=0; i<100; i++) begin
			A = $random(); B = $random();
			#(delay);
			assert(result == B && negative == B[63] && zero == (B == '0));
		end
		
		$display("%t testing addition", $time);
		cntrl = ALU_ADD;
		A = 64'h0000000000000001; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h0000000000000002 && carry_out == 0 && overflow == 0 && negative == 0 && zero == 0);
		
	end
endmodule