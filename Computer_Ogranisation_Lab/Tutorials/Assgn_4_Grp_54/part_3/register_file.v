//Name : Sumit Kumar Yadav (18CS30042)
//Name : Avijit Mandal (18CS30010)

module register_file(input clk,input reset,input load,input [31:0] data,output reg [31:0] out);
	
	always@(posedge clk)
		begin
			if(reset == 1) begin
				out <= 0;
			end else if(load == 1) begin
				out <= data;
			end else begin
				out <= out;
			end
		end

endmodule
