`timescale 1ns / 1ps

module tb_extract_bit();

    // Khai báo tín hiệu
    reg         clk;
    reg         rst_n;
    reg         i_start;
    reg  [15:0] i_data;
    
    wire [1:0]  o_rx;
    wire        o_valid;
    wire        o_sof;

    // Khởi tạo module
    extract_bit dut (
        .clk(clk),
        .rst_n(rst_n),
        .i_start(i_start),
        .i_data(i_data),
        .o_rx(o_rx),
        .o_valid(o_valid),
        .o_sof(o_sof)
    );

    // Tạo Clock
    initial begin
        clk = 0;
        forever #10 clk = ~clk; 
    end

    // Kịch bản Test
    initial begin
        // Khởi tạo trạng thái ban đầu
        rst_n   = 0;
        i_start = 0;
        i_data  = 16'd0;

        // Chờ 2.5 chu kỳ và nhả reset
        #25;
        rst_n = 1;

        // Đợi đến sườn âm của clock để nạp input 
        @(negedge clk);
        i_data  = 16'b11_10_01_00_10_11_01_11; 
        i_start = 1;
        
        // Đợi 1 chu kỳ rồi tắt i_start
        @(negedge clk);
        i_start = 0;
        // Chờ 10 chu kỳ để quan sát
        repeat (10) @(posedge clk);

        // Test 1 chuỗi bit đầu vào khác
        @(negedge clk);
        i_data  = 16'b00_11_00_11_00_11_00_11;
        i_start = 1;
        @(negedge clk);
        i_start = 0;
        repeat (10) @(posedge clk);

        // Kết thúc mô phỏng
        $stop;
    end
endmodule