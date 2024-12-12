`include "design.sv"
`include "slave_module.sv"
module tb_slave_ds;
    parameter int BUS_WIDTH = 8;
    parameter logic [7:0] id = 8'hF0;

    logic clk, reset;
    bus_if #(BUS_WIDTH) slave_br();

    slave_ds #(.BUS_WIDTH(BUS_WIDTH), .id(id)) uut (
        .slave_br(slave_br),
        .clk(clk),
        .reset(reset)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1;
        #10 reset = 0;

        slave_br.address = id;
        slave_br.RB = 0;
        slave_br.WB = 1;
        slave_br.data = 8'hA5;
        #10;

        $display("WRITE: Data=%h, Parity=%b, ACK=%b", slave_br.data, slave_br.PARITY, slave_br.ACK);
        slave_br.RB = 1;
        slave_br.WB = 0;
        #10;

        $display("READ: Data=%h, Parity=%b, ACK=%b", slave_br.data, slave_br.PARITY, slave_br.ACK);
        $finish;
    end
endmodule

