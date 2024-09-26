module ref_mux(c0,c1,c2,c3,c4,c5,c6,c7,select, saida);
  input logic [7:0] c0,c1,c2,c3,c4,c5,c6,c7;
  input logic [2:0]select;
  output logic [7:0]saida;
  
  always_comb begin
    case(select)
      3'b000: saida=c0;
      3'b001:saida=c1;
      3'b010:saida=c2;
      3'b011:saida=c3;
      3'b100:saida=c4;
      3'b101:saida=c5;
      3'b110:saida=c6;
      3'b111:saida=c7;
      default:saida=8'b00000000;
    endcase
  end
  
endmodule: ref_mux
