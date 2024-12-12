module tb_tail_light_fsm;
    logic clk;           
    logic reset_n;       
    logic [2:0] light;   

    tail_light_fsm uut (
        .clk(clk),
        .reset_n(reset_n),
        .light(light)
    );


    always #5 clk = ~clk;


    initial begin
        $display("=== Início da simulação ===");
     
        clk = 0;
        reset_n = 0; 
        #10;

        $display("[RESET] A FSM está no estado inicial com reset ativo.");
        reset_n = 1;
        #10;

        repeat (8) begin
            #10;
            case (light)
                3'b001: $display("Estado S0: Apenas a luz traseira 1 está acesa (light = %b).", light);
                3'b011: $display("Estado S1: As luzes traseiras 1 e 2 estão acesas (light = %b).", light);
                3'b111: $display("Estado S2: Todas as luzes traseiras estão acesas (light = %b).", light);
                3'b000: $display("Estado S3: Todas as luzes traseiras estão apagadas (light = %b).", light);
                default: $display("Estado inválido detectado! (light = %b)", light);
            endcase
        end

        $display("=== Fim da simulação ===");
        $finish;
    end

endmodule

