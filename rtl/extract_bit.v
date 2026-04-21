module extract_bit (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        i_start,
    input  wire [15:0] i_data,
    output wire [1:0]  o_rx,
    output reg         o_valid,  // Báo hiệu o_rx đang chứa dữ liệu chuẩn
    output reg         o_sof     // Báo hiệu cặp bit đầu tiên của chuỗi
);

    reg [15:0] shift_reg;
    reg [3:0]  count; // Tự đếm số lần dịch

    assign o_rx = o_valid ? shift_reg[15:14] : 2'b00; // Dùng 1 thanh ghi dịch để xuất các cặp bit

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg <= 16'd0;
            count     <= 4'd0;
            o_valid   <= 1'b0;
            o_sof     <= 1'b0;
        end 
        else if (i_start) begin
            // Nhận chuỗi mới
            shift_reg <= i_data;
            count     <= 4'd7;   // Còn 7 lần dịch nữa
            o_valid   <= 1'b1;
            o_sof     <= 1'b1;   // Cờ báo cặp bit đầu lên 1 nhịp
        end 
        else if (count > 0) begin
            // Đang trong quá trình dịch
            shift_reg <= {shift_reg[13:0], 2'b00};
            count     <= count - 1;
            o_valid   <= 1'b1;
            o_sof     <= 1'b0;   // Tắt vì không phải cặp bit đầu
        end 
        else begin
            // Trạng thái nghỉ, tắt 2 cờ
            o_valid   <= 1'b0;
            o_sof     <= 1'b0;
        end
    end
endmodule