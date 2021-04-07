module rptr_empty #(parameter ADDR_SIZE = 12)
   (output reg rempty,
    output [ADDR_SIZE-1:0] raddr,
    output reg [ADDR_SIZE :0] rptr,
    input [ADDR_SIZE :0] rq2_wptr,
    input rinc, rclk, rrst_n);
   reg [ADDR_SIZE:0] 	     rbin;
   wire [ADDR_SIZE:0] 	     rgraynext, rbinnext;
	wire                      rempty_val;
   //-------------------
   // GRAYSTYLE2 pointer
   //-------------------
   always @(posedge rclk or negedge rrst_n)
     if (!rrst_n) {rbin, rptr} <= 0;
     else {rbin, rptr} <= {rbinnext, rgraynext};
   // Memory read-address pointer (okay to use binary to address memory)
   assign raddr = rbin[ADDR_SIZE-1:0];
   assign rbinnext = rbin + (rinc & ~rempty);
   assign rgraynext = (rbinnext>>1) ^ rbinnext;
   //---------------------------------------------------------------
   // FIFO empty when the next rptr == synchronized wptr or on reset
   //---------------------------------------------------------------
   assign rempty_val = (rgraynext == rq2_wptr);
   always @(posedge rclk or negedge rrst_n)
     if (!rrst_n) rempty <= 1'b1;
     else rempty <= rempty_val;
endmodule
