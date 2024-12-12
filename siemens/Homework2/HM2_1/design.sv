module float_adder_double (
    input  logic [63:0] a,
    input  logic [63:0] b,
    output logic [63:0] sum
);

    typedef struct packed {
        logic sign;
        logic [10:0] exponent;
        logic [51:0] mantissa;
    } float64_t;

    float64_t fa, fb, fsum;
    logic [10:0] exp_diff;
    logic [52:0] aligned_mant_a, aligned_mant_b;
    logic [53:0] mant_sum;
    logic [10:0] exp_sum;

    always_comb begin
        fa = {a[63], a[62:52], a[51:0]};
        fb = {b[63], b[62:52], b[51:0]};

        if (fa.exponent > fb.exponent) begin
            exp_diff = fa.exponent - fb.exponent;
            aligned_mant_a = {1'b1, fa.mantissa};
            aligned_mant_b = {1'b1, fb.mantissa} >> exp_diff;
            exp_sum = fa.exponent;
        end else begin
            exp_diff = fb.exponent - fa.exponent;
            aligned_mant_a = {1'b1, fa.mantissa} >> exp_diff;
            aligned_mant_b = {1'b1, fb.mantissa};
            exp_sum = fb.exponent;
        end

        if (fa.sign == fb.sign) begin
            mant_sum = aligned_mant_a + aligned_mant_b;
            fsum.sign = fa.sign;
        end else begin
            if (aligned_mant_a >= aligned_mant_b) begin
                mant_sum = aligned_mant_a - aligned_mant_b;
                fsum.sign = fa.sign;
            end else begin
                mant_sum = aligned_mant_b - aligned_mant_a;
                fsum.sign = fb.sign;
            end
        end

        if (mant_sum[53]) begin
            mant_sum = mant_sum >> 1;
            exp_sum = exp_sum + 1;
        end else if (!mant_sum[52]) begin
            while (!mant_sum[52] && exp_sum > 0) begin
                mant_sum = mant_sum << 1;
                exp_sum = exp_sum - 1;
            end
        end

        fsum.exponent = exp_sum;
        fsum.mantissa = mant_sum[51:0];
    end

    assign sum = {fsum.sign, fsum.exponent, fsum.mantissa};

endmodule

