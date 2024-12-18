`include "somador_pkg.sv"

module float_adder (
    input  logic [31:0] a,
    input  logic [31:0] b,
    output logic [31:0] sum
);

    import float_adder_pkg::*;
  
    float32_t fa, fb, fsum;
    logic [7:0] exp_diff;
    logic [23:0] aligned_mant_a, aligned_mant_b;
    logic [24:0] mant_sum;
    logic [7:0] exp_sum;

    always_comb begin
        fa.sign     = a[31];
        fa.exponent = a[30:23];
        fa.mantissa = a[22:0];

        fb.sign     = b[31];
        fb.exponent = b[30:23];
        fb.mantissa = b[22:0];

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

        if (mant_sum[24]) begin
            mant_sum = mant_sum >> 1;
            exp_sum = exp_sum + 1;
        end else if (!mant_sum[23]) begin
            while (!mant_sum[23] && exp_sum > 0) begin
                mant_sum = mant_sum << 1;
                exp_sum = exp_sum - 1;
            end
        end
        fsum.exponent = exp_sum;
        fsum.mantissa = mant_sum[22:0];
    end

    assign sum = {fsum.sign, fsum.exponent, fsum.mantissa};

endmodule

