module fifomem #(parameter DATA_SIZE = 16, // Memory data word width
		 parameter ADDR_SIZE = 12) // Number of mem address bits
 (output [DATA_SIZE-1:0] rdata,
  input [DATA_SIZE-1:0] wdata,
  input [ADDR_SIZE-1:0] waddr, raddr,
  input wclken, wfull, wclk);
`ifdef VENDORRAM
  // Instantiation of a vendor's dual-port RAM
  vendor_ram mem (.dout(rdata), .din(wdata),
		  .waddr(waddr), .raddr(raddr),
		  .wclken(wclken),
		  .wclken_n(wfull), .clk(wclk));
`else
  // RTL memory model
  localparam MEM_DEPTH = (1<<ADDR_SIZE);
  reg [DATA_SIZE-1:0] mem [0:MEM_DEPTH-1];
  assign rdata = mem[raddr];
  always @(posedge wclk)
    if (wclken && !wfull) mem[waddr] <= wdata;
`endif
/*o_buf_dual #(16,12) MEM(
   .Clk                    (!wclk)
  ,.We                     (wclken)
  ,.WrAddr                 (waddr)
  ,.RdAddr                 (raddr)
  ,.D                      (wdata)
  ,.Q                      (rdata)
);*/
endmodule

