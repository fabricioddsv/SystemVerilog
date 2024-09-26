// Code your testbench here
// or browse Examples
`include "modRef.sv" 
module somador_tb;
  logic [7:0] C0, C1,C2,C3,C4,C5,C6,C7, S_DUV, S_REF;
  logic [3:0] SELECT;
 
 
  mux_duv m_duv(C0,C1,C2,C3,C4,C5,C6,C7,SELECT, S_DUV);
  ref_mux m_ref(C0,C1,C2,C3,C4,C5,C6,C7,SELECT, S_REF);
 
  covergroup CG_C0 @(C0);
    coverpoint C0;
  endgroup

  covergroup CG_C1 @(C1);
    coverpoint C1;
  endgroup
  
  covergroup CG_C2 @(C2);
    coverpoint C2;
  endgroup
  
  covergroup CG_C3 @(C3);
    coverpoint C3;
  endgroup
  
  covergroup CG_C4 @(C4);
    coverpoint C4;
  endgroup
  
  covergroup CG_C5 @(C5);
    coverpoint C5;
  endgroup
  
  covergroup CG_C6 @(C6);
    coverpoint C6;
  endgroup
  
  covergroup CG_C7 @(C7);
    coverpoint C7;
  endgroup
  
  covergroup CG_SEL @(SELECT);
    coverpoint SELECT;
  endgroup
  
  covergroup CG_S_DUV @(S_DUV);
    coverpoint S_DUV;
  endgroup  
 
  covergroup CG_S_REF @(S_REF);
    coverpoint S_REF;
  endgroup  
 
 
initial
    begin
      /*$monitor($time,"    A=%d,   B=%d,  SOMA_DUV=%d",A,B,SOMA_DUV);*/
    end
 
initial
    begin
      CG_C0    cg_c0_inst = new;
      CG_C1    cg_c1_inst = new;
      CG_C2    cg_c2_inst = new;
      CG_C3    cg_c3_inst = new;
      CG_C4    cg_c4_inst = new;
      CG_C5    cg_c5_inst = new;
      CG_C6    cg_c6_inst = new;
      CG_C7    cg_c7_inst = new;
      CG_SEL   cg_sel_inst = new;
      CG_S_DUV cg_s_duv_inst = new;
      CG_S_REF cg_s_ref_inst = new;
      
      int t0=0, t1=0, t2=0, t3=0, t4=0, t5=0, t6=0, t7=0;
      
      
      while( (cg_c0_inst.get_coverage() < 100) || (cg_c1_inst.get_coverage() < 100) || (cg_c2_inst.get_coverage() < 100) || (cg_c3_inst.get_coverage() < 100) || (cg_c4_inst.get_coverage() < 100) || (cg_c5_inst.get_coverage() < 100) || (cg_c6_inst.get_coverage() < 100 || cg_c7_inst.get_coverage() < 100)  ||(cg_s_duv_inst.get_coverage() < 100) || (cg_s_ref_inst.get_coverage() < 100) )
         begin
           C0 = $urandom_range(0,255);
           C1 = $urandom_range(0,255);
           C2 = $urandom_range(0,255);
           C3 = $urandom_range(0,255);
           C4 = $urandom_range(0,255);
           C5 = $urandom_range(0,255);
           C6 = $urandom_range(0,255);
           C7 = $urandom_range(0,255);
           
           SELECT = $urandom_range(0,7);
           
           if ( (cg_c0_inst.get_coverage() != t0) || (cg_c1_inst.get_coverage() != t1) || (cg_c2_inst.get_coverage() != t2) || (cg_c3_inst.get_coverage() != t3 ) || (cg_c4_inst.get_coverage() != t4) || (cg_c5_inst.get_coverage() != t5) || (cg_c6_inst.get_coverage() != t6) || (cg_c7_inst.get_coverage() != t7) )
           begin
             $display($time, "  C0 = %.2f%%  C1 = %.2f%%  C2 = %.2f%%  C3 = %.2f%%  C4 = %.2f%%  C5 = %.2f%%  C6 = %.2f%%  C7 = %.2f%%  S_DUV = %.2f%%  S_REF = %.2f%%", 
               cg_c0_inst.get_coverage(),
               cg_c1_inst.get_coverage(),
               cg_c2_inst.get_coverage(),
               cg_c3_inst.get_coverage(),
               cg_c4_inst.get_coverage(),
               cg_c5_inst.get_coverage(),
               cg_c6_inst.get_coverage(),
               cg_c7_inst.get_coverage(),
               cg_s_duv_inst.get_coverage(),
               cg_s_ref_inst.get_coverage());
           
           t0 = cg_c0_inst.get_coverage();
           t1 = cg_c1_inst.get_coverage();
           t2 = cg_c2_inst.get_coverage();
           t3 = cg_c3_inst.get_coverage();
           t4 = cg_c4_inst.get_coverage();
           t5 = cg_c5_inst.get_coverage();
           t6 = cg_c6_inst.get_coverage();
           t7 = cg_c7_inst.get_coverage();
             
           end
           
           #1;
           
           
         if(S_DUV!=S_REF)
           begin
             
           $display("\nErro encontrado!");
           
             $display($time, "  C0 = %d  C1 = %d  C2 = %d  C3 = %d  C4 = %d  C5 = %d  C6 = %d  C7 = %d  SELECT: %d  SAÍDA_DUV: %d SAIDA_REF: %d ", C0, C1, C2, C3, C4, C5, C6, C7, SELECT, S_DUV, S_REF);
             
           break;
           end
         
         end
      
      $display($time, "\n C0 = %.2f%%\n C1 = %.2f%%\n C2 = %.2f%%\n C3 = %.2f%%\n C4 = %.2f%%\n C5 = %.2f%%\n C6 = %.2f%%\n C7 = %.2f%%\n S_DUV = %.2f%%\n S_REF = %.2f%%", 
               cg_c0_inst.get_coverage(),
               cg_c1_inst.get_coverage(),
               cg_c2_inst.get_coverage(),
               cg_c3_inst.get_coverage(),
               cg_c4_inst.get_coverage(),
               cg_c5_inst.get_coverage(),
               cg_c6_inst.get_coverage(),
               cg_c7_inst.get_coverage(),
               cg_s_duv_inst.get_coverage(),
               cg_s_ref_inst.get_coverage());
      
    $display( "FIM" );
    $finish;
    end
     
endmodule 
