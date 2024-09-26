module cont(ck,reset,updown,out);
  input bit ck,reset,updown;
  output bit [3:0] out;
 always @(posedge ck or posedge reset)
    begin
      if(reset==1)begin
        out=0;
      end
      else begin
        if(updown==1) begin 
          out++;
        end
        else begin
          out--;
        end
      end
    end
endmodule:cont;
