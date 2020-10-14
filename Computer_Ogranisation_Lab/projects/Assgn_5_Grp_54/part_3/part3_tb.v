module carry_select_adder_tb;
	reg [15:0] a,b;
	reg cin;
	wire [15:0] sum;
	wire cout;
	 
	carry_select_adder uut(.a(a), .b(b),.cin(cin),.sum(sum),.cout(cout));
	 
	initial begin
	//input_1
	  a=0; b=0; cin=0;
	//input_2
	  #10 a=16'd5; b=16'd10; cin=1'd0;
	//input_3
	  #10 a=16'd12; b=16'd12; cin=1'd1;
	//input_4
	  #10 a=16'd500; b=16'd1000; cin=1'd1;
	//input_5
	  #10 a=16'd999; b=16'd43; cin=1'd0;
	//input_6
	  #10 a=16'd2000; b=16'd20430; cin=1'd1;
	//input_7
	  #10 a=16'd65000; b=16'd100; cin=1'd0;
	//input_8
	  #10 a=16'd28000; b=16'd250; cin=1'd1;
	//input_9
	  #10 a=16'd65500; b=16'd65000; cin=1'd0;
	end
	 
	initial
	  $monitor( "A=%d,  B=%d,  Cin= %d,  Sum=%d,  Carry=%d", a,b,cin,sum,cout);
endmodule
//the 17th bit in the sum is equal to the carry bit.
//carry is 1 means overflow happens and output crosses 16 bit. now the ans is 17 bit where 16 bit is from sum variable and 1 bit is from carry variable. 