// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps

module tb_tail_light_fsm;

    // Sinais de entrada e saída do DUT (Design Under Test)
    logic clk;
    logic reset_n;
    logic [2:0] light;

    // Instância do módulo tail_light_fsm
    tail_light_fsm dut (
        .clk(clk),
        .reset_n(reset_n),
        .light(light)
    );

    // Geração do clock
    always #5 clk = ~clk;  // Clock com período de 10 unidades de tempo

    // Processo principal de teste
    initial begin
        // Inicialização
        clk = 0;
        reset_n = 0;
        
        // Aplicar reset
        $display("Iniciando Testbench");
        #10 reset_n = 1;  // Libera o reset após 10 unidades de tempo
        
        // Simular durante 50 ciclos de clock
        repeat(50) @(posedge clk);

        // Finalizar a simulação
        $stop;
    end

    // Monitorar as mudanças no estado e na saída
    initial begin
        $monitor("Tempo: %0t | Estado da luz: %b", $time, light);
    end

endmodule

