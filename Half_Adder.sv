///////////////////////////////////////////////////////////////////////////////////////////////////
// Module: Half_Adder.v
// Description: Half Adder
// Implmentation: Goal is to use Half Adder to create a Full Adder
// 
// Inputs:
// 	- i0: 3 bit select/control line that determines what bit is outputted
// 	- i1: 8 bit input that will be muxed 
//	
// Outputs:
// 	- s: the sum bit from the xor of i0 and i1 
//		- c: the carry out bit from the and of i0 and i1
//
// TODO: make a testbench.
// Change history:
//
///////////////////////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/10ps 
module Half_Adder (s, c, in);
	input [1:0] in;
	output s,c; 
	
	xor #0.05 sum(s, in[0], in[1]); 
	and #0.05 carryOut(c, in[0], in[1]); 
	
endmodule

// Test bench for Half_Adder
module Half_Adder_testbench();
		reg [1:0] in;
		wire s,c;
		
		Half_Adder dut (s, c, in);
		
		integer i;
		
		initial begin
			
			for (i=0; i<4; i++) begin: eachMux
				in = i; #0.1;
			end
			
		end
endmodule