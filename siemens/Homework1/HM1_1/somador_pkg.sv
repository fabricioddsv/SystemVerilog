package float_adder_pkg;
    typedef struct packed {
        logic sign;
        logic [7:0] exponent;
        logic [22:0] mantissa;
    } float32_t;
endpackage

