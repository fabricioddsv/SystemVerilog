package float_adder_pkg;

    // Definição do tipo para números de ponto flutuante IEEE 754 de precisão simples (32 bits)
    typedef struct packed {
        logic sign;
        logic [7:0] exponent;
        logic [22:0] mantissa;
    } float32_t;

endpackage

