module full_Adder(A,B,c_in,sum,c_out);
    input A,B,c_in;
    output wire sum,c_out;
    assign sum = A^B^c_in;
    assign c_out = (A&B) + (c_in & (A^B));    
    
endmodule

module RCA(A,B,c_in,sum,c_out);
    input [7:0]A,B;
    input c_in;
    output wire [8:0]sum;
    output wire c_out;
    wire [8:0] C;
    assign C[0] = c_in;
    genvar i;
    for(i=0;i<8;i=i+1)begin
        full_Adder a1(A[i],B[i],C[i],sum[i],C[i+1]);
    end
    assign c_out = C[8];
    assign sum[8] = c_out;
  
    
endmodule

module CLA_4B(A,B,c_in,sum,c_out);
    input [3:0]A,B;
    input c_in;
    output wire [3:0]sum;
    output c_out;
    wire c1;
    wire [4:0] C;
    assign C[0]=c_in;
    assign C[1] = (A[0]&B[0]) | (C[0] & (A[0] ^ B[0]));
    assign C[2] = (A[1]&B[1]) | (C[1] & (A[1] ^ B[1]));
    assign C[3] = (A[2]&B[2]) | (C[2] & (A[2] ^ B[2]));

  	genvar i;
    for(i = 0 ; i< 4 ;i = i + 1) begin
      full_Adder a1(A[i],B[i],C[i],sum[i],C[i+1]);
    end
    assign c_out = C[4];
    
endmodule

module CASCADE(A,B,c_in,sum,c_out); 
  	input [7:0] A,B;
    input c_in;
  output [7:0]sum;
    output c_out;
    wire c_intermediate;
    CLA_4B m1(.A(A[3:0]),.B(B[3:0]),.c_in(c_in),.sum(sum[3:0]),.c_out(c_intermediate));
    CLA_4B m2(.A(A[7:4]),.B(B[7:4]),.c_in(c_intermediate),.sum(sum[7:4]),.c_out(c_out));
//    assign sum[8] = c_out;

endmodule





module tst;
  	reg [7:0]A,B;
    reg c_in;
  wire [7:0]sum;
  	wire c_out;
  CASCADE r1(A[7:0],B[7:0],c_in,sum[7:0],c_out);
    initial begin
        $monitor("time = %t        A = %b, B = %b,ci = %b , sum = %b, c_out = %b",$time,A,B,c_in,sum,c_out);

        A = 8'b10001101;
        B = 8'b10001010;
        c_in = 1'b0;
        #5 $finish;
    end
    always #5 c_in = ~ c_in;
endmodule
