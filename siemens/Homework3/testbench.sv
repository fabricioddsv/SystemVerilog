// Code your testbench here
// or browse Examples
//`include "bus_if.sv" // Incluir a interface do barramento
`include "slave_module.sv"
`include "master_module.sv"

module tb_master_slave;

    // Sinais de clock e reset
    logic clk;
    logic reset;

    // Instância da interface do barramento
    bus_if #(.DATA_WIDTH(32)) bus();

    // Instância do mestre e dos escravos
    master_module master (
        .clk(clk),
        .reset(reset),
        .bus(bus.master)
    );

    slave_module slave1 (
        .clk(clk),
        .reset(reset),
        .slave_address(8'hA5),
        .bus(bus.slave)
    );

    slave_module slave2 (
        .clk(clk),
        .reset(reset),
        .slave_address(8'hB2),
        .bus(bus.slave)
    );

    // Geração do clock
    always #5 clk = ~clk;

    initial begin
        // Inicialização
        clk = 0;
        reset = 1;
        #10 reset = 0;

        // Simular por 100 unidades de tempo
        #100 $finish;
    end
endmodule

