module sync_w2r #(parameter ADDR_SIZE = 12)
   (output reg [ADDR_SIZE:0] rq2_wptr,
    input [ADDR_SIZE:0] wptr,
    input rclk, rrst_n);
   reg [ADDR_SIZE:0] rq1_wptr;
   always @(posedge rclk or negedge rrst_n)
     if (!rrst_n) {rq2_wptr,rq1_wptr} <= 0;
     else {rq2_wptr,rq1_wptr} <= {rq1_wptr,wptr};
endmodule
