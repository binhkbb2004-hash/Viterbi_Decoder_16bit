module tb_memory();
    reg         clk;
    reg         rst_n;
    reg         i_start;
    reg  [15:0] i_data;

    // Dây nối giữa các module
    // Dây từ extract_bit -> branch_metric
    wire [1:0]  w_rx;
    wire        w_valid_1;
    wire        w_sof_1;

    // Dây từ branch_metric -> ACS
    wire [1:0]  w_hd_00, w_hd_01, w_hd_10, w_hd_11;
    wire        w_valid_2;
    wire        w_sof_2;

    // Dây từ ACS -> memory, traceback
    wire [1:0]  w_prev_st_00, w_prev_st_01, w_prev_st_10, w_prev_st_11;
    wire        w_valid_3;
    wire        w_sof_3;
    wire [1:0]  w_slt_node; // Dây này nối sang Traceback

    // Output của khối memory
    wire [1:0]  o_bck_prev_st_00;
    wire [1:0]  o_bck_prev_st_01;
    wire [1:0]  o_bck_prev_st_10;
    wire [1:0]  o_bck_prev_st_11;
    wire        o_memory_done;

    // Khởi tạo và nối dây các module
    // Module 1: extract_bit
    extract_bit u_extract (
        .clk(clk), .rst_n(rst_n), .i_start(i_start), .i_data(i_data),
        .o_rx(w_rx), .o_valid(w_valid_1), .o_sof(w_sof_1)
    );

    // Module 2: branch_metric
    branch_metric u_branch (
        .rst_n(rst_n), .i_valid(w_valid_1), .i_sof(w_sof_1), .i_rx(w_rx),
        .hd_00(w_hd_00), .hd_01(w_hd_01), .hd_10(w_hd_10), .hd_11(w_hd_11),
        .o_valid(w_valid_2), .o_sof(w_sof_2)
    );

    // Module 3: ACS
    add_comp_slt u_acs (
        .clk(clk), .rst_n(rst_n), .i_valid(w_valid_2), .i_sof(w_sof_2),
        .hd_00(w_hd_00), .hd_01(w_hd_01), .hd_10(w_hd_10), .hd_11(w_hd_11),
        .prev_st_00(w_prev_st_00), .prev_st_01(w_prev_st_01), 
        .prev_st_10(w_prev_st_10), .prev_st_11(w_prev_st_11),
        .slt_node(w_slt_node),
        .o_valid(w_valid_3), .o_sof(w_sof_3)
    );

    // Module 4: memory
    memory u_memory (
        .clk(clk), .rst_n(rst_n), 
        .i_valid(w_valid_3), .i_sof(w_sof_3),
        .prev_st_00(w_prev_st_00), .prev_st_01(w_prev_st_01),
        .prev_st_10(w_prev_st_10), .prev_st_11(w_prev_st_11),
        .bck_prev_st_00(o_bck_prev_st_00), .bck_prev_st_01(o_bck_prev_st_01),
        .bck_prev_st_10(o_bck_prev_st_10), .bck_prev_st_11(o_bck_prev_st_11),
        .o_memory_done(o_memory_done)
    );

    // Tạo Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    // Kịch bản Test
    initial begin
        // Khởi tạo hệ thống
        rst_n   = 0; 
        i_start = 0; 
        i_data  = 16'd0;

        // Đợi 2.5 chu kỳ rồi nhả reset
        #25 rst_n = 1;

        @(negedge clk);
        
        // Input 11_10_01_00_10_11_01_11
        i_data  = 16'b11_10_01_00_10_11_01_11; 
        i_start = 1;
        
        @(negedge clk);
        i_start = 0;

        // Chờ cờ o_memory_done lên 1 báo hiệu kết thúc pha ghi chuyển sang pha đọc
        wait(o_memory_done == 1'b1);

        // Đợi thêm 10 chu kỳ để quan sát pha Traceback
        repeat (10) @(posedge clk);

        $stop;
    end
endmodule