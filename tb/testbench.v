`timescale 1ns/1ps

module testbench ();
    reg clk;
    reg rst_n;
    reg i_start;
    reg [15:0] i_data;
    wire [7:0] o_data;
    wire o_done;

    // DUT
    viterbi_top DUT (
        .clk    (   clk     ),
        .rst_n  (   rst_n   ),
        .i_start(   i_start ),
        .i_data (   i_data  ),
        .o_data (   o_data  ),
        .o_done (   o_done  )
    );

    // Clock
    initial begin
        clk = 0;
        forever #5 clk = ~ clk;
    end

    // Biến phụ
    integer fd1, fd2;
    integer status1, status2;
    integer test_num = 0; // testcase
    integer pass_cnt = 0; // số case pass
    integer fail_cnt = 0; // số case fail
    reg [15:0] exp_in;
    reg [7:0] exp_out;

    // Test
    initial begin
        // Khởi tạo 
        rst_n = 0;
        i_start = 0;
        i_data = 16'b0;

        // Nhả reset
        #20;
        rst_n = 1;

        // Đọc 2 file input, output mẫu (ghi cả đường dẫn cho lành)
        fd1 = $fopen("D:/VLSI_viterbi/tb/input.txt", "r");
        fd2 = $fopen("D:/VLSI_viterbi/tb/output.txt", "r");

        // K mở được thì $stop để tránh chạy vô hạn (lần simulate đầu đã mắc phải <('))
        if (fd1 == 0 || fd2 == 0) begin
            $display(" ERROR | Khong mo duoc 2 file txt (Xem lai duong dan nhe)");
            $stop;
        end

        $display("****************************************************");
        $display("|||| (^.^) |||| < START SIMULATION > |||| (^.^) ||||");
        $display("****************************************************");
        while((!$feof(fd1)) && (!$feof(fd2))) begin
            status1 = $fscanf(fd1, "%b\n", exp_in);
            status2 = $fscanf(fd2, "%b\n", exp_out);
            if((status1 == 1) && (status2 == 1)) begin
                test_num = test_num + 1;
                $display("----------------------------------------------------");
                $display("| CASE: %d |", test_num);
                @(negedge clk);
                i_start = 1;
                i_data = exp_in;

                // tắt i_start
                @(negedge clk);
                i_start = 0;

                // chờ o_done lên 1
                wait(o_done == 1);
                #3;
                
                // đối chiếu với output mẫu
                if(o_data === exp_out) begin
                    $display("PASSED | Input: %b | Exp: %b | Act: %b", exp_in, exp_out, o_data);
                    pass_cnt = pass_cnt + 1;
                end else begin
                    $display("--> FAILED | Input: %b | Exp: %b | Act: %b", exp_in, exp_out, o_data);
                    fail_cnt = fail_cnt + 1;
                end
            end else begin
                $display("ERROR | Khong doc duoc 2 file txt");
                end
        end
        $fclose(fd1);
        $fclose(fd2);
        $display("****************************************************");
        $display("|||| (^.^) ||||  < END SIMULATION >  |||| (^.^) ||||");
        $display("****************************************************");       
        #10;
        $display("-------------------- TONG KET ----------------------");
        $display(" |Tong so testcase: %0d", test_num);
        $display(" |So Case PASS    : %0d", pass_cnt);
        $display(" |So Case FAIL    : %0d", fail_cnt);
        #10;
        $stop;
    end
endmodule