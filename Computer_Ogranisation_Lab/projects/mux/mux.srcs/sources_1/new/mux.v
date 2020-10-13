module m21(data,select,out);
  input [1:0] data;
  input select;
  output out ;
  assign out = data[select];
endmodule

module m41(data,select,out);
  input [3:0] data;
  input [1:0]select;
  output out;
  //assign out = data[select];
  wire I0,I1;
  wire [1:0] I;
  m21 m1(data[1:0],select[0],I[0]);
  m21 m2(data[3:2],select[0],I[1]);

  m21 m3(I,select[1],out);
  
endmodule


module m81(data,select,out);
 input [7:0] data;
 input [2:0] select;
 output out;
 
 wire [1:0]I;
 m41 m1 (data[3:0],select[1:0],I[0]);
 m41 m2 (data[7:4],select[1:0],I[1]);
 m21 m3(I[1:0],select[2],out);
 
endmodule

module m16_1(data,select,out);
  input [15:0]data;
  input [3:0]select;
  output out;
    
  wire [3:0]I;
    
  m41 m1(data[3:0],select[1:0],I[0]);
  m41 m2(data[7:4],select[1:0],I[1]);
  m41 m3(data[11:8],select[1:0],I[2]);
  m41 m4(data[15:12],select[1:0],I[3]);
    
  m41 m5(I[3:0],select[3:2],out);
endmodule 