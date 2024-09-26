module soma_DUV(a,b,soma,flag);
  input logic signed [3:0] a,b;
  output logic signed [3:0] soma;
  output bit flag;
  
  always_comb begin
    soma = a+b;
    if (((a+b)>7 ) || ((a+b)<-8))
      flag=0;
    else
      flag=1;
  end
  
endmodule:soma_DUV
