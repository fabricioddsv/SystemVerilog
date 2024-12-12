`include "design.sv"  

module float_adder_tb;
    import float_adder_pkg::*;

    logic [31:0] a, b, sum;
    logic sign1, sign2;
    logic [7:0] exponent1, exponent2;
    logic [22:0] mantissa1, mantissa2;
    logic [31:0] float_bits1, float_bits2; 
    shortreal real_a, real_b, real_sum;    

    float_adder uut (
        .a(a),
        .b(b),
        .sum(sum)
    );

    initial begin
        repeat (100) begin
            sign1 = $urandom_range(0, 1);
            sign2 = $urandom_range(0, 1);
            exponent1 = $urandom_range(1, 254);
            exponent2 = $urandom_range(1, 254);
          mantissa1 = $urandom_range(0, 23'h7FFFFF);
          mantissa2 = $urandom_range(0, 23'h7FFFFF);

            float_bits1 = {sign1, exponent1, mantissa1};
            float_bits2 = {sign2, exponent2, mantissa2};

            real_a = $bitstoshortreal(float_bits1);
            real_b = $bitstoshortreal(float_bits2);

            a = $shortrealtobits(real_a);
            b = $shortrealtobits(real_b);

            #10; 
            real_sum = $bitstoshortreal(sum);


          if ( (real_a+real_b)!=real_sum) $display("Soma inválida! A: %f, B: %f, Soma: %f", real_a, real_b, real_sum);
          else $display("A: %f, B: %f, Soma: %f", real_a, real_b, real_sum);
        
        end

        $finish;
    end

endmodule

