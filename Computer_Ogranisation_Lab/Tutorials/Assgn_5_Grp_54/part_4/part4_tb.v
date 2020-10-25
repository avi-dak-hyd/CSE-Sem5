module carry_save_adder_16_bit_tb;
    reg [15:0] num0;
    reg [15:0] num1;
    reg [15:0] num2;
    reg [15:0] num3;
    reg [15:0] num4;
    reg [15:0] num5;
    reg [15:0] num6;
    reg [15:0] num7;
    reg [15:0] num8;
    wire [20:0] sum; 
    carry_save_adder_16_bit uut(num0,num1,num2,num3,num4,num5,num6,num7,num8,sum);
    initial
      begin
      //input_1
        num0=16'd0;num1=16'd0;num2=16'd0;num3=16'd0;num4=16'd0;num5=16'd0;num6=16'd0;num7=16'd0;num8=16'd0;
        #10
      //input_2
        num0=16'd125;num1=16'd1;num2=16'd1;num3=16'd1;num4=16'd1;num5=16'd1;num6=16'd1;num7=16'd1;num8=16'd6545;
        #10
      //input_3
        num0=16'd10;num1=16'd10;num2=16'd10;num3=16'd10;num4=16'd10;num5=16'd10;num6=16'd10;num7=16'd10;num8=16'd10;
        #10
      //input_4
        num0=16'd105;num1=16'd21;num2=16'd31;num3=16'd11;num4=16'd321;num5=16'd111;num6=16'd231;num7=16'd11;num8=16'd65;
        #10
      //input_5
        num0=16'd12534;num1=16'd112;num2=16'd631;num3=16'd1243;num4=16'd2341;num5=16'd154;num6=16'd175;num7=16'd1453;num8=16'd645;
        #10
      //input_6
        num0=16'd65000;num1=16'd12;num2=16'd11;num3=16'd12;num4=16'd14;num5=16'd4;num6=16'd9;num7=16'd12;num8=16'd67;
      end
    initial

$monitor("num0=%d, num1=%d, num2=%d, num3=%d, num4=%d, num5=%d, num6=%d, num7=%d, num8=%d, sum=%d \n",num0,num1,num2,num3,num4,num5,num6,num7,num8,sum);

endmodule