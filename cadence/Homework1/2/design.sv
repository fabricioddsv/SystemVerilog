// Code your design here
// Definição do módulo da FSM para o tail light (luz traseira) do T-Bird
module tail_light_fsm(
    input logic clk,      // Clock
    input logic reset_n,  // Reset ativo em 0
    output logic [2:0] light // Saída das luzes traseiras
);

    // Definindo os estados como tipos enumerados
    typedef enum logic [1:0] {
        S0,  // Estado 0
        S1,  // Estado 1
        S2,  // Estado 2
        S3   // Estado 3
    } state_t;

    state_t state, next_state;  // Variáveis para o estado atual e o próximo estado

    // Estado sequencial (registro do estado atual)
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            state <= S0;  // Se houver reset, voltamos ao estado inicial (S0)
        else
            state <= next_state;  // Atualizamos o estado
    end

    // Lógica combinacional para determinar o próximo estado
    always_comb begin
        case (state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S0;
            default: next_state = S0;
        endcase
    end

    // Lógica combinacional para determinar a saída
    always_comb begin
        case (state)
            S0: light = 3'b001;  // Luz traseira 1 acesa
            S1: light = 3'b011;  // Luzes traseiras 1 e 2 acesas
            S2: light = 3'b111;  // Todas as luzes traseiras acesas
            S3: light = 3'b000;  // Todas as luzes traseiras apagadas
            default: light = 3'b000;
        endcase
    end

    // Código de debug para imprimir o estado atual no console
    always_ff @(posedge clk) begin
        case (state)
            S0: $display("Estado atual: S0");
            S1: $display("Estado atual: S1");
            S2: $display("Estado atual: S2");
            S3: $display("Estado atual: S3");
            default: $display("Estado atual: desconhecido");
        endcase
    end

endmodule

