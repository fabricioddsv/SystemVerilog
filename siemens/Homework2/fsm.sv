module tail_light_fsm(
    input logic clk,
    input logic reset_n,
    output logic [2:0] light
);

    typedef enum logic [1:0] {S0, S1, S2, S3} state_t;
    state_t state, next_state;

    // Lógica sequencial
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            state <= S0;
        else
            state <= next_state;
    end

    // Lógica combinacional
    always_comb begin
        next_state = state;
        case (state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S0;
        endcase
    end

    // Determinar a saída
    always_comb begin
        case (state)
            S0: light = 3'b001;
            S1: light = 3'b011;
            S2: light = 3'b111;
            S3: light = 3'b000;
        endcase
    end

endmodule

