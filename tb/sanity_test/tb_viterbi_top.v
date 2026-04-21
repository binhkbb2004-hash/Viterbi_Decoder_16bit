`timescale 1ns/1ps

module tb_viterbi_top();
    reg         clk;
    reg         rst_n;
    reg         i_start; 
    reg  [15:0] i_data;
    
    wire [7:0]  o_data;
    wire        o_done;

    // Khởi tạo module top
    viterbi_top uut_top (
        .clk(clk),
        .rst_n(rst_n),
        .i_start(i_start),
        .i_data(i_data),
        .o_data(o_data),
        .o_done(o_done)
    );

    // Tạo Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    // Kịch bản test
    initial begin
        // Khởi tạo trạng thái ban đầu
        rst_n   = 0; 
        i_start = 0; 
        i_data  = 16'd0;

        // Đợi 2.5 chu kỳ rồi nhả reset
        #25 rst_n = 1;

        @(negedge clk);
        
        // Input
        i_data  = 16'b11_11_00_11_11_10_00_10; 
        i_start = 1;
        
        @(negedge clk);
        i_start = 0;

        // Chờ cờ o_done lên 1 
        wait(o_done == 1'b1);

        // Chờ thêm vài chu kì
        repeat (5) @(posedge clk);

        $stop;
    end
endmodule