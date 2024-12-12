`include "design.sv"
module tb_float_adder_double;

    logic [63:0] a, b, sum;
    shortreal real_a, real_b, real_sum;

    float_adder_double uut (
        .a(a),
        .b(b),
        .sum(sum)
    );

    initial begin
        $display("=== Início da Simulação ===");

        real_a = 3.141592653589793;
        real_b = 2.718281828459045;
        a = $realtobits(real_a);
        b = $realtobits(real_b);
        #1;
        real_sum = $bitstoreal(sum);
        $display("Teste 1: PI (%f) + e (%f) = %f", real_a, real_b, real_sum);

        real_a = -3.0;
        real_b = 3.0;
        a = $realtobits(real_a);
        b = $realtobits(real_b);
        #1;
        real_sum = $bitstoreal(sum);
        $display("Teste 2: -3.0 (%f) + 3.0 (%f) = %f", real_a, real_b, real_sum);

        real_a = 1.0e300;
        real_b = 1.0e300;
        a = $realtobits(real_a);
        b = $realtobits(real_b);
        #1;
        real_sum = $bitstoreal(sum);
        $display("Teste 3: 1.0e300 (%f) + 1.0e300 (%f) = %f", real_a, real_b, real_sum);

        $display("=== Fim da Simulação ===");
        $finish;
    end

endmodule

