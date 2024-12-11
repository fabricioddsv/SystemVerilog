module mips_decoder;

    function void decode_instruction(input mips_instruction instr);
        case (instr.r.opcode)
            6'b000000: begin // R-Type
                $display("R-Type | rs: %h, rt: %h, rd: %h, shamt: %h, funct: %h",
                         instr.r.rs, instr.r.rt, instr.r.rd, instr.r.shamt, instr.r.funct);
            end
            default: $display("Unknown Instruction");
        endcase
    endfunction

endmodule

