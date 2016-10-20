`timescale 1ns/10ps 

// 2:1 mux 
// a = 0, b = 1; 
module mux2_1(a, b, out, sel);
		input a, b, sel;
		output out;
		
		wire out1, out2, selb;

		and #0.05 a1 (out1, b, sel); 
		not #0.05 i1 (selb, sel); 
		and #0.05 a2 (out2, a , selb); 
		or #0.05 o1 (out, out1, out2);
		
endmodule

module mux2_1_testbench();
		reg a, b, sel;
		wire out;
		
		mux2_1 dut (.a, .b, .out, .sel);
		
		initial begin
				sel=0; a=0; b=0; #10;
				sel=0; a=0; b=1; #10;
				sel=0; a=1; b=0; #10;
				sel=0; a=1; b=1; #10;
				sel=1; a=0; b=0; #10;
				sel=1; a=0; b=1; #10;
				sel=1; a=1; b=0; #10;
				sel=1; a=1; b=1; #10;
		end
endmodule