module viterbi_top (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        i_start,
    input  wire [15:0] i_data,   // Dữ liệu mã hóa đầu vào
    output wire [7:0]  o_data,   // Dữ liệu giải mã đầu ra
    output wire        o_done    // Cờ báo hiệu hoàn tất
);
    // Khai báo dây nối nội bộ
    // extract_bit -> branch_metric
    wire [1:0]  w_rx;
    wire        w_valid_1;
    wire        w_sof_1;

    // branch_metric -> add_comp_slt
    wire [1:0]  w_hd_00, w_hd_01, w_hd_10, w_hd_11;
    wire        w_valid_2;
    wire        w_sof_2;

    // add_comp_slt -> memory & traceback
    wire [1:0]  w_prev_st_00, w_prev_st_01, w_prev_st_10, w_prev_st_11;
    wire [1:0]  w_slt_node; 
    wire        w_valid_3;
    wire        w_sof_3;

    // memory -> traceback
    wire [1:0]  w_bck_prev_st_00, w_bck_prev_st_01, w_bck_prev_st_10, w_bck_prev_st_11;
    wire        w_memory_done;

    // Khởi tạo và ghép nối các module con 
    // Module 1: extract_bit
    extract_bit u_extract(
        .clk             (       clk                ), 
        .rst_n           (       rst_n              ), 
        .i_start         (       i_start            ),
        .i_data          (       i_data             ),
        .o_rx            (       w_rx               ), 
        .o_valid         (       w_valid_1          ), 
        .o_sof           (       w_sof_1            )
    );

    // Module 2: branch_metric
    branch_metric u_bm   (
        .rst_n           (       rst_n              ), 
        .i_valid         (       w_valid_1          ), 
        .i_sof           (       w_sof_1            ), 
        .i_rx            (       w_rx               ),
        .hd_00           (       w_hd_00            ), 
        .hd_01           (       w_hd_01            ), 
        .hd_10           (       w_hd_10            ), 
        .hd_11           (       w_hd_11            ),
        .o_valid         (       w_valid_2          ), 
        .o_sof           (       w_sof_2            )
    );

    // Module 3: add_comp_slt
    add_comp_slt u_acs   (
        .clk             (       clk                ), 
        .rst_n           (       rst_n              ), 
        .i_valid         (       w_valid_2          ), 
        .i_sof           (       w_sof_2            ),
        .hd_00           (       w_hd_00            ), 
        .hd_01           (       w_hd_01            ), 
        .hd_10           (       w_hd_10            ), 
        .hd_11           (       w_hd_11            ),
        .prev_st_00      (       w_prev_st_00       ), 
        .prev_st_01      (       w_prev_st_01       ), 
        .prev_st_10      (       w_prev_st_10       ), 
        .prev_st_11      (       w_prev_st_11       ),
        .slt_node        (       w_slt_node         ),
        .o_valid         (       w_valid_3          ), 
        .o_sof           (       w_sof_3            )
    );

    // Module 4: memory
    memory u_memory      (
        .clk             (       clk                ), 
        .rst_n           (       rst_n              ), 
        .i_valid         (       w_valid_3          ), 
        .i_sof           (       w_sof_3            ), 
        .prev_st_00      (       w_prev_st_00       ), 
        .prev_st_01      (       w_prev_st_01       ), 
        .prev_st_10      (       w_prev_st_10       ), 
        .prev_st_11      (       w_prev_st_11       ),
        .bck_prev_st_00  (       w_bck_prev_st_00   ), 
        .bck_prev_st_01  (       w_bck_prev_st_01   ), 
        .bck_prev_st_10  (       w_bck_prev_st_10   ), 
        .bck_prev_st_11  (       w_bck_prev_st_11   ),
        .o_memory_done   (       w_memory_done      ) 
    );

    // Module 5: traceback
    traceback u_traceback(
        .clk             (       clk                ), 
        .rst_n           (       rst_n              ),
        .i_memory_done   (       w_memory_done      ),
        .i_slt_node      (       w_slt_node         ),
        .i_bck_prev_st_00(       w_bck_prev_st_00   ), 
        .i_bck_prev_st_01(       w_bck_prev_st_01   ),
        .i_bck_prev_st_10(       w_bck_prev_st_10   ), 
        .i_bck_prev_st_11(       w_bck_prev_st_11   ),
        .o_data          (       o_data             ),        
        .o_done          (       o_done             )         
    );
endmodule