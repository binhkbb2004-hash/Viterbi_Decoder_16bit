`timescale 1ns / 1ps

module tb_add_comp_slt();
    reg         clk;
    reg         rst_n;
    reg         i_start;
    reg  [15:0] i_data;

    // Dây nối giữa extract_bit -> branch_metric
    wire [1:0]  w_rx;
    wire        w_valid_1;
    wire        w_sof_1;

    // Dây nối giữa branch_metric -> ACS
    wire [1:0]  hd_00, hd_01, hd_10, hd_11;
    wire        w_valid_2;
    wire        w_sof_2;

    // Tín hiệu ngõ ra của ACS
    wire [1:0]  prev_st_00, prev_st_01, prev_st_10, prev_st_11;
    wire [1:0]  slt_node;
    wire        o_valid;
    wire        o_sof;

    // Khởi tạo các module
    // Module 1: extract_bit
    extract_bit u_extract (
        .clk(clk), .rst_n(rst_n), .i_start(i_start), .i_data(i_data),
        .o_rx(w_rx), .o_valid(w_valid_1), .o_sof(w_sof_1)
    );

    // Module 2: branch_metric
    branch_metric u_branch (
        .rst_n(rst_n), .i_valid(w_valid_1), .i_sof(w_sof_1), .i_rx(w_rx),
        .hd_00(hd_00), .hd_01(hd_01), .hd_10(hd_10), .hd_11(hd_11),
        .o_valid(w_valid_2), .o_sof(w_sof_2)
    );

    // Module 3: ACS
    add_comp_slt u_acs (
        .clk(clk), .rst_n(rst_n), .i_valid(w_valid_2), .i_sof(w_sof_2),
        .hd_00(hd_00), .hd_01(hd_01), .hd_10(hd_10), .hd_11(hd_11),
        .prev_st_00(prev_st_00), .prev_st_01(prev_st_01), 
        .prev_st_10(prev_st_10), .prev_st_11(prev_st_11),
        .slt_node(slt_node),
        .o_valid(o_valid), .o_sof(o_sof)
    );

    // Tạo Clock
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Kịch bản Test
    initial begin
        rst_n = 0; i_start = 0; i_data = 0;
        #25 rst_n = 1;

        @(negedge clk);
        
        // Nạp chuỗi bit 10_01_00_10_11_01_11 nhé
        i_data  = 16'b11_10_01_00_10_11_01_11; 
        i_start = 1;
        @(negedge clk);
        i_start = 0;

        // Đợi 12 chu kỳ
        repeat (12) @(posedge clk);

        $stop;
    end
    
endmodule