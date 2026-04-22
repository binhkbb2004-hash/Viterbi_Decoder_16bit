module traceback (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       i_memory_done, // Hand-shake từ memory
    input  wire [1:0] slt_node, // Điểm bắt đầu được gửi từ ACS
    input  wire [1:0] bck_prev_st_00,
    input  wire [1:0] bck_prev_st_01, 
    input  wire [1:0] bck_prev_st_10, 
    input  wire [1:0] bck_prev_st_11, 
    output reg  [7:0] o_data, // Dữ liệu đã được giải mã hoàn thành
    output reg        o_done // Cờ báo hoàn tất giải mã
);
    // Khai báo các biến nội bộ
    reg [3:0] count; // Đếm 8 chu kỳ
    reg [1:0] current_node; // Trạng thái hiện tại đang xét
    reg [7:0] temp_data; // Thanh ghi dịch chứa chuỗi kết quả tạm
    reg       tracing; // Cờ báo hiệu mạch đang chạy

    // Bộ MUX chọn tráng thái liền trước 
    reg [1:0] target_node; 
    reg [1:0] next_node;
    always @(i_memory_done, slt_node, current_node, bck_prev_st_00, bck_prev_st_01, bck_prev_st_10, bck_prev_st_11) begin 
        // Chu kì đầu tiên chọn node theo slt_node được gửi từ ACS        
        if (i_memory_done == 1'b1) begin
            target_node = slt_node;
        end 
        else begin
            target_node = current_node;
        end

        // Chọn node tiếp theo 
        case (target_node)
            2'b00:   next_node = bck_prev_st_00;
            2'b01:   next_node = bck_prev_st_01;
            2'b10:   next_node = bck_prev_st_10;
            2'b11:   next_node = bck_prev_st_11;
            default: next_node = 2'b00;
        endcase
    end

    // Logic truy vết
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count        <= 4'd0;
            current_node <= 2'b00;
            temp_data    <= 8'd0;
            tracing      <= 1'b0;
            o_data       <= 8'd0;
            o_done       <= 1'b0;
        end 
        else begin
            // Nhận tín hiệu hand-shake từ memory
            if (i_memory_done) begin
                tracing   <= 1'b1;
                count     <= 4'd1; // Đã xử lý xong nhịp đầu tiên
                
                // B1: Lấy MSB của node đang đứng làm bit giải mã và dịch nó vào thanh ghi 
                // (theo quy tắc của bộ mã hóa có giải thích trong spec <('))
                temp_data    <= {target_node[1], temp_data[7:1]};
                
                // B2: Lùi, ghi dấu chân tiếp theo vào current_node
                current_node <= next_node; 
                o_done       <= 1'b0;
            end 
            
            // Quá trình truy vết các chu kỳ tiếp theo
            else if (tracing) begin
                if (count < 4'd8) begin
                    // Lấy MSB của current_node làm bit giải mã và dịch vào
                    temp_data    <= {target_node[1], temp_data[7:1]};
                    
                    // Lùi bước
                    current_node <= next_node;
                    
                    // Tăng biến đếm
                    count        <= count + 1'b1;
                end 
            // Hoàn thành truy vết 
                else begin
                    tracing    <= 1'b0; // Dừng truy vết
                    o_data     <= temp_data; // Gửi dữ liệu ra output
                    o_done     <= 1'b1; // Bật cờ done
                    count      <= 4'd0; // Reset biến đếm
                end
            end 
            
            // Tắt cờ o_done sau 1 nhịp clk
            else if (o_done) begin
                o_done <= 1'b0;
            end
        end
    end
endmodule