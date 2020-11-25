//Name : Sumit Kumar Yadav (18CS30042)
//Name : Avijit Mandal (18CS30010)
// Code your testbench here
// or browse Examples

module test_bench;
	reg [31:0] n1;
	reg [31:0] n2;
	reg clk, reset;
	wire [31:0] out;
	wire D;
	
	gcd m1 (n1,n2,out,D,clk,reset);

	initial begin
	
		$monitor("num1 = %d, num2 = %d, GCD(num1,num2) = %d",n1, n2, out); // printing_GCD of n1 and n2
		n1 = 32'd0;
		n2 = 32'd0;
		clk = 0;
		reset = 1;
		#10;
		reset = 0;
		#10;
		n1 = 32'd121;
		n2 = 32'd11;
		
		#500; 
		$finish;
	end
	
	always #5 clk = ~clk;
	 
endmodule



