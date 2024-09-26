module cont_rf(ck,reset,updown,out);
  input bit ck,reset,updown;
  output bit [3:0] out;
 always @(posedge ck or posedge reset)
    begin
      if(reset==1)begin
        out=0;
      end
      else begin
        if(updown==0)out--;
        else if(updown==1)out++;
      end
     
    end
endmodule:cont_rf
