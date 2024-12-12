`include "design.sv"
module tb_tail_light_fsm;
    logic clk;
    logic reset_n;
    logic [2:0] light;
    logic [3:0] visited_states;

    tail_light_fsm uut (
        .clk(clk),
        .reset_n(reset_n),
        .light(light)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset_n = 0;
        visited_states = 4'b0000;
        #10;
        reset_n = 1;
        #10;

        repeat (8) begin
            #10;
            case (light)
                3'b001: visited_states[0] = 1'b1;
                3'b011: visited_states[1] = 1'b1;
                3'b111: visited_states[2] = 1'b1;
                3'b000: visited_states[3] = 1'b1;
                default: $display("Estado inválido detectado! (light = %b)", light);
            endcase
        end

        $finish;
    end

    final begin
        $display("Estados Visitados: %b", visited_states);
        foreach (visited_states[i])
            if (!visited_states[i])
                $display("Estado %0d não foi visitado!", i);
    end
endmodule

