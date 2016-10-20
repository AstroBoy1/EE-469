// this module checks the ouput of the alu for
// zero, overflow, carryout, and negative

module flagCheck(bits, zero, over, cOut, neg, cout64, cin64);
	input [63:0] bits; // the output bits from an alu operation
	input cin64, cout64; // carry out from 64th bit
	output zero, over, cOut, neg; // zero, overflow, carryout, negative
	wire [63:0] value; // value used in noring each bit for checking if zero
	
	// zero check: true if every bit is zero
	and andValue(value[0], bits[0], 1);
	genvar i;
	generate
		for(i=1; i<=63; i++) begin : eachPair
			nor bitNor(value[i], value[i-1], bits[i]);
		end
	endgenerate
	assign zero = value[63];
	
	// over flow check: xor of carry in and carry out of 64th bit
	xor cinXcout(over, cin64, cout64);
	
	// carryout check: true if their is a carry out from the 64th bit
	assign cOut = cout64;
	
	// negative check: true if the 64th bit is a 1
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
		for (i=0; i<2**2; i++) begin
			{cin64, cout64} = i; #10;
			bits = 64'h0000000000000000; #10; // bits all zero
			bits = 64'hffffffffffffffff; #10; // bits all 1
			bits = i * 64'hffbf1fffff2fff0f; #10; // some random bits
		end
	end
endmodule