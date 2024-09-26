// Code your testbench here
// or browse Examples
`include "ModRef.sv"
module tb_CI74F189;
  logic WE,CS;
  logic [3:0] A,D,O,OR;
  int t1,t2,t3,t4;
  
  CI74F189 memRam(A,D,O,WE,CS);
  modRef memRef(A,D,OR,WE,CS);
  
  wire [15:0][3:0]matriz;
  
  covergroup CG_A @(A);
    coverpoint A;
  endgroup: CG_A
  
  covergroup CG_D @(D);
    coverpoint D;
  endgroup: CG_D
  
  covergroup CG_O @(O);
  	coverpoint O;	
  endgroup: CG_O
    
  covergroup CG_ADO @(A,D);
    CROSS: cross A, D; 
  endgroup:CG_ADO
  
  logic [3:0] t;
  
  initial begin
    WE=0;
    A=10;
    D=12;
    CS=0;
  end
  
  initial begin 
    CG_A   cg_a_inst =new;
    CG_D   cg_d_inst =new;
    CG_O   cg_o_inst =new;
    CG_ADO cg_ado_inst =new;
    
    while( (cg_a_inst.get_coverage()<100) ||(cg_d_inst.get_coverage()<100) ||(cg_o_inst.get_coverage()<100) ||(cg_ado_inst.get_coverage()<100) )
      begin
        CS=0;
        WE=0;
        A = $urandom_range(0,16);
        D=$urandom_range(0,16);
        #1
        if(OR===4'bzzzz)begin
          #1
          WE=1;
          #1
          if(OR!=~D)begin
            $display("erro");
            break;
          end
          
        end
        else begin
          $display("erro");
          break;
        end
        #1
        if((t1!=cg_a_inst.get_coverage())||(t2!=cg_d_inst.get_coverage())||(t3!=cg_o_inst.get_coverage())||(t4!=cg_ado_inst.get_coverage()))begin
          $display("A:%d%%  D:%d%%  O: %d%% AXD: %d%%",cg_a_inst.get_coverage(),cg_d_inst.get_coverage(),cg_o_inst.get_coverage(),cg_ado_inst.get_coverage());
        end
           
    t1=cg_a_inst.get_coverage();
    t2=cg_d_inst.get_coverage();
    t3=cg_o_inst.get_coverage();
    t4=cg_ado_inst.get_coverage();
      
      end
  $display("A:%d%%  D:%d%%  O: %d%% AXD: %d%%",cg_a_inst.get_coverage(),cg_d_inst.get_coverage(),cg_o_inst.get_coverage(),cg_ado_inst.get_coverage());
  end
endmodule: tb_CI74F189

