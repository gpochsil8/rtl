module dataRDSM(clk, Rempty, rst_n, Rdata, Rinc, data_out);

input clk, Rempty, rst_n; //entradas al modulo, memoria vacia y reset
input [15:0] Rdata; //datos de entrada al modulo, provienen de la fifo
output reg Rinc; //salida para habilitar la lectura de memoria
output reg [15:0] data_out; //salida con los datos leidos

parameter //estados posibles
	S0 = 1'b0, //estado inicial, memoria vacia
	S1 = 1'b1; //memoria con datos

reg state, next=S0;

always@(posedge clk or negedge rst_n) begin //actualizacion del estado
if(!rst_n) state<=S0;
else state<=next;
end

always@(state or Rempty or Rdata) begin //calculo del estado futuro y generacion de la señal de lectura

case(state)

S0: begin
if(Rempty) begin
next<=S0; //la memoria no tiene datos, seguiremos en el mismo estado
data_out<=data_out; //los datos de salida seran los últimos que hayamos sacado
Rinc<=1'b0; //la lectura en memoria se deshabilita
end
else begin //en caso de tener datos en la fifo
next<=S1; //actualizamos el estado futuro
data_out<=data_out; //seguimos sacando los ultimos datos leidos
Rinc<=1'b0; //seguimos con lectura deshabilitada
end
end

S1: begin
if(Rempty) begin
next<=S0;
data_out<=data_out;
Rinc<=1'b1;
end
else begin
next<=S1;
data_out<=Rdata;
Rinc<=1'b1;
end
end
endcase
end
endmodule
