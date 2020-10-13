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