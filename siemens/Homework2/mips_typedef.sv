module mips_typedef;

    typedef struct packed {
        logic [5:0] opcode;
        logic [4:0] rs, rt, rd;
        logic [4:0] shamt;
        logic [5:0] funct;
    } mips_r_type;

    typedef struct packed {
        logic [5:0] opcode;
        logic [4:0] rs, rt;
        logic [15:0] immediate;
    } mips_i_type;

    typedef struct packed {
        logic [5:0] opcode;
        logic [25:0] address;
    } mips_j_type;

    typedef union packed {
        mips_r_type r;
        mips_i_type i;
        mips_j_type j;
    } mips_instruction;

endmodule

