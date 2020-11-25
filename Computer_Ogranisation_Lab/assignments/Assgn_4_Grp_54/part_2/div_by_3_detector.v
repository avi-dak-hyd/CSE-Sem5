
//Name : Sumit Kumar Yadav (18CS30042)
//Name : Avijit Mandal (18CS30010)

module div_by_three(input clk, input reset, input x, output reg out);
  
    reg state, next_state;
    parameter S0 = 0;
    parameter S1 = 1;
  	parameter S2 = 2;
  
  // Gives out = 1 if divisible and ) otherwise
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
                    out <= 0;
                end
              else begin
					next_state <= S0;
                	out <= 1;
              end
              S1:
                if(x)begin
					next_state <=S0;
                    out <= 1;
                end
              else begin
					next_state <= S2;
                	out <= 0;
              end
              S2:
                if(x)begin
					next_state <= S2;
                    out <=0;
                end
              else begin
					next_state <= S1;
                	out <= 0;
              end
            endcase
          end
endmodule

