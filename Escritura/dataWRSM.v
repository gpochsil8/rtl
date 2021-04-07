module dataWRSM(clk, Wfull, rst_n, Winc, cont_out);
parameter WIDTH = 16;

input clk, Wfull, rst_n;
output Winc;
wire en;
output wire [WIDTH-1:0] cont_out;

UC mod_UC(.clk(clk), .rst_n(rst_n), .data_in(cont_out), .wfull(Wfull), .winc(Winc), .en(en));

CONT16 mod_CONT(.clk(clk), .en(en), .rst(rst_n), .out(cont_out));

endmodule
