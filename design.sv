module maquina_expendedora(
	input clk,
  	input rst,
  	input [1:0]in,
  	output reg expulsar,
  output reg[1:0] cambio
	);
/*Se necesitan pagar 30 pesos. Es posible insertar 10 o 20 pesos.
Los estados 0, 1 y 2 representan 0, 10 y 20 pesos insertados respectivamente.
Una vez que llega a 30, vuelve a 0 la cantidad y "expulsar" se vuelve verdadero.*/
 parameter estado_0 = 2'b00;
 parameter estado_1 = 2'b01;
 parameter estado_2 = 2'b10;
  
  reg[1:0] estado_actual, siguiente_estado;
  
  always@ (posedge clk)
    begin
      if(rst == 1)
        begin
          estado_actual = 0;
          siguiente_estado = 0;
          cambio = 2'b00;
        end
      else
        estado_actual = siguiente_estado;
      
      case(estado_actual)
        
        estado_0:
          if(in == 0)
            begin
              siguiente_estado = estado_0;
              expulsar = 0;
              cambio = 2'b00;
            end
        else if(in == 2'b01)
          begin
            siguiente_estado = estado_1;
            expulsar = 0;
            cambio = 2'b00;
          end
        else if(in == 2'b10)
          begin
            siguiente_estado = estado_2;
            expulsar = 0;
            cambio = 2'b00;
          end
        
        estado_1:
          if(in == 0)
            begin
              siguiente_estado = estado_0;
              expulsar = 0;
              cambio = 2'b01;
            end
        else if(in == 2'b01)
          begin
            siguiente_estado = estado_2;
            expulsar = 0;
            cambio = 2'b00;
          end
        else if(in == 2'b10)
          begin
            siguiente_estado = estado_0;
            expulsar = 1;
            cambio = 2'b00;
          end
        
        estado_2:
          if(in == 0)
            begin
              siguiente_estado = estado_0;
              expulsar = 0;
              cambio = 2'b10;
            end
        else if(in == 2'b01)
          begin
            siguiente_estado = estado_0;
            expulsar = 1;
            cambio = 2'b00;
          end
        else if(in == 2'b10)
          begin
            siguiente_estado = estado_0;
            expulsar = 1;
            cambio = 2'b01;
          end
        
      endcase
    end
endmodule
