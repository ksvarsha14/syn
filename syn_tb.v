`timescale 1ns/1ps

module sync_fifo_tb;

reg clk;
reg reset;
reg wr_en;
reg rd_en;
reg [7:0] data_in;

wire [7:0] data_out;
wire full;
wire empty;

sync_fifo dut (
    .clk(clk),
    .reset(reset),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
);

initial begin

    clk = 0;

    forever #5 clk = ~clk;

end

initial begin

    reset = 1;
    wr_en = 0;
    rd_en = 0;
    data_in = 8'h00;

    #10;

    reset = 0;

    // Write 10
    #10;
    wr_en = 1;
    data_in = 8'h10;

    // Write 20
    #10;
    data_in = 8'h20;

    // Write 30
    #10;
    data_in = 8'h30;

    // Write 40
    #10;
    data_in = 8'h40;

    // Stop writing
    #10;
    wr_en = 0;

    // Read 10
    #10;
    rd_en = 1;

    #10;
    $display("Read Data = %h", data_out);

    // Read 20
    #10;
    $display("Read Data = %h", data_out);

    // Read 30
    #10;
    $display("Read Data = %h", data_out);

    // Read 40
    #10;
    $display("Read Data = %h", data_out);

    #20;

    $display("FIFO TEST COMPLETED");

    $stop;

end

endmodule