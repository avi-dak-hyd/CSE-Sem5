//Name : Sumit Kumar Yadav (18CS30042)
//Name : Avijit Mandal (18CS30010)
// Code your testbench here
// or browse Examples

module two_complement(input clk, input reset, input x, output reg out);
  
    reg state, next_state;
    parameter S0 = 0;
    parameter S1 = 1;
    always @(posedge clk or posedge reset)
      begin
        if(reset)begin
        state <= S0;
        end
       else begin
        state <= next_state;
       end
       end
        
  always @(x or state)
          begin
            case(state)
              S0:
                if(x)begin
                  next_state <= S1;
                  out <= 1'b1;
                end
              else begin
                next_state <= S0;
                out <= 1'b0;
              end
              S1:
                if(x)begin
                  next_state <= S1;
                  out <= 1'b0;
                end
              else begin
                next_state <= S1;
                out <= 1'b1;
              end
            endcase
          end
endmodule

