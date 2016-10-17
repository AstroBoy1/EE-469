// this module checks the ouput of the alu for
// zero, overflow, carryout, and negative

// TODO: assign, equals, and with 1, initial begin, always_comb?

module flagCheck(bits, zero, over, cOut, neg, cout64, cin64);
	input [63:0] bits; // the output bits from an alu operation
	input cin64, cout64; // carry out from 64th bit
	output zero, over, cOut, neg; // zero, overflow, carryout, negative
	wire value; // value used in noring each bit for checking if zero
	
	// true if every bit is zero
	initial begin
	value = bits[0];
	end
	
	genvar i;
	generate
		for(i=1; i<=63; i++) begin: eachPair
			nor bitNor(value, value, bits[i]);
		end
	endgenerate
	
	initial begin
	zero = value;
	end
	
	// xor of carry in and carry out of 64th bit
	xor cinXcout(over, cin64, cout64);
	
	// true if their is a carry out from the 64th bit
	assign cOut = cout64;
	
	// true if the 64th bit is a 1
	assign neg = bits[63];
endmodule

// flagCheck testbench module
module flagCheck_testbench();
	reg [63:0] bits; // the output bits from an alu operation
	reg cin64, cout64; // carry out from 64th bit
	wire zero, over, cOut, neg; // zero, overflow, carryout, negative
	
	flagCheck dut(.bits, .zero, .over, .cOut, .neg, .cout64, .cin64);
	
	integer i;
	initial begin
		for (i=0; i<2**66; i++) begin
			{cin64, cout64, bits} = i; #10;
		end
	end
endmodule