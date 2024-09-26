// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
`include "cont_rf.sv"

module contador_tb;
  bit CK, RESET, UPDOWN;
  wire [3:0] OUT_DUV, OUT_REF;
  
  cont    contDUV(CK, RESET, UPDOWN, OUT_DUV);
  cont_rf contRF(CK, RESET, UPDOWN, OUT_REF);
  
  covergroup CG_CK @(CK);
    coverpoint CK;
  endgroup
  
  covergroup CG_RST @(RESET);
    coverpoint RESET;
  endgroup
  
  covergroup CG_UD @(UPDOWN);
    coverpoint UPDOWN;
  endgroup
  
  covergroup CG_O_DUV @(OUT_DUV);
    coverpoint OUT_DUV;
  endgroup
  
  covergroup CG_O_REF @(OUT_REF);
    coverpoint OUT_REF;
  endgroup
  
  covergroup CG_CRSS @(RESET, UPDOWN, OUT_DUV);
    cr: cross RESET, UPDOWN, OUT_DUV;
  endgroup:CG_CRSS;
  
  initial  	
    begin
      CG_CK    cg_ck_inst = new;
      CG_RST   cg_rst_inst = new;
      CG_UD	   cg_ud_inst = new;
      CG_O_REF cg_o_ref_inst = new;
      CG_O_DUV cg_o_duv_inst = new;
      CG_CRSS  cg_crss_inst = new;
      
      CK = 1;
      RESET = 0;
      UPDOWN = 1;
      
      while  ( (cg_ck_inst.get_coverage() < 100) || (cg_rst_inst.get_coverage() < 100) || (cg_ud_inst.get_coverage()<100) || (cg_o_ref_inst.get_coverage() < 100) ||(cg_crss_inst.get_coverage()<100))
        begin
          CK = ~CK;
          if (cg_rst_inst.get_coverage()<100)RESET = $urandom_range(0,2);
          else RESET=0;
          UPDOWN = $urandom_range(0,2);
          
          #1
          if ( OUT_DUV!=OUT_REF)
            begin
              $display("Erro encontrado! DUV: %d != REF: %d",
                        OUT_DUV,
                        OUT_REF );
              break;
            end
          
            $display("CK: %d%%,  RESET %d%%,  UPDOWN: %d%%, OUT_DUV: %d%%,  OUT_REF:  %d%%, CROSS:  %d%%",
               cg_ck_inst.get_coverage(),
               cg_rst_inst.get_coverage(),
               cg_ud_inst.get_coverage(),
               cg_o_duv_inst.get_coverage(),
               cg_o_ref_inst.get_coverage(),
               cg_crss_inst.get_coverage() );
        end
    end
      initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
endmodule: contador_tb
      
  
  
  
  
  
