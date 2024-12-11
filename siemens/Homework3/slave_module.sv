//`include "design.sv" // Incluir a interface do barramento

module slave_module (
    input logic clk,
    input logic reset,
    input logic [7:0] slave_address,
    bus_if.slave bus
);
    logic [31:0] slave_data;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            bus.Ack <= 0;
        end else if (bus.WB && bus.address == slave_address) begin
            // Escravo verifica a paridade e processa os dados
            if (bus.check_parity(bus.data, bus.parity)) begin
                slave_data <= bus.data;
                $display("Escravo %h recebeu dado: %h", slave_address, bus.data);
            end else begin
                $display("Erro de paridade no escravo %h!", slave_address);
            end
            bus.Ack <= 1;
        end else if (bus.RB && bus.address == slave_address) begin
            // Escravo responde à leitura
            bus.data <= slave_data;
            bus.Ack <= 1;
        end else begin
            bus.Ack <= 0;
        end
    end
endmodule

