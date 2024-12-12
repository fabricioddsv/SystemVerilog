`include "design.sv"
module slave_ds#(
    parameter int BUS_WIDTH = 8,
    parameter logic [7:0] id = 8'hF0
)(
    bus_if.slave slave_br,
    input logic clk,
    input logic reset
);

    typedef enum logic [1:0] {
        IDLE,
        READ,
        WRITE,
        END_WR_RD
    } state_t;

    state_t current_state, next_state;
    logic [BUS_WIDTH-1:0] memoria;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        
        case (current_state)
            IDLE: begin
                if (slave_br.address == id && slave_br.RB == 0) begin
                    next_state = READ;
                end else if (slave_br.address == id && slave_br.WB == 0) begin
                    next_state = WRITE;
                end
            end

            READ: begin
                slave_br.data = memoria; // Valor guardado na memória para o barramento
                slave_br.PARITY = ^memoria; // Cálculo de paridade
                slave_br.ACK = 0; // Confirmação de execução de comando
                next_state = END_WR_RD;
            end

            WRITE: begin
                memoria = slave_br.data; // Salva o valor do barramento na memória
                slave_br.PARITY = ^memoria; // Cálculo de paridade
                slave_br.ACK = 0; // Confirmação de execução de comando
                next_state = END_WR_RD;
            end

            END_WR_RD: begin
                next_state = IDLE;
                slave_br.ACK = 1; // Valor default
            end
            default: begin
                next_state = IDLE;
                slave_br.ACK = 1; // Valor default
            end
        endcase
    end
endmodule
