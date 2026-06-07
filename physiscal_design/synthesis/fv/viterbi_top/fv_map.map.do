
//input ports
add mapped point clk clk -type PI PI
add mapped point rst_n rst_n -type PI PI
add mapped point i_start i_start -type PI PI
add mapped point i_data[15] i_data[15] -type PI PI
add mapped point i_data[14] i_data[14] -type PI PI
add mapped point i_data[13] i_data[13] -type PI PI
add mapped point i_data[12] i_data[12] -type PI PI
add mapped point i_data[11] i_data[11] -type PI PI
add mapped point i_data[10] i_data[10] -type PI PI
add mapped point i_data[9] i_data[9] -type PI PI
add mapped point i_data[8] i_data[8] -type PI PI
add mapped point i_data[7] i_data[7] -type PI PI
add mapped point i_data[6] i_data[6] -type PI PI
add mapped point i_data[5] i_data[5] -type PI PI
add mapped point i_data[4] i_data[4] -type PI PI
add mapped point i_data[3] i_data[3] -type PI PI
add mapped point i_data[2] i_data[2] -type PI PI
add mapped point i_data[1] i_data[1] -type PI PI
add mapped point i_data[0] i_data[0] -type PI PI

//output ports
add mapped point o_data[7] o_data[7] -type PO PO
add mapped point o_data[6] o_data[6] -type PO PO
add mapped point o_data[5] o_data[5] -type PO PO
add mapped point o_data[4] o_data[4] -type PO PO
add mapped point o_data[3] o_data[3] -type PO PO
add mapped point o_data[2] o_data[2] -type PO PO
add mapped point o_data[1] o_data[1] -type PO PO
add mapped point o_data[0] o_data[0] -type PO PO
add mapped point o_done o_done -type PO PO

//inout ports




//Sequential Pins
add mapped point u_acs/pm_01[1]/q u_acs_pm_01_reg[1]/Q -type DFF DFF
add mapped point u_acs/slt_node[1]/q u_acs_slt_node_reg[1]/Q -type DFF DFF
add mapped point u_acs/pm_01[3]/q u_acs_pm_01_reg[3]/Q -type DFF DFF
add mapped point u_acs/pm_11[3]/q u_acs_pm_11_reg[3]/Q -type DFF DFF
add mapped point u_acs/pm_01[2]/q u_acs_pm_01_reg[2]/Q -type DFF DFF
add mapped point u_acs/pm_01[0]/q u_acs_pm_01_reg[0]/Q -type DFF DFF
add mapped point u_acs/pm_01[4]/q u_acs_pm_01_reg[4]/Q -type DFF DFF
add mapped point u_acs/pm_11[4]/q u_acs_pm_11_reg[4]/Q -type DFF DFF
add mapped point u_acs/pm_11[1]/q u_acs_pm_11_reg[1]/Q -type DFF DFF
add mapped point u_acs/pm_11[0]/q u_acs_pm_11_reg[0]/Q -type DFF DFF
add mapped point u_acs/pm_11[2]/q u_acs_pm_11_reg[2]/Q -type DFF DFF
add mapped point u_acs/slt_node[0]/q u_acs_slt_node_reg[0]/Q -type DFF DFF
add mapped point u_acs/prev_st_01[0]/q u_acs_prev_st_01_reg[0]/Q -type DFF DFF
add mapped point u_acs/pm_10[1]/q u_acs_pm_10_reg[1]/Q -type DFF DFF
add mapped point u_acs/pm_10[3]/q u_acs_pm_10_reg[3]/Q -type DFF DFF
add mapped point u_acs/prev_st_11[0]/q u_acs_prev_st_11_reg[0]/Q -type DFF DFF
add mapped point u_acs/pm_10[0]/q u_acs_pm_10_reg[0]/Q -type DFF DFF
add mapped point u_acs/pm_00[3]/q u_acs_pm_00_reg[3]/Q -type DFF DFF
add mapped point u_acs/pm_00[4]/q u_acs_pm_00_reg[4]/Q -type DFF DFF
add mapped point u_acs/pm_10[2]/q u_acs_pm_10_reg[2]/Q -type DFF DFF
add mapped point u_acs/pm_00[1]/q u_acs_pm_00_reg[1]/Q -type DFF DFF
add mapped point u_acs/pm_10[4]/q u_acs_pm_10_reg[4]/Q -type DFF DFF
add mapped point u_acs/pm_00[0]/q u_acs_pm_00_reg[0]/Q -type DFF DFF
add mapped point u_acs/pm_00[2]/q u_acs_pm_00_reg[2]/Q -type DFF DFF
add mapped point u_acs/prev_st_10[0]/q u_acs_prev_st_10_reg[0]/Q -type DFF DFF
add mapped point u_acs/prev_st_00[0]/q u_acs_prev_st_00_reg[0]/Q -type DFF DFF
add mapped point u_memory/read_hold/q u_memory_read_hold_reg/Q -type DFF DFF
add mapped point u_memory/read_mode/q u_memory_read_mode_reg/Q -type DFF DFF
add mapped point u_memory/r1_t3[0]/q u_memory_r1_t3_reg[0]/Q -type DFF DFF
add mapped point u_memory/r0_t3[0]/q u_memory_r0_t3_reg[0]/Q -type DFF DFF
add mapped point u_memory/r1_t3[1]/q u_memory_r1_t3_reg[1]/Q -type DFF DFF
add mapped point u_memory/r3_t3[0]/q u_memory_r3_t3_reg[0]/Q -type DFF DFF
add mapped point u_memory/r2_t3[0]/q u_memory_r2_t3_reg[0]/Q -type DFF DFF
add mapped point u_memory/trace[0]/q u_memory_trace_reg[0]/Q -type DFF DFF
add mapped point u_memory/r0_t5[0]/q u_memory_r0_t5_reg[0]/Q -type DFF DFF
add mapped point u_memory/r1_t2[0]/q u_memory_r1_t2_reg[0]/Q -type DFF DFF
add mapped point u_memory/r2_t6[0]/q u_memory_r2_t6_reg[0]/Q -type DFF DFF
add mapped point u_memory/r3_t5[0]/q u_memory_r3_t5_reg[0]/Q -type DFF DFF
add mapped point u_memory/r1_t6[1]/q u_memory_r1_t6_reg[1]/Q -type DFF DFF
add mapped point u_memory/r1_t6[0]/q u_memory_r1_t6_reg[0]/Q -type DFF DFF
add mapped point u_memory/r0_t1[0]/q u_memory_r0_t1_reg[0]/Q -type DFF DFF
add mapped point u_memory/r0_t2[0]/q u_memory_r0_t2_reg[0]/Q -type DFF DFF
add mapped point u_memory/r0_t4[0]/q u_memory_r0_t4_reg[0]/Q -type DFF DFF
add mapped point u_memory/r1_t1[0]/q u_memory_r1_t1_reg[0]/Q -type DFF DFF
add mapped point u_memory/r0_t6[0]/q u_memory_r0_t6_reg[0]/Q -type DFF DFF
add mapped point u_memory/r2_t1[0]/q u_memory_r2_t1_reg[0]/Q -type DFF DFF
add mapped point u_memory/r1_t4[1]/q u_memory_r1_t4_reg[1]/Q -type DFF DFF
add mapped point u_memory/r1_t5[1]/q u_memory_r1_t5_reg[1]/Q -type DFF DFF
add mapped point u_memory/r2_t2[0]/q u_memory_r2_t2_reg[0]/Q -type DFF DFF
add mapped point u_memory/r3_t4[0]/q u_memory_r3_t4_reg[0]/Q -type DFF DFF
add mapped point u_memory/r3_t2[0]/q u_memory_r3_t2_reg[0]/Q -type DFF DFF
add mapped point u_memory/r3_t6[0]/q u_memory_r3_t6_reg[0]/Q -type DFF DFF
add mapped point u_memory/r2_t4[0]/q u_memory_r2_t4_reg[0]/Q -type DFF DFF
add mapped point u_memory/r2_t5[0]/q u_memory_r2_t5_reg[0]/Q -type DFF DFF
add mapped point u_memory/r3_t1[0]/q u_memory_r3_t1_reg[0]/Q -type DFF DFF
add mapped point u_memory/r1_t5[0]/q u_memory_r1_t5_reg[0]/Q -type DFF DFF
add mapped point u_memory/r1_t1[1]/q u_memory_r1_t1_reg[1]/Q -type DFF DFF
add mapped point u_memory/r1_t2[1]/q u_memory_r1_t2_reg[1]/Q -type DFF DFF
add mapped point u_memory/r1_t4[0]/q u_memory_r1_t4_reg[0]/Q -type DFF DFF
add mapped point u_memory/trace[2]/q u_memory_trace_reg[2]/Q -type DFF DFF
add mapped point u_memory/r1_t0[1]/q u_memory_r1_t0_reg[1]/Q -type DFF DFF
add mapped point u_memory/r0_t0[0]/q u_memory_r0_t0_reg[0]/Q -type DFF DFF
add mapped point u_memory/r1_t7[1]/q u_memory_r1_t7_reg[1]/Q -type DFF DFF
add mapped point u_memory/r2_t0[0]/q u_memory_r2_t0_reg[0]/Q -type DFF DFF
add mapped point u_memory/r0_t7[0]/q u_memory_r0_t7_reg[0]/Q -type DFF DFF
add mapped point u_memory/r1_t7[0]/q u_memory_r1_t7_reg[0]/Q -type DFF DFF
add mapped point u_memory/r3_t7[0]/q u_memory_r3_t7_reg[0]/Q -type DFF DFF
add mapped point u_memory/r2_t7[0]/q u_memory_r2_t7_reg[0]/Q -type DFF DFF
add mapped point u_memory/r1_t0[0]/q u_memory_r1_t0_reg[0]/Q -type DFF DFF
add mapped point u_memory/r3_t0[0]/q u_memory_r3_t0_reg[0]/Q -type DFF DFF
add mapped point u_memory/count[1]/q u_memory_count_reg[1]/Q -type DFF DFF
add mapped point u_memory/trace[1]/q u_memory_trace_reg[1]/Q -type DFF DFF
add mapped point u_traceback/current_node[0]/q u_traceback_current_node_reg[0]/Q -type DFF DFF
add mapped point u_memory/count[2]/q u_memory_count_reg[2]/Q -type DFF DFF
add mapped point u_memory/count[0]/q u_memory_count_reg[0]/Q -type DFF DFF
add mapped point u_acs/o_sof/q u_acs_o_sof_reg/Q -type DFF DFF
add mapped point u_acs/o_valid/q u_acs_o_valid_reg/Q -type DFF DFF
add mapped point u_traceback/current_node[1]/q u_traceback_current_node_reg[1]/Q -type DFF DFF
add mapped point u_acs/prev_st_01[1]/q u_acs_prev_st_01_reg[1]/Q -type DFF DFF
add mapped point u_extract/shift_reg[13]/q u_extract_shift_reg_reg[13]/Q -type DFF DFF
add mapped point u_extract/shift_reg[7]/q u_extract_shift_reg_reg[7]/Q -type DFF DFF
add mapped point u_extract/shift_reg[11]/q u_extract_shift_reg_reg[11]/Q -type DFF DFF
add mapped point u_extract/shift_reg[14]/q u_extract_shift_reg_reg[14]/Q -type DFF DFF
add mapped point u_extract/shift_reg[15]/q u_extract_shift_reg_reg[15]/Q -type DFF DFF
add mapped point u_traceback/temp_data[7]/q u_traceback_temp_data_reg[7]/Q -type DFF DFF
add mapped point u_extract/shift_reg[12]/q u_extract_shift_reg_reg[12]/Q -type DFF DFF
add mapped point u_extract/shift_reg[2]/q u_extract_shift_reg_reg[2]/Q -type DFF DFF
add mapped point u_extract/shift_reg[9]/q u_extract_shift_reg_reg[9]/Q -type DFF DFF
add mapped point u_extract/shift_reg[4]/q u_extract_shift_reg_reg[4]/Q -type DFF DFF
add mapped point u_extract/shift_reg[10]/q u_extract_shift_reg_reg[10]/Q -type DFF DFF
add mapped point u_extract/shift_reg[5]/q u_extract_shift_reg_reg[5]/Q -type DFF DFF
add mapped point u_extract/shift_reg[8]/q u_extract_shift_reg_reg[8]/Q -type DFF DFF
add mapped point u_extract/shift_reg[6]/q u_extract_shift_reg_reg[6]/Q -type DFF DFF
add mapped point u_extract/shift_reg[3]/q u_extract_shift_reg_reg[3]/Q -type DFF DFF
add mapped point u_traceback/o_done/q u_traceback_o_done_reg/Q -type DFF DFF
add mapped point u_traceback/count[1]/q u_traceback_count_reg[1]/Q -type DFF DFF
add mapped point u_extract/shift_reg[1]/q u_extract_shift_reg_reg[1]/Q -type DFF DFF
add mapped point u_extract/shift_reg[0]/q u_extract_shift_reg_reg[0]/Q -type DFF DFF
add mapped point u_traceback/count[2]/q u_traceback_count_reg[2]/Q -type DFF DFF
add mapped point u_traceback/count[3]/q u_traceback_count_reg[3]/Q -type DFF DFF
add mapped point u_extract/count[0]/q u_extract_count_reg[0]/Q -type DFF DFF
add mapped point u_extract/count[1]/q u_extract_count_reg[1]/Q -type DFF DFF
add mapped point u_traceback/temp_data[0]/q u_traceback_temp_data_reg[0]/Q -type DFF DFF
add mapped point u_traceback/temp_data[2]/q u_traceback_temp_data_reg[2]/Q -type DFF DFF
add mapped point u_traceback/temp_data[3]/q u_traceback_temp_data_reg[3]/Q -type DFF DFF
add mapped point u_traceback/temp_data[6]/q u_traceback_temp_data_reg[6]/Q -type DFF DFF
add mapped point u_traceback/temp_data[4]/q u_traceback_temp_data_reg[4]/Q -type DFF DFF
add mapped point u_traceback/temp_data[5]/q u_traceback_temp_data_reg[5]/Q -type DFF DFF
add mapped point u_traceback/temp_data[1]/q u_traceback_temp_data_reg[1]/Q -type DFF DFF
add mapped point u_traceback/o_data[7]/q u_traceback_o_data_reg[7]/Q -type DFF DFF
add mapped point u_traceback/o_data[1]/q u_traceback_o_data_reg[1]/Q -type DFF DFF
add mapped point u_traceback/count[0]/q u_traceback_count_reg[0]/Q -type DFF DFF
add mapped point u_traceback/o_data[2]/q u_traceback_o_data_reg[2]/Q -type DFF DFF
add mapped point u_traceback/o_data[6]/q u_traceback_o_data_reg[6]/Q -type DFF DFF
add mapped point u_traceback/o_data[4]/q u_traceback_o_data_reg[4]/Q -type DFF DFF
add mapped point u_traceback/o_data[3]/q u_traceback_o_data_reg[3]/Q -type DFF DFF
add mapped point u_traceback/o_data[0]/q u_traceback_o_data_reg[0]/Q -type DFF DFF
add mapped point u_traceback/o_data[5]/q u_traceback_o_data_reg[5]/Q -type DFF DFF
add mapped point u_extract/o_valid/q u_extract_o_valid_reg/Q -type DFF DFF
add mapped point u_extract/count[2]/q u_extract_count_reg[2]/Q -type DFF DFF
add mapped point u_traceback/tracing/q u_traceback_tracing_reg/Q -type DFF DFF
add mapped point u_memory/o_memory_done/q u_memory_o_memory_done_reg/Q -type DFF DFF
add mapped point u_acs/o_valid_d1/q u_acs_o_valid_d1_reg/Q -type DFF DFF
add mapped point u_extract/o_sof/q u_extract_o_sof_reg/Q -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
