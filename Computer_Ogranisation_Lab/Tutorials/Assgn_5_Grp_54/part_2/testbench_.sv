// Code your testbench here
// or browse Examples
module tb_alu;
//Inputs
  reg[15:0] A,B;
  reg[3:0] ALU_Sel;
  reg M, cin;
  //outputs
  wire Cn4, equality_check,P,G;
  wire [15:0] F;
 // Verilog code for ALU
 integer i;
 alu_16BIT test_unit(
            A,B,  // ALU 16-bit Inputs                 
            ALU_Sel,// ALU Selection
   			M,cin,
   			Cn4,equality_check,P,G,F
     );
    initial begin
    // hold reset state for 100 ns.
      
      //$dumpfile("test.vcd");
      //$dumpvars;

      A = 16'b1010001010111101;
      B = 16'b0101010001010001;
      cin = 1;
      M = 1;
      ALU_Sel = 4'h0;
      $monitor("A = %b, B = %b, ALU_Select = %b, Cn = %b, M = %b, F = %b, eq_check = %b, cout = %b", A, B, ALU_Sel, cin, M, F, equality_check, Cn4);
      for (i=0;i<=15;i=i+1)
      begin
       ALU_Sel = ALU_Sel + 8'h01;
       M = ~M;
       #10;
      end
      
    end
endmodule
