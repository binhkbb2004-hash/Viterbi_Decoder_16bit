module branch_metric (
    input  wire       rst_n,
    
    // Tín hiệu Hand-shake nhận từ khối extract_bit phía trước
    input  wire       i_valid, 
    input  wire       i_sof,   
    input  wire [1:0] i_rx,
    
    // Khoảng cách Hamming
    output wire [1:0] hd_00, 
    output wire [1:0] hd_01, 
    output wire [1:0] hd_10, 
    output wire [1:0] hd_11,
    
    // Chuyển tiếp tín hiệu Hand-shake cho khối ACS phía sau
    output wire       o_valid, 
    output wire       o_sof    
);
    // Tính khoảng cách Hamming dùng XOR từng bit và cộng tổng lại
    wire [1:0] dist_00 = (i_rx[1] ^ 1'b0) + (i_rx[0] ^ 1'b0);
    wire [1:0] dist_01 = (i_rx[1] ^ 1'b0) + (i_rx[0] ^ 1'b1);
    wire [1:0] dist_10 = (i_rx[1] ^ 1'b1) + (i_rx[0] ^ 1'b0);
    wire [1:0] dist_11 = (i_rx[1] ^ 1'b1) + (i_rx[0] ^ 1'b1);

    // Cho phép xuất output khi hệ thống không bị reset và dữ liệu hợp lệ
    wire active = rst_n & i_valid;

    assign hd_00 = active ? dist_00 : 2'b00;
    assign hd_01 = active ? dist_01 : 2'b00;
    assign hd_10 = active ? dist_10 : 2'b00;
    assign hd_11 = active ? dist_11 : 2'b00;

    // Tín hiệu Hand-shake gửi sang khối ACS
    assign o_valid = active;
    assign o_sof   = active ? i_sof : 1'b0;
endmodule