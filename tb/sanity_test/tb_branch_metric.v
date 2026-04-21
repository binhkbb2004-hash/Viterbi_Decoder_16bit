`timescale 1ns / 1ps

module tb_branch_metric();
    reg         clk;
    reg         rst_n;
    reg         i_start;
    reg  [15:0] i_data;

    // Dây nối giữa 2 module
    wire [1:0]  w_rx;
    wire        w_valid;
    wire        w_sof;

    // Tín hiệu đầu ra từ branch_metric
    wire [1:0]  hd_00, hd_01, hd_10, hd_11;
    wire        o_valid;
    wire        o_sof;

    // Khởi tạo các module
    // Module 1: extract_bit
    extract_bit u_extract (
        .clk(clk),
        .rst_n(rst_n),
        .i_start(i_start),
        .i_data(i_data),
        .o_rx(w_rx),
        .o_valid(w_valid),
        .o_sof(w_sof)
    );

    // Module 2: branch_metric
    branch_metric u_branch (
        .rst_n(rst_n),
        .i_valid(w_valid),   // Nối từ extract_bit
        .i_sof(w_sof),       // Nối từ extract_bit
        .i_rx(w_rx),         // Nối từ extract_bit
        .hd_00(hd_00), 
        .hd_01(hd_01), 
        .hd_10(hd_10), 
        .hd_11(hd_11),
        .o_valid(o_valid),   // Xuất ra ngoài
        .o_sof(o_sof)        // Xuất ra ngoài
    );

    // Tạo Clock
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Kịch bản Test
    initial begin
        rst_n   = 0;
        i_start = 0;
        i_data  = 16'd0;

        #25 rst_n = 1;

        @(negedge clk);
        // Input 11_10_01_00_10_11_01_11
        i_data  = 16'b11_10_01_00_10_11_01_11; 
        i_start = 1;
        
        @(negedge clk);
        i_start = 0;

        // Đợi 10 chu kỳ
        repeat (10) @(posedge clk);

        $stop;
    end
endmodule