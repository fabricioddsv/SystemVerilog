module modRef(a,d,o,we,cs);
  input logic [1:0] we,cs;
  input logic [3:0] a,d;
  output logic [3:0] o;
  reg [15:0] dTemp1, dTemp2, dTemp3, dTemp4;
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
              dTemp1[a]=d[0];
              dTemp2[a]=d[1];
              dTemp3[a]=d[2];
              dTemp4[a]=d[3];      
            end
            
            1: begin//leitura
              o[0]=~dTemp1[a];
              o[1]=~dTemp2[a];
              o[2]=~dTemp3[a];
              o[3
               ]=~dTemp4[a];
            end
          endcase
        end
      endcase
      
    end
  
endmodule: modRef
