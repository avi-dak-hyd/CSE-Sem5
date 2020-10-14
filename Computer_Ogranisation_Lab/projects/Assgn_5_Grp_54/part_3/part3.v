//carry select adder

module carry_select_adder(a, b, cin, sum, cout);
	input [15:0] a,b;
	input cin;
	output [15:0] sum;
	output cout;

	wire [2:0] c;

	ripple_carry_adder_4_bit rca1(
		.a(a[3:0]),
		.b(b[3:0]),
		.cin(cin),
		.sum(sum[3:0]),
		.cout(c[0]));

	carry_select_adder_4bit_block csa_block_1(
		.a(a[7:4]),
		.b(b[7:4]),
		.cin(c[0]),
		.sum(sum[7:4]),
		.cout(c[1]));

	carry_select_adder_4bit_block csa_block_2(
		.a(a[11:8]),
		.b(b[11:8]),
		.cin(c[1]),
		.sum(sum[11:8]), 
		.cout(c[2]));

	carry_select_adder_4bit_block csa_block_3(
		.a(a[15:12]),
		.b(b[15:12]),
		.cin(c[2]),
		.sum(sum[15:12]),
		.cout(cout));
endmodule

//carry select adder each block

module carry_select_adder_4bit_block(a, b, cin, sum, cout);
	input [3:0] a,b;
	input cin;
	output cout;
	output [3:0] sum;

	wire w0,w1;
	wire [3:0] x1,x2;

	ripple_carry_adder_4_bit rca1(
		.a(a[3:0]),
		.b(b[3:0]),
		.cin(1'b0),
		.sum(x1[3:0]),
		.cout(w0));

	ripple_carry_adder_4_bit rca2(
		.a(a[3:0]),
		.b(b[3:0]),
		.cin(1'b1),
		.sum(x2[3:0]),
		.cout(w1));

	mux_2X1 #(4) mux_0(
		.input_0(x1[3:0]),
		.input_1(x2[3:0]),
		.selection(cin),
		.output_1(sum[3:0]));

	mux_2X1 #(1) mux_1(
		.input_0(w0),
		.input_1(w1),
		.selection(cin),
		.output_1(cout));
endmodule

//Ripple carry adder

module ripple_carry_adder_4_bit(a, b, cin, sum, cout);
	input [3:0] a,b;
	input cin;
	output [3:0] sum;
	output cout;

	wire w1,c2,c3;

	full_adder fa_0(
		.a(a[0]),
		.b(b[0]),
		.cin(cin),
		.sum(sum[0]),
		.cout(w1));

	full_adder fa_1(
		.a(a[1]),
		.b(b[1]),
		.cin(w1),
		.sum(sum[1]),
		.cout(c2));

	full_adder fa_2(
		.a(a[2]),
		.b(b[2]),
		.cin(c2),
		.sum(sum[2]),
		.cout(c3));

	full_adder fa_3(
		.a(a[3]),
		.b(b[3]),
		.cin(c3),
		.sum(sum[3]),
		.cout(cout));
endmodule

//MUX 2X1

module mux_2X1( input_0, input_1, selection, output_1);
	parameter width=16; 
	input selection;
	input [width-1:0] input_0,input_1;
	output [width-1:0] output_1;
	assign output_1=(selection)?input_1:input_0;
endmodule


//Full Adder

module full_adder(a,b,cin,sum, cout);
	input a,b,cin;
	output sum, cout;
	wire p,q,r;
	half_adder ha_1(.a(a), .b(b), .sum(p), .cout(q));
	half_adder ha_2(.a(p), .b(cin), .sum(sum), .cout(r));
	or or_01(cout,r,q);
endmodule

//Half Adder

module half_adder( a,b, sum, cout );
	input a,b;
	output sum, cout;
	xor xor_01 (sum,a,b);
	and and_01 (cout,a,b);
endmodule