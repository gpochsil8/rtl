module fifo #(parameter DATA_WIDTH = 16, parameter ADDR_SIZE = 12) (
    input wclk, wrst_n, winc,
    input [DATA_WIDTH-1:0] wdata, 
    output wfull,
    input rclk, rrst_n, rinc,  
    output [DATA_WIDTH-1:0] rdata,
    output rempty    
  );
  wire [ADDR_SIZE-1:0] waddr, raddr;
  wire [ADDR_SIZE:0]   wptr, rptr, wq2_rptr, rq2_wptr;

  sync_r2w #(ADDR_SIZE) sync_r2w (.wq2_rptr(wq2_rptr), .rptr(rptr),
		     .wclk(wclk), .wrst_n(wrst_n));  // updated 16/07/2010 - included  #(ADDR_SIZE)

  sync_w2r #(ADDR_SIZE) sync_w2r (.rq2_wptr(rq2_wptr), .wptr(wptr),
		     .rclk(rclk), .rrst_n(rrst_n)); // updated 16/07/2010 - included  #(ADDR_SIZE)

  fifomem #(DATA_WIDTH, ADDR_SIZE) fifomem
    (.rdata(rdata), .wdata(wdata),
     .waddr(waddr), .raddr(raddr),
     .wclken(winc), .wfull(wfull),
     .wclk(wclk));

  rptr_empty #(ADDR_SIZE) rptr_empty
    (.rempty(rempty),
     .raddr(raddr),
     .rptr(rptr), .rq2_wptr(rq2_wptr),
     .rinc(rinc), .rclk(rclk),
     .rrst_n(rrst_n));
  wptr_full #(ADDR_SIZE) wptr_full
    (.wfull(wfull), .waddr(waddr),
     .wptr(wptr), .wq2_rptr(wq2_rptr),
     .winc(winc), .wclk(wclk),
     .wrst_n(wrst_n));
endmodule
