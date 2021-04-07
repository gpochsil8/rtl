module sync_r2w #(parameter ADDR_SIZE = 12)
   (output reg [ADDR_SIZE:0] wq2_rptr,
    input [ADDR_SIZE:0] rptr,
    input wclk, wrst_n);
   reg [ADDR_SIZE:0] wq1_rptr;
   always @(posedge wclk or negedge wrst_n)
     if (!wrst_n) {wq2_rptr,wq1_rptr} <= 0;
     else {wq2_rptr,wq1_rptr} <= {wq1_rptr,rptr};
endmodule
