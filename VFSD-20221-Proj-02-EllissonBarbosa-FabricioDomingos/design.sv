// Code your design here
module mux_duv(c0,c1,c2,c3,c4,c5,c6,c7,select, saida);
  input logic [7:0] c0,c1,c2,c3,c4,c5,c6,c7;
  input logic [2:0]select;
  output logic [7:0]saida;
  
  always_comb begin
    if (select == 0) saida = c0;
    else if (select == 1) saida = c1;
    else if (select == 2) saida = c2;
    else if (select == 3) saida = c3;
    else if (select == 4) saida = c4;
    else if (select == 5) saida = c5;
    else if (select == 6) saida = c6;
    else if (select == 7) saida = c7; 
    else saida=0;
  end
  
endmodule: mux_duv
