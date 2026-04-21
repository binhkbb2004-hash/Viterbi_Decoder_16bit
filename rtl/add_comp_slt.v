module add_comp_slt (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       i_valid, 
    input  wire       i_sof,   
    input  wire [1:0] hd_00, hd_01, hd_10, hd_11,
    
    // Dữ liệu xuất ra cho memory và traceback
    output reg  [1:0] prev_st_00, prev_st_01, prev_st_10, prev_st_11,
    output reg  [1:0] slt_node,
    
    // Tín hiệu Hand-shake xuất ra cho memory
    output reg        o_valid,  
    output reg        o_sof     
);

    // Thanh ghi lưu PM nội bộ
    reg [5:0] pm_00, pm_01, pm_10, pm_11;

    // Nếu i_sof = 1 -> Chu kì đầu, giá trị khởi tạo của PM 4 trạng thái: 0, 31, 31, 31 (Spec)
    // Nếu i_sof = 0 -> Dùng điểm PM cũ đang lưu trong thanh ghi
    wire [5:0] base_00 = i_sof ? 6'd0  : pm_00;
    wire [5:0] base_01 = i_sof ? 6'd31 : pm_01;
    wire [5:0] base_10 = i_sof ? 6'd31 : pm_10;
    wire [5:0] base_11 = i_sof ? 6'd31 : pm_11;

    // BƯỚC 1: ADD (Theo 4 PT 2-1 tới 2-4 trong Spec)
    wire [5:0] c_00_from_00 = base_00 + hd_00;
    wire [5:0] c_00_from_01 = base_01 + hd_11; 
    
    wire [5:0] c_10_from_00 = base_00 + hd_11;
    wire [5:0] c_10_from_01 = base_01 + hd_00;

    wire [5:0] c_01_from_10 = base_10 + hd_10;
    wire [5:0] c_01_from_11 = base_11 + hd_01;

    wire [5:0] c_11_from_10 = base_10 + hd_01;
    wire [5:0] c_11_from_11 = base_11 + hd_10;

    // BƯỚC 2: COMPARE & SELECT (Chọn đường đi cho từng State)
    wire [5:0] sum00  = (c_00_from_00 <= c_00_from_01) ? c_00_from_00 : c_00_from_01;
    wire [1:0] src_00 = (c_00_from_00 <= c_00_from_01) ? 2'b00 : 2'b01;

    wire [5:0] sum10  = (c_10_from_00 <= c_10_from_01) ? c_10_from_00 : c_10_from_01;
    wire [1:0] src_10 = (c_10_from_00 <= c_10_from_01) ? 2'b00 : 2'b01;

    wire [5:0] sum01  = (c_01_from_10 <= c_01_from_11) ? c_01_from_10 : c_01_from_11;
    wire [1:0] src_01 = (c_01_from_10 <= c_01_from_11) ? 2'b10 : 2'b11;

    wire [5:0] sum11  = (c_11_from_10 <= c_11_from_11) ? c_11_from_10 : c_11_from_11;
    wire [1:0] src_11 = (c_11_from_10 <= c_11_from_11) ? 2'b10 : 2'b11;

    // BƯỚC 3: TÌM BEST NODE (thứ tự ưu tiên nếu pm bằng nhau: 00 > 10 > 01 > 11)
    wire [5:0] min_00_10  = (sum00 <= sum10) ? sum00 : sum10;
    wire [1:0] node_00_10 = (sum00 <= sum10) ? 2'b00 : 2'b10;
    
    wire [5:0] min_01_11  = (sum01 <= sum11) ? sum01 : sum11;
    wire [1:0] node_01_11 = (sum01 <= sum11) ? 2'b01 : 2'b11;
    
    wire [1:0] best_node  = (min_00_10 <= min_01_11) ? node_00_10 : node_01_11;

    // BƯỚC 4: LOGIC TUẦN TỰ, cập nhật thanh ghi
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pm_00      <= 6'd0;
            pm_01      <= 6'd0;
            pm_10      <= 6'd0;
            pm_11      <= 6'd0;
            prev_st_00 <= 2'b00;
            prev_st_01 <= 2'b00;
            prev_st_10 <= 2'b00;
            prev_st_11 <= 2'b00;
            slt_node   <= 2'b00;
            o_valid    <= 1'b0;
            o_sof      <= 1'b0;
        end 
        else if (i_valid) begin
            // Chỉ chốt dữ liệu khi cờ i_valid báo có dữ liệu
            pm_00      <= sum00;
            pm_01      <= sum01;
            pm_10      <= sum10;
            pm_11      <= sum11;
            
            prev_st_00 <= src_00;
            prev_st_10 <= src_10;
            prev_st_01 <= src_01;
            prev_st_11 <= src_11;
            
            slt_node   <= best_node;
            
            // Dịch trễ cờ sang module sau 1 nhịp ck (vì tính toán mất 1 clk)
            o_valid    <= 1'b1;
            o_sof      <= i_sof; 
        end
        else begin
            // Khi không có dữ liệu hợp lệ, tắt cờ o_valid
            // Các dữ liệu khác giữ nguyên
            pm_00      <= pm_00;
            pm_01      <= pm_01;
            pm_10      <= pm_10;
            pm_11      <= pm_11;
            prev_st_00 <= prev_st_00;
            prev_st_01 <= prev_st_01;
            prev_st_10 <= prev_st_10;
            prev_st_11 <= prev_st_11;
            slt_node   <= slt_node;
            o_valid    <= 1'b0;
            o_sof      <= 1'b0;
        end
    end
endmodule