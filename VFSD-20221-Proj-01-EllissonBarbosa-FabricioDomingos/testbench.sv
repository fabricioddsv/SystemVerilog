`include "ModRef.sv" 
module somador_tb;
  logic signed [3:0] A,B;
  logic signed [3:0] SOMA_DUV, SOMA_REF;
  bit flag_DUV, flag_REF;
 
  soma_DUV somador_DUV(A,B,SOMA_DUV,flag_DUV);
  soma_ModRef somador_REF(A,B,SOMA_REF,flag_REF);
 
  covergroup CG_A @(A);
    coverpoint A;
  endgroup

  covergroup CG_B @(B);
    coverpoint B;
  endgroup
  covergroup CG_A_B @(A,B);
    AeB:cross A,B;
  endgroup
  covergroup CG_S_DUV @(SOMA_DUV);
    coverpoint SOMA_DUV;
  endgroup  
 
  covergroup CG_S_REF @(SOMA_REF);
    coverpoint SOMA_REF;
  endgroup  
 
  covergroup CG_F_DUV @(flag_DUV);
    coverpoint flag_DUV;
  endgroup  
 
  covergroup CG_F_REF @(flag_REF);
    coverpoint flag_REF;
  endgroup  
 
 
initial
    begin
      /*$monitor($time,"    A=%d,   B=%d,  SOMA_DUV=%d",A,B,SOMA_DUV);*/
    end
 
initial
    begin
      CG_A     cg_a_inst = new;
      CG_B     cg_b_inst = new;
      CG_S_DUV cg_s_duv_inst = new;
      CG_S_REF cg_s_ref_inst = new;
      CG_F_DUV cg_f_duv_inst = new;
      CG_F_REF cg_f_ref_inst = new;
      CG_A_B cg_a_b=new;
     
      while( (cg_a_inst.get_coverage() < 100) | (cg_b_inst.get_coverage() < 100) | (cg_s_duv_inst.get_coverage() < 100)|( cg_a_b.get_coverage()<100))
         begin
           A = $urandom_range(7,-8); B = $urandom_range(7,-8);
           
           #1
           $display ($time," CG_A = %.2f%%  CG_B = %.2f%%  CG_A_B = %.2f%%  CG_S_REF = %.2f%%  CG_S_DUV = %.2f%%  CG_F_REF = %2.F%% CG_F_DUV = %.2f%%\n",  
                     cg_a_inst.get_coverage(),
                     cg_b_inst.get_coverage(),
                     cg_a_b.get_coverage(),
                     cg_s_duv_inst.get_coverage(),
                     cg_s_ref_inst.get_coverage(),
                     cg_f_duv_inst.get_coverage(),
                     cg_f_ref_inst.get_coverage());

           if(flag_REF != flag_DUV ||SOMA_DUV!=SOMA_REF) begin
            $display("\nErro encontrado!");
             $display("A: %d   B:  %d   DUV: %d  ModRef:  %d  \n flag_DUV =  %d  flag_REF =  %d\nFLAG_DUV != FLAG_REF !!!", A, B, SOMA_DUV, SOMA_REF, flag_DUV, flag_REF);
          break;
           end
         
         end

    $display( "FIM" );
    $finish;
    end
     
endmodule 
