// Code your design here
interface bus_if #(parameter DATA_WIDTH = 32) ();
    // Sinais do barramento
    logic [DATA_WIDTH-1:0] data; // Dados transmitidos
    logic [7:0] address;         // Endereço do escravo
    logic WB, RB;                // Sinais de controle (Write e Read)
    logic Ack;                   // Sinal de handshaking
    logic parity;                // Bit de paridade

    // Modport para o mestre
    modport master (
        output data, output address, output WB, output RB,
        input Ack, output parity
    ); 
  
    // Modport para o escravo
    modport slave (
        input data, input address, input WB, input RB,
        output Ack, input parity
    );

    // Função para calcular paridade
    function logic calc_parity(input logic [DATA_WIDTH-1:0] data);
        calc_parity = ^data; // XOR bit a bit para calcular paridade
    endfunction

    // Função para verificar paridade
    function logic check_parity(input logic [DATA_WIDTH-1:0] data, input logic parity_bit);
        check_parity = (^data == parity_bit);
    endfunction
endinterface
