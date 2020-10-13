module tst;
  	reg [7:0]A,B;
    reg c_in;
    wire [7:0]sum;
  	wire c_out;
    RCA r1(A[7:0],B[7:0],c_in,sum[7:0],c_out);
    initial begin
        $monitor("time = %t        A = %b, B = %b,ci = %b , sum = %b, c_out = %b",$time,A,B,c_in,sum,c_out);

        A = 8'b10001101;
        B = 8'b10001010;
        c_in = 1'b0;
        #5 $finish;
    end
    always #5 c_in = ~ c_in;
endmodule