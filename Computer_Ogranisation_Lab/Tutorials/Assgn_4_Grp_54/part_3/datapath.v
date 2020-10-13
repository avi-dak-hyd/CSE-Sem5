//Name : Sumit Kumar Yadav (18CS30042)
//Name : Avijit Mandal (18CS30010)


module datapath(input clk,input reset,input xsel,input ysel,input xload,input yload,input load,input [31:0]n1,input[31:0] n2,output reg eq,output reg ifdecider,output [31:0]gcd);
	
	wire [31:0] xregout, yregout;
	wire [31:0] xmuxout, ymuxout;
	wire [31:0] xtemp, ytemp;
	
	register_file XR(clk,reset,xload,xmuxout,xregout);
	register_file YR(clk,reset,yload,ymuxout,yregout);
	register_file GCDR(clk,reset,load,xregout,gcd);
	 
	always@ (xregout or yregout)
	begin
		if(xregout < yregout) begin
			ifdecider <= 1'b1;
		end
		else begin
			ifdecider <= 1'b0;
		end
	end
	
	always@ (xregout or yregout)
	begin
		if((xregout == yregout) & (reset == 1'b0))
			begin
				eq <= 1'b1;
			end
		else
			begin
				eq <= 1'b0;
			end
	 end
	 
	assign xtemp = xregout - yregout;
	assign ytemp = yregout - xregout;
	mux X(xsel,xtemp, n1,xmuxout);
	mux Y(ysel,ytemp, n2,ymuxout); 

endmodule
