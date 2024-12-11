module tb_float_adder_double;

    // Sinais
    logic [63:0] a, b, sum;

    // Instância do módulo de somador
    float_adder_double uut (
        .a(a),
        .b(b),
        .sum(sum)
    );

    // Variáveis para exibição como ponto flutuante
    real real_a, real_b, real_sum;

    // Testes
    initial begin
        // Teste 1: Soma de PI e e
        real_a = 3.14159;       // Número em ponto flutuante (64 bits)
        real_b = 2.71828;       // Número em ponto flutuante (64 bits)
        a = $realtobits(real_a); // Converte para formato IEEE 754
        b = $realtobits(real_b); // Converte para formato IEEE 754
        #1;
        real_sum = $bitstoreal(sum); // Converte o resultado de volta para ponto flutuante
        $display("Teste 1 | A: %f, B: %f, Soma: %f", real_a, real_b, real_sum);

        // Teste 2: Soma de -3.0 e 3.0
        real_a = -3.0;
        real_b = 3.0;
        a = $realtobits(real_a);
        b = $realtobits(real_b);
        #1;
        real_sum = $bitstoreal(sum);
        $display("Teste 2 | A: %f, B: %f, Soma: %f", real_a, real_b, real_sum);

        // Finalizar a simulação
        $finish;
    end

endmodule

