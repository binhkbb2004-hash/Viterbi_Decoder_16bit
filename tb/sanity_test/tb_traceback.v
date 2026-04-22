`timescale 1ns/1ps

module tb_traceback();
    reg         clk;
    reg         rst_n;
    reg         i_start;
    reg  [15:0] i_data;
    
    wire [7:0]  o_data;
    wire        o_done;

    // Dây nối giữa các module
    // extract_bit -> branch_metric
    wire [1:0]  w_rx;
    wire        w_valid_1, w_sof_1;

    // branch_metric -> ACS
    wire [1:0]  w_hd_00, w_hd_01, w_hd_10, w_hd_11;
    wire        w_valid_2, w_sof_2;

    // ACS -> memory, traceback
    wire [1:0]  w_prev_st_00, w_prev_st_01, w_prev_st_10, w_prev_st_11;
    wire [1:0]  w_slt_node; 
    wire        w_valid_3, w_sof_3;

    // memorry -> traceback
    wire [1:0]  w_bck_prev_st_00, w_bck_prev_st_01, w_bck_prev_st_10, w_bck_prev_st_11;
    wire        w_memory_done;

    // Khởi tạo và nối dây các Module
    // Module extract_bit
    extract_bit u_extract (
        .clk(clk), .rst_n(rst_n), .i_start(i_start), .i_data(i_data),
        .o_rx(w_rx), .o_valid(w_valid_1), .o_sof(w_sof_1)
    );

    // Module branch_metric
    branch_metric u_branch (
        .rst_n(rst_n), .i_valid(w_valid_1), .i_sof(w_sof_1), .i_rx(w_rx),
        .hd_00(w_hd_00), .hd_01(w_hd_01), .hd_10(w_hd_10), .hd_11(w_hd_11),
        .o_valid(w_valid_2), .o_sof(w_sof_2)
    );

    // Module add_comp_slt
    add_comp_slt u_acs (
        .clk(clk), .rst_n(rst_n), .i_valid(w_valid_2), .i_sof(w_sof_2),
        .hd_00(w_hd_00), .hd_01(w_hd_01), .hd_10(w_hd_10), .hd_11(w_hd_11),
        .prev_st_00(w_prev_st_00), .prev_st_01(w_prev_st_01), 
        .prev_st_10(w_prev_st_10), .prev_st_11(w_prev_st_11),
        .slt_node(w_slt_node),
        .o_valid(w_valid_3), .o_sof(w_sof_3)
    );

    // Module memory 
    memory u_memory (
        .clk(clk), .rst_n(rst_n), 
        .i_valid(w_valid_3), .i_sof(w_sof_3), 
        .prev_st_00(w_prev_st_00), .prev_st_01(w_prev_st_01), 
        .prev_st_10(w_prev_st_10), .prev_st_11(w_prev_st_11),
        .bck_prev_st_00(w_bck_prev_st_00), .bck_prev_st_01(w_bck_prev_st_01), 
        .bck_prev_st_10(w_bck_prev_st_10), .bck_prev_st_11(w_bck_prev_st_11),
        .o_memory_done(w_memory_done) 
    );

    // Module traceback 
    traceback u_traceback (
        .clk(clk), .rst_n(rst_n),
        .i_memory_done(w_memory_done),
        .slt_node(w_slt_node),
        .bck_prev_st_00(w_bck_prev_st_00), .bck_prev_st_01(w_bck_prev_st_01),
        .bck_prev_st_10(w_bck_prev_st_10), .bck_prev_st_11(w_bck_prev_st_11),
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
        // Khởi tạo hệ thống
        rst_n   = 0; 
        i_start = 0; 
        i_data  = 16'd0;

        // Nhả reset
        #25 rst_n = 1;
        @(negedge clk);
        
        // Input 11-01-00-11-11-10-10-10
        i_data  = 16'b11_01_00_11_11_10_10_10;
        i_start = 1;
        
        @(negedge clk);
        i_start = 0; 

        // Chờ cờ o_done bật lên
        wait(o_done == 1'b1);

        // Chờ thêm vài chu kì
        repeat (5) @(posedge clk);
        $stop;
    end
endmodule