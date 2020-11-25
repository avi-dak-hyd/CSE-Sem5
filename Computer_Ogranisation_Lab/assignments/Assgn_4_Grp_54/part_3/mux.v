//Name : Sumit Kumar Yadav (18CS30042)
//Name : Avijit Mandal (18CS30010)

module mux(input select,input [31:0] i0, i1,output [31:0] out);
	assign out = (select==0) ? i0 : i1;
endmodule
