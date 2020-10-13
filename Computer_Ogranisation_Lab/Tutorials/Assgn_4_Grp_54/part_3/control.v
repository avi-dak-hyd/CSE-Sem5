//Name : Sumit Kumar Yadav (18CS30042)
//Name : Avijit Mandal (18CS30010)


module control(input clk,input reset,input eqflag,input ifflag,output reg d,output xload,output yload,output xsel,output ysel,output gcdload);
	 
	 reg [3:0]currstate, nextstate;
	 reg xsel, ysel, xload, yload, gcdload;
	 parameter start = 1, in = 2,test1 = 3,test2 = 4,update1 = 5,update2 = 6,stop = 7;
	 always@(posedge clk or posedge reset)
	 begin
	 if(reset) begin
		currstate <= start;
		nextstate <= start;
		d <= 0;
	 end
	 else
		case(nextstate)
		 start: begin
				nextstate <= in;
			end
			
		 in: begin
		  		xload <= 1'b1;
				yload <= 1'b1;
				xsel <= 1'b1;
				ysel <= 1'b1; 
				if( eqflag == 1'b1) begin
					nextstate <= stop;
				end
				else begin
					nextstate <= test1;
				end
			end
			
	         test1: begin
	         		xload <= 1'b0;
				yload <= 1'b0;
				xsel <= 1'b0;
				ysel <= 1'b0;
				nextstate <= test2;
			end
			
		 test2: begin
				xload <= 1'b0;
				yload <= 1'b0;
				xsel <= 1'b0;
				ysel <= 1'b0;
				if( eqflag == 1'b1)
					nextstate <= stop;
				else if( ifflag == 1'b1)
					nextstate <= update1;
				else
					nextstate <= update2;
						
			end
			
		  update1: begin
				yload <= 1'b1;
				xload <= 1'b0;
				ysel <= 1'b0;
				nextstate <= test1;
			   end
			
		  update2: begin	
				xload <= 1'b1;
				yload <= 1'b0;
				xsel <= 1'b0;
				nextstate <= test1;
			 end
			
		 stop: begin
				gcdload <= 1'b1;
				d <= 1;
				nextstate <= stop;
		       end
	   endcase
	end
endmodule
