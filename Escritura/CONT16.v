 module CONT8(clk, en, rst, out);
    input  clk, rst, en;
    output reg [7:0] out;

    reg [7:0] temp;

    always @(posedge clk or negedge rst)
      if(!rst) begin
	out <= 8'b0;
	temp<=8'b0;
	end
      else begin
      if(en) begin
	temp <= out + 1;
	out<=out+1;
	end
      else temp<=out;
	end
  endmodule
