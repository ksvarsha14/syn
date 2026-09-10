`timescale 1ns/1ps

module sync_fifo (
    clk,
    reset,
    wr_en,
    rd_en,
    data_in,
    data_out,
    full,
    empty
);

input clk;
input reset;
input wr_en;
input rd_en;

input [7:0] data_in;

output [7:0] data_out;
output full;
output empty;

reg [7:0] data_out;
reg full;
reg empty;

reg [7:0] mem [0:7];

integer wr_ptr;
integer rd_ptr;
integer count;

always @(posedge clk) begin

    if (reset == 1'b1) begin

        wr_ptr = 0;
        rd_ptr = 0;
        count = 0;
        data_out = 8'b00000000;

    end
    else begin

        if ((wr_en == 1'b1) && (count < 8)) begin

            mem[wr_ptr] = data_in;

            if (wr_ptr == 7)
                wr_ptr = 0;
            else
                wr_ptr = wr_ptr + 1;

            count = count + 1;

        end

        if ((rd_en == 1'b1) && (count > 0)) begin

            data_out = mem[rd_ptr];

            if (rd_ptr == 7)
                rd_ptr = 0;
            else
                rd_ptr = rd_ptr + 1;

            count = count - 1;

        end

    end

end

always @(*) begin

    if (count == 0)
        empty = 1'b1;
    else
        empty = 1'b0;

    if (count == 8)
        full = 1'b1;
    else
        full = 1'b0;

end

endmodule