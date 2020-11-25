//Name : Sumit Kumar Yadav (18CS30042)
//Name : Avijit Mandal (18CS30010)


module gcd(input [31:0] n1,input[31:0] n2,output [31:0] out,output reg D,input clk,input reset);


	wire xsel, ysel, xload, yload, load, eqflag, ifflag;
	wire d;
	
	// instantitaing flip flop 
	always @(posedge clk) begin
		D <= d;
	end
	
	control m1(clk,reset,eqflag,ifflag,d,xload,yload,xsel,ysel,load);
	datapath m2(clk,reset,xsel,ysel,xload,yload, gcdload,n1, n2,eqflag,ifflag,out);
	
endmodule
