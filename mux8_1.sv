///////////////////////////////////////////////////////////////////////////////////////////////////
// Module: mux8_1.v
// Description: 8:1 multiplexer
// Implmentation: Goal is to use 8:1 multiplexer to pass out bit according to select/control line
// 
// Inputs:
// 	- [2:0] sel: 3 bit select/control line that determines what bit is outputted
// 	- [7:0] in: 8 bit input that will be muxed 
//	
// Outputs:
// 	- out: 1 bit output muxed from 8 bit input
//
// TODO: make a testbench.
// Change history:
//
///////////////////////////////////////////////////////////////////////////////////////////////////

module mux8_1(in, out, sel);
		input [2:0] sel;
		input [7:0] in; 
		output out;
		
		wire a, b;
		
		mux4 muxa(.sel(sel[1:0]), .in(in[3:0]), .out(a));
		mux4 muxb(.sel(sel[1:0]), .in(in[7:4]), .out(b));
		
		mux2_1 muxc(.a(a), .b(b), .out(out), .sel(sel[2]));
		
endmodule

// Test bench for 8:1 mux
`timescale 1ns/10ps 

module mux8_1_testbench();
		reg [2:0] sel;
		reg [7:0] in; 
		wire out;
		
		mux8_1 dut (in, out, sel);
		
		integer i;
		
		initial begin
			in = 8'b11010101; #10;
			for (i=0; i<8; i++) begin: eachMux
				sel = i;	#10;
			end
			
		end
endmodule