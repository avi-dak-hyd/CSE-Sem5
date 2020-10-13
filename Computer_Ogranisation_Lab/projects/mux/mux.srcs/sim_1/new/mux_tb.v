`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.09.2020 16:48:50
// Design Name: 
// Module Name: mux_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_tb();
  wire out;
  reg [15:0]data;
  reg [3:0]select;
  m16_1 name(.data(data[15:0]),.select(select[3:0]),.out(out));
  initial 
    begin
      $monitor("%b %d %d",data[15:0],select,out);
      data = 16'hA2DA; // 1010 0010 1101 1010
      select = 4'b0000;
      #80 $finish;
  	end
  
  always #5 select = select+1'b1;

    
endmodule
