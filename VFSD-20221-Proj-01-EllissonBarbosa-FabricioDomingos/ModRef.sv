module soma_ModRef(a, b, soma, flag);
  input reg signed [3:0] a, b;
  output reg signed [3:0] soma;
  output bit flag;
  
  always @* begin
    soma = a+b;
    if ((a+b>7 ) || (a+b<-8))
      flag = 0;
    else
      flag = 1;
  end
  
endmodule: soma_ModRef
