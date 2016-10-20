///////////////////////////////////////////////////////////////////////////////////////////////////
// Module: mux8_1.v
// Description: 8:1 multiplexer
// Implmentation: Goal is to use 8:1 multiplexer to pass out bit according to select/control line
// 
// Inputs:
// 	- [1:0] in: 2 bits to be added in the full adder 
// 	- cin: carry in from the add of the 2 previous bits 
//	
// Outputs:
// 	- s: sum from the add of 2 bits
//	 	- cout: carry out from the add of 2 bits 
//
// TODO: make a testbench.
// Change history:
//
///////////////////////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/10ps 

module Full_Adder (in, cin, s, cout);
	input [1:0] in;
	input cin;
	output s,cout;
	
	wire s1, c1, c2; 
	
	//internal nodes also declared as wires wire cin,x,y,s,cout,s1,c1,c2;
	Half_Adder HA1(.s(s1), .c(c1), .in(in));  
	Half_Adder HA2(.s(s), .c(c2), .in({s1,cin})); 
	or #0.05 (cout, c1, c2);

endmodule

// Test bench for Full_Adder
module Full_Adder_testbench();
		reg [1:0] in;
		reg cin;
		wire s,cout;
		
		Full_Adder dut (in, cin, s, cout);
		
		initial begin
			in = 00; cin = 0; #0.2;
			in = 00; cin = 1; #0.2;
			in = 01; cin = 0; #0.2;
			in = 01; cin = 1; #0.2;
			in = 10; cin = 0; #0.2;
			in = 10; cin = 1; #0.2;
			in = 11; cin = 0; #0.2;
			in = 11; cin = 1; #0.2;
			
		end
endmodule
