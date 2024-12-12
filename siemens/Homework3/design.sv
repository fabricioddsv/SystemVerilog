`ifndef BUS_IF
`define BUS_IF
    interface bus_if #(parameter int BUS_WIDTH = 8);
      logic RB,WB,ACK,PARITY; // para escrita,leitura,ack jogar nivel logico baixo = 1'b0; bit de paridade é variavel. 
      logic [BUS_WIDTH-1:0] data; //dados vindo ou indo para o slave.
      logic [7:0] address; // Endereço de 8 bits referente ao slave

      modport master(input ACK,inout data, PARITY, output WB,RB,address); //modport para o mestre
      modport slave(input WB,RB,address,inout data, PARITY,output ACK); //modport para o slave
    endinterface
`endif

