//Name : Sumit Kumar Yadav (18CS30042)
//Name : Avijit Mandal (18CS30010)
// Code your testbench here
// or browse Examples

module tst;
  reg clk,reset;
  reg [7:0]x;
  reg [2:0]pos;
  wire out;
  two_complement m1(clk,reset,x[pos],out);
    initial begin
      $monitor("time = %t        x = %b, pos = %d , out = %b",$time,x,pos,out);
        x = 8'b01010100;
      	pos = 3'b000;
      	reset = 1'b1;
    	clk = 1'b1;
      	#2 reset = 0;
        #75 $finish;
    end
    always #5 clk = ~ clk;
  	always #10 pos = pos + 1;
endmodule
