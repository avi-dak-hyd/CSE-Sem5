// Sumit Kumar Yadav (18CS30042)
// Avijit Mandal (18CS30010)

//carry save adder 16 bit
module carry_save_adder_16_bit
    (
        input [15:0] num0,
        input [15:0] num1,
        input [15:0] num2,
        input [15:0] num3,
        input [15:0] num4,
        input [15:0] num5,
        input [15:0] num6,
        input [15:0] num7,
        input [15:0] num8,
        output [20:0] sum
    );
    
    wire [16:0] w1 [5:0];
    
    carry_save_adder_n_bit #(16) csa_1(num0,num1,num2,w1[0],w1[1]);
    carry_save_adder_n_bit #(16) csa_2(num3,num4,num5,w1[2],w1[3]);
    carry_save_adder_n_bit #(16) csa_3(num6,num7,num8,w1[4],w1[5]);
    
    wire [17:0] w2 [3:0];
    
    
    carry_save_adder_n_bit #(17) csa_4(w1[0],w1[1],w1[2],w2[0],w2[1]);
    carry_save_adder_n_bit #(17) csa_5(w1[3],w1[4],w1[5],w2[2],w2[3]);

    wire [18:0] w3[1:0];
    
    
    carry_save_adder_n_bit #(18) csa_6(w2[0],w2[1],w2[2],w3[0],w3[1]);
    
    wire [19:0] w4[1:0];
    wire [18:0] pre_sum;
    assign pre_sum  = {1'b0,w2[3]};
    
    carry_save_adder_n_bit #(19) csa_7(w3[0],w3[1],pre_sum,w4[0],w4[1]);
    
    wire [19:0] temp_sum;
    wire carry;
    carry_look_ahead_20_bit cla_20_bit(w4[0],w4[1],1'b0,temp_sum,carry);
    
   assign sum = {carry, temp_sum};

endmodule

//carry save adder n bit for adding each bit separately

module carry_save_adder_n_bit
    #(parameter N = 16)
    (
        input [N-1:0] a,
        input [N-1:0] b,
        input [N-1:0] cin,
        output [N:0] cout,
        output [N:0] s
    );
    genvar i;
    generate
    for (i = 0; i < N; i = i + 1) 
	    begin: block
	        csa csa_bit(a[i],b[i],cin[i],s[i],cout[i+1]);
	    end    
    endgenerate
    assign cout[0] = 0;
    assign s[N] = 0;
endmodule

//carry save adder for each bit
module csa(
    input a,
    input b,
    input cin,
    output sum,
    output cout);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | ( a & cin) | (b & cin);
endmodule


//carry look ahead for 20 bit 
 
module carry_look_ahead_20_bit(a,b, cin, sum,cout);
    input [19:0] a,b;
    input cin;
    output [19:0] sum;
    output cout;
    wire a1,a2,a3,a4;
     
    carry_look_ahead_4_bit cla_1(.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(a1));
    carry_look_ahead_4_bit cla_2(.a(a[7:4]), .b(b[7:4]), .cin(a1), .sum(sum[7:4]), .cout(a2));
    carry_look_ahead_4_bit cla_3(.a(a[11:8]), .b(b[11:8]), .cin(a2), .sum(sum[11:8]), .cout(a3));
    carry_look_ahead_4_bit cla_4(.a(a[15:12]), .b(b[15:12]), .cin(a3), .sum(sum[15:12]), .cout(a4));
    carry_look_ahead_4_bit cla_5(.a(a[19:16]), .b(b[19:16]), .cin(a4), .sum(sum[19:16]), .cout(cout));
     
endmodule
 
//carry look ahead adder for 4 bit
 
module carry_look_ahead_4_bit(a,b, cin, sum,cout);
	input [3:0] a,b;
	input cin;
	output [3:0] sum;
	output cout;
	 
	wire [3:0] p,g,c;    // p for propagate and g for generate
	     
	    assign p=a^b;
	    assign g=a&b;  
	    assign c[0]=cin;
	    assign c[1]= g[0] | (p[0] & c[0]);
	    assign c[2]= g[1] | (p[1] & g[0]) | p[1] & p[0] & c[0];
	    assign c[3]= g[2] | (p[2] & g[1]) | p[2] & p[1] & g[0] | p[2] & p[1] & p[0] & c[0];
	    assign cout= g[3] | (p[3] & g[2]) | p[3] & p[2] & g[1] | p[3] & p[2] & p[1] & p[0] & c[0];
	    assign sum=p ^ c;
	     
endmodule