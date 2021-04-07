module UC(clk, rst_n, data_in, wfull, winc, en);

input clk, rst_n, wfull; //entradas a la unidad de control
input [15:0] data_in; //datos de entrada, vendran del contador
output reg winc, en; //señales para habilitar escritura en memoria y contador respectivamente

parameter [2:0] //estados posibles
		S0 = 2'd0,
		S1 = 2'd1,
		S2 = 2'd2;

reg [2:0] state, next;
wire temp;

always@(posedge clk or negedge rst_n) begin //cada ciclo de reloj o activación del reset
if(!rst_n) state=S0; //estado S0 en caso de señal de reset activo
else state=next; //en caso contrario actualizamos el estado
end

always@(state or wfull or data_in) begin //para el calculo del estado futuro y las salidas
case(state)

S0: begin
en=1'b0; //contador deshabilitado
winc=1'b0; //no escribir en memoria
if(!wfull) next=S1; //memoria con espacio avanzamos al siguiente estado
else next=S0;
end

S1: begin
en=1'b1; //habilitar el contador
winc=1'b0; //no escribir en memoria
if(temp==1'b1) begin //si el numero de 1's es impar
next=S2; //el siguiente estado es S2
en=1'b0; //deshabilitamos el contador
end
else if(!wfull) next=S1; //en caso contrario seguimos en el mismo estado si la memoria tiene espacio
else begin
next=S0; //si la memoria esta llena iremos al estado inicial
en=1'b0; //deshabilitando el contador
end
end

S2: begin
en=1'b1; //habilitamos el contador
winc=1'b1; //y damos la orden de escribir en memoria
if(wfull) begin
next=S0; //si la memoria esta llena pasaremos al estado 0
en=1'b0; //deshabilitamos el contador
winc=1'b0; //y damos la orden de no escribir en memoria
end
else next=S1; //si no al estado 1
end

default: begin //salidas por defecto
en=1'b0;
winc=1'b0;
next=S0;
end

endcase
end
assign temp=(^(data_in)); //caclulamos el numero de 1's del dato que proporciona el contador
endmodule
