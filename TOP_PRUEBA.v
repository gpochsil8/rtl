module TOP_PRUEBA(input clk10, clk20, rrst_n, wrst_n, output wire [15:0] rData);

wire wfull, winc, rempty, rinc;
wire [15:0] wdata, rxData;
wire [7:0] Hex0, Hex1, Hex2, Hex3;

fifo #(16,12) BUFFER(
   .rdata                  (rxData)
  ,.wfull                  (wfull )
  ,.rempty                 (rempty)
  ,.wdata                  (wdata)
  ,.winc                   (winc)
  ,.wclk                   (clk20)
  ,.wrst_n                 (wrst_n)
  ,.rinc                   (rinc)
  ,.rclk                   (clk10)
  ,.rrst_n                 (rrst_n)
);


dataWRSM GENERA (.clk(clk20), .Wfull(wfull), .rst_n(wrst_n), .Winc(winc), .cont_out(wdata));

dataRDSM LLEGEIX (.clk(clk10), .Rempty(rempty), .rst_n(rrst_n), .Rdata(rxData), .Rinc(rinc), .data_out(rData));

hex2seg I_HEX0(
	.Clk (Clk),
	.Rst_n (Rst_n),
	.Data	 (rData[3:0]),
	.seg	 (Hex0)
	);
hex2seg I_HEX1(
	.Clk (Clk),
	.Rst_n (Rst_n),
	.Data	 (rData[7:4]),
	.seg	 (Hex1)
	);

hex2seg I_HEX2(
	.Clk (Clk),
	.Rst_n (Rst_n),
	.Data	 (rData[11:8]),
	.seg	 (Hex2)
	);
hex2seg I_HEX3(
	.Clk (Clk),
	.Rst_n (Rst_n),
	.Data	 (rData[15:12]),
	.seg	 (Hex3)
	);


endmodule
