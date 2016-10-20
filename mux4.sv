`timescale 1ns/10ps

// 4:1 mux
module mux4(sel, in, out);
	input[1:0] sel; // 2
	input[3:0] in; // 4
	output out;
	wire out, out1, out2, out3, out4;
	wire[1:0] sel;
	wire[3:0] in;
	wire NOTsel0, NOTsel1;

	not #0.05 n1(NOTsel0, sel[0]);
	not #0.05 n2(NOTsel1, sel[1]);
	
	and #0.05 a1(out1, NOTsel0, NOTsel1, in[0]);
	and #0.05 a2(out2,  sel[0], NOTsel1, in[1]);
	and #0.05 a3(out3, NOTsel0,  sel[1], in[2]);
	and #0.05 a4(out4,  sel[0],  sel[1], in[3]);
	
	or #0.05 o1(out, out1, out2, out3, out4);
endmodule 


// Test bench for 4:1 mux
module mux4_testbench();           
	reg [1:0] sel; 
	reg [3:0] in; 
	wire out;      
	
	mux4 dut(.sel, .in, .out);
	
	integer i;
	initial begin            
		for(i=0; i<2**6; i++) begin
			{sel, in} = i; #10;       
		end            
	end            
endmodule      