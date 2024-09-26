// Code your design here
module CI74F189(a,d,o,we,cs);
  input logic [1:0] we,cs;
  input logic [3:0] a,d;
  output logic [3:0] o;
  reg [3:0] register[15:0];
  
  always_comb
    begin
       case(cs)
        1:begin
          o=4'bzzzz;
        end
        
        0:begin
          case(we)
            0: begin //write
              o=4'bzzzz;
              register[a]=d;      
            end
            
            1: begin//leitura
              o=~register[a];
            end
          endcase
        end
      endcase
        
    end
  
endmodule: CI74F189


