module memory (
    input  wire        clk,
    input  wire        rst_n,
    
    // Tín hiệu Hand-shake từ module ACS
    input  wire        i_valid,
    input  wire        i_sof,
    
    // Input vào từ module ACS
    input  wire [1:0]  prev_st_00,
    input  wire [1:0]  prev_st_01,
    input  wire [1:0]  prev_st_10,
    input  wire [1:0]  prev_st_11,
    
    // Output cấp cho module Traceback
    output wire [1:0]  bck_prev_st_00,
    output wire [1:0]  bck_prev_st_01,
    output wire [1:0]  bck_prev_st_10,
    output wire [1:0]  bck_prev_st_11,
    
    // Cờ báo hiệu cho Traceback biết Memory đã chuyển sang pha Đọc
    output reg         o_memory_done
);
    // Sử dụng 1 mảng 2 chiều 4x8, mỗi ô nhớ 2 bit làm mảng nhớ
    // [0:3]: 4 hàng tương ứng 4 trạng thái
    // [0:7]: 8 cột tương ứng 8 thời điểm
    reg [1:0] trellis_diagr [0:3][0:7];

    // Các biến đếm nội bộ
    reg [2:0] count; // Biến đếm ghi
    reg [2:0] trace; // Biến đếm đọc
    reg       read_mode; // Cờ phân biệt Ghi/Đọc

    integer i, j;

    // LOGIC TUẦN TỰ: ĐIỀU KHIỂN GHI / ĐỌC
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count         <= 3'd0;
            trace         <= 3'd7;
            read_mode     <= 1'b0;
            o_memory_done <= 1'b0;
            
            // Xóa mảng nhớ về full 0 (theo yêu cầu của TA thì k dùng for)
            trellis_diagr[0][0] <= 2'b00; trellis_diagr[0][1] <= 2'b00; trellis_diagr[0][2] <= 2'b00; trellis_diagr[0][3] <= 2'b00;
            trellis_diagr[0][4] <= 2'b00; trellis_diagr[0][5] <= 2'b00; trellis_diagr[0][6] <= 2'b00; trellis_diagr[0][7] <= 2'b00;
        
            trellis_diagr[1][0] <= 2'b00; trellis_diagr[1][1] <= 2'b00; trellis_diagr[1][2] <= 2'b00; trellis_diagr[1][3] <= 2'b00;
            trellis_diagr[1][4] <= 2'b00; trellis_diagr[1][5] <= 2'b00; trellis_diagr[1][6] <= 2'b00; trellis_diagr[1][7] <= 2'b00;
        
            trellis_diagr[2][0] <= 2'b00; trellis_diagr[2][1] <= 2'b00; trellis_diagr[2][2] <= 2'b00; trellis_diagr[2][3] <= 2'b00;
            trellis_diagr[2][4] <= 2'b00; trellis_diagr[2][5] <= 2'b00; trellis_diagr[2][6] <= 2'b00; trellis_diagr[2][7] <= 2'b00;
        
            trellis_diagr[3][0] <= 2'b00; trellis_diagr[3][1] <= 2'b00; trellis_diagr[3][2] <= 2'b00; trellis_diagr[3][3] <= 2'b00;
            trellis_diagr[3][4] <= 2'b00; trellis_diagr[3][5] <= 2'b00; trellis_diagr[3][6] <= 2'b00; trellis_diagr[3][7] <= 2'b00;
        end 
        else begin
            // GIAI ĐOẠN GHI
            if (i_valid && !read_mode) begin
                if (i_sof) begin
                    // Nếu có cờ sof -> Ghi dữ liệu vào cột 0 và reset count
                    trellis_diagr[0][0] <= prev_st_00;
                    trellis_diagr[1][0] <= prev_st_01;
                    trellis_diagr[2][0] <= prev_st_10;
                    trellis_diagr[3][0] <= prev_st_11;
                    count <= 3'd1; 
                end 
                else begin
                    // Các cột tiếp theo -> Ghi vào cột ở địa chỉ count
                    trellis_diagr[0][count] <= prev_st_00;
                    trellis_diagr[1][count] <= prev_st_01;
                    trellis_diagr[2][count] <= prev_st_10;
                    trellis_diagr[3][count] <= prev_st_11;
                    
                    // Nếu vừa ghi xong cột cuối cùng (cột 7)
                    if (count == 3'd7) begin
                        read_mode     <= 1'b1;  // Chuyển sang Giai đoạn Đọc
                        trace         <= 3'd7;  // Khởi tạo con trỏ trace ở cột 7
                        o_memory_done <= 1'b1;  // Bật cờ hand-shake tới khối Traceback
                        count         <= 4'd0;  // Reset count chuẩn bị cho chuỗi mới
                    end 
                    else begin
                        count <= count + 1'b1;  // Tăng biến đếm ghi
                    end
                end
            end
        
            // GIAI ĐOẠN ĐỌC

            else if (read_mode) begin
                // Tắt cờ done
                o_memory_done <= 1'b0; 
                
                // Giảm dần biến trace theo từng chu kỳ
                if (trace > 3'd0) begin
                    trace <= trace - 1'b1; 
                end 
                else begin
                    // Khi trace về 0, kết thúc chế độ đọc
                    read_mode <= 1'b0; 
                end
            end
        end
    end

    // Xuất đồng thời 4 trạng thái tại cột địa chỉ trace
    assign bck_prev_st_00 = read_mode ? trellis_diagr[0][trace] : 2'b00;
    assign bck_prev_st_01 = read_mode ? trellis_diagr[1][trace] : 2'b00;
    assign bck_prev_st_10 = read_mode ? trellis_diagr[2][trace] : 2'b00;
    assign bck_prev_st_11 = read_mode ? trellis_diagr[3][trace] : 2'b00;
endmodule