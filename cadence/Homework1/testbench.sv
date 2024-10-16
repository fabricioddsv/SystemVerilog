//`include "somador_pkg.sv"  // Incluir o pacote com a definição do tipo float32_t

module float_adder_tb;

    import float_adder_pkg::*;  // Importar o pacote contendo a definição de float32_t

    // Sinais
    logic [31:0] a, b, sum;
    
    // Instanciar o somador de ponto flutuante
    float_adder uut (
        .a(a),
        .b(b),
        .sum(sum)
    );

    // Variáveis de ponto flutuante em shortreal para o banco de testes
    shortreal real_a, real_b, real_sum;

    initial begin
        // Teste 1
        real_a = 3.14;
        real_b = 1.59;
        a = $shortrealtobits(real_a);
        b = $shortrealtobits(real_b);
        #1; // Aguardar um ciclo
        real_sum = $bitstoshortreal(sum);
        $display("A: %f, B: %f, Sum: %f", real_a, real_b, real_sum);

        // Teste 2
        real_a = -2.5;
        real_b = 4.1;
        a = $shortrealtobits(real_a);
        b = $shortrealtobits(real_b);
        #1;
        real_sum = $bitstoshortreal(sum);
        $display("A: %f, B: %f, Sum: %f", real_a, real_b, real_sum);

        // Teste 3
        real_a = 10.0;
        real_b = -5.5;
        a = $shortrealtobits(real_a);
        b = $shortrealtobits(real_b);
        #1;
        real_sum = $bitstoshortreal(sum);
        $display("A: %f, B: %f, Sum: %f", real_a, real_b, real_sum);

        $finish;
    end

endmodule





