#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Thu May 14 16:02:08 2026                
#                                                     
#######################################################

#@(#)CDS: Innovus v23.37-s090_1 (64bit) 02/09/2026 16:09 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 23.37-s090_1 NR260126-2134/23_17-UB (database version 18.20.682_1) {superthreading v2.20}
#@(#)CDS: AAE 23.17-s025 (64bit) 02/09/2026 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 23.17-s038_1 () Feb  4 2026 22:23:13 ( )
#@(#)CDS: SYNTECH 23.17-s006_1 () Jan 20 2026 01:15:57 ( )
#@(#)CDS: CPE v23.17-s060
#@(#)CDS: IQuantus/TQuantus 23.1.1-s583 (64bit) Mon Nov 24 21:09:39 PST 2025 (Linux 3.10.0-693.el7.x86_64)

set_db init_power_nets VDD
set_db init_ground_nets VSS
read_mmmc viterbi_top_mmmc.view
#@ Begin verbose source viterbi_top_mmmc.view (pre)
create_library_set -name max_timing \
    -timing ../lib/sky130_ss_1.62_125_nldm.lib
create_library_set -name min_timing \
    -timing ../lib/sky130_ff_1.98_0_nldm.lib
create_timing_condition -name default_mapping_tc_1 \
    -library_sets max_timing
create_timing_condition -name default_mapping_tc_2 \
    -library_sets min_timing
create_rc_corner -name rccorners \
    -pre_route_res 1 \
    -pre_route_cap 1 \
    -post_route_res 1 \
    -post_route_cap 1 \
    -post_route_cross_cap 1 \
    -pre_route_clock_res 0 \
    -pre_route_clock_cap 0 \
    -qrc_tech ../qrc/qrcTechFile_RCgen
create_delay_corner -name max_delay \
    -timing_condition {default_mapping_tc_1} \
    -rc_corner rccorners
create_delay_corner -name min_delay \
    -timing_condition {default_mapping_tc_2} \
    -rc_corner rccorners
create_constraint_mode -name sdc_cons \
    -sdc_files viterbi_sdc.sdc
create_analysis_view -name wc -constraint_mode sdc_cons -delay_corner max_delay
create_analysis_view -name bc -constraint_mode sdc_cons -delay_corner min_delay
set_analysis_view -setup wc -hold bc
#@ End verbose source viterbi_top_mmmc.view
check_pin_assignment 
gui_select -rect {-27.13500 91.21900 -52.92700 90.62800}
gui_select -rect {-39.93200 87.87200 -52.53300 88.06900}
set_db add_rings_target default
set_db add_rings_extend_over_row 0
set_db add_rings_ignore_rows 0
set_db add_rings_avoid_short 0
set_db add_rings_skip_shared_inner_ring none
set_db add_rings_stacked_via_top_layer met5
set_db add_rings_stacked_via_bottom_layer met1
set_db add_rings_via_using_exact_crossover_size 1
set_db add_rings_orthogonal_only true
set_db add_rings_skip_via_on_pin {  standardcell }
set_db add_rings_skip_via_on_wire_shape {  noshape }
add_rings -nets {VDD VSS} -type core_rings -follow core -layer {top met5 bottom met5 left met4 right met4} -width {top 3 bottom 3 left 3 right 3} -spacing {top 1.7 bottom 1.7 left 1.7 right 1.7} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 1 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid none
set_db add_rings_target default
set_db add_rings_extend_over_row 0
set_db add_rings_ignore_rows 0
set_db add_rings_avoid_short 0
set_db add_rings_skip_shared_inner_ring none
set_db add_rings_stacked_via_top_layer met5
set_db add_rings_stacked_via_bottom_layer met1
set_db add_rings_via_using_exact_crossover_size 1
set_db add_rings_orthogonal_only true
set_db add_rings_skip_via_on_pin {  standardcell }
set_db add_rings_skip_via_on_wire_shape {  noshape }
add_rings -nets {VDD VSS} -type core_rings -follow core -layer {top met5 bottom met5 left met4 right met4} -width {top 3 bottom 3 left 3 right 3} -spacing {top 1.7 bottom 1.7 left 1.7 right 1.7} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 1 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid none
gui_select -rect {91.31000 78.05600 110.23000 47.18800}
gui_select -rect {98.99600 62.12000 98.99800 62.11700}
gui_select -point {7.31900 64.04900}
gui_select -point {-37.76700 55.19000}
gui_select -point {162.65900 71.72800}
set_db add_stripes_ignore_block_check false
set_db add_stripes_break_at none
set_db add_stripes_route_over_rows_only false
set_db add_stripes_rows_without_stripes_only false
set_db add_stripes_extend_to_closest_target none
set_db add_stripes_stop_at_last_wire_for_area false
set_db add_stripes_partial_set_through_domain false
set_db add_stripes_ignore_non_default_domains false
set_db add_stripes_trim_antenna_back_to_shape none
set_db add_stripes_spacing_type edge_to_edge
set_db add_stripes_spacing_from_block 0
set_db add_stripes_stripe_min_length stripe_width
set_db add_stripes_stacked_via_top_layer met5
set_db add_stripes_stacked_via_bottom_layer met1
set_db add_stripes_via_using_exact_crossover_size false
set_db add_stripes_split_vias false
set_db add_stripes_orthogonal_only true
set_db add_stripes_allow_jog { padcore_ring  block_ring }
set_db add_stripes_skip_via_on_pin {  standardcell }
set_db add_stripes_skip_via_on_wire_shape {  noshape   }
add_stripes -nets {VDD VSS} -layer met4 -direction vertical -width 1.8 -spacing 1.8 -set_to_set_distance 33 -start_from left -start_offset 33 -switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit met5 -pad_core_ring_bottom_layer_limit met1 -block_ring_top_layer_limit met5 -block_ring_bottom_layer_limit met1 -use_wire_group 0 -snap_wire_center_to_grid none
connect_global_net VDD -type pg_pin -pin_base_name VDD -inst_base_name *
connect_global_net VSS -type pg_pin -pin_base_name VSS -inst_base_name *
set_db route_special_via_connect_to_shape { stripe }
route_special -connect core_pin -layer_change_range { met1(1) met5(5) } -block_pin_target nearest_target -core_pin_target first_after_row_end -allow_jogging 1 -crossover_via_layer_range { met1(1) met5(5) } -nets { VDD VSS } -allow_layer_change 1 -target_via_layer_range { met1(1) met5(5) }
write_db floorplanning
place_opt_design
set_layer_preference node_net -is_visible 0
set_layer_preference node_net -is_visible 1
write_db placeOpt
set_layer_preference node_net -is_visible 0
set_layer_preference node_net -is_visible 1
set_db cts_buffer_cells {CLKBUFX4 CLKBUFX8}
set_db cts_inverter_cells {CLKINVX4 CLKINVX8}
create_clock_tree_spec
clock_opt_design
set_db route_detail_fix_antenna 1
set_db route_antenna_diode_insertion 0
set_db route_with_timing_driven 1
set_db route_with_eco 0
set_db route_with_litho_driven 0
set_db route_detail_post_route_litho_repair 0
set_db route_with_si_driven 1
set_db route_detail_auto_stop 0
set_db route_selected_net_only 0
set_db route_detail_end_iteration 1
set_db route_with_timing_driven true
set_db route_with_si_driven true
route_design -global_detail
reset_parasitics
extract_rc
write_parasitics -spef_file viterbi_top.spef -rc_corner rccorners
set_db timing_analysis_type ocv
time_design -post_route
time_design -post_route -hold
optDesign -postRoute -hold
opt_design -post_route -hold
time_design -post_route -hold
set_layer_preference node_net -is_visible 0
set_layer_preference node_net -is_visible 1
check_drc
set_db route_detail_end_iteration 19
route_design
check_drc
add_fillers -base_cells FILL_DECAP8 FILL_DECAP16 FILL8 FILL64 FILL4 FILL32 FILL2 FILL16 FILL1 -prefix FILLER
check_drc
check_connectivity
check_antenna 
report_timing
set_db [get_db clocks -if {.name == "clk"}] .period 5.0
get_ports clk
create_clock -name clk -period 5.0 [get_ports clk]
extract_rc
time_design -post_route
delete_filler
opt_design -post_route
time_design -post_route
opt_design -post_route
set_db [get_db clocks clk] .period 5.0
time_design -post_route
set_interactive_constraint_modes {sdc_cons}
delete_clock clk
delete_obj [get_db clocks clk]
set_interactive_constraint_modes {sdc_cons}
get_ports clk
create_clock -name clk -period 5.0 [get_ports clk]
get_db [get_db clocks clk] .period
set_interactive_constraint_modes {}
update_timing -full
time_design -post_route
time_design -post_route -hold
check drc
check_drc 
check_connectivity 
check_antenna 
add_fillers -base_cells FILL_DECAP8 FILL_DECAP16 FILL8 FILL64 FILL4 FILL32 FILL2 FILL16 FILL1 -prefix FILLER
check_drc 
check_connectivity 
check_antenna 
report_timing
time_design -post_route -hold
report_timing
report_area 
report_power
exec mkdir -p reports
report_timing -max_paths 20 -pba_mode exhaustive > reports/report_timing.rpt
report_power > reports/report_power.rpt
report_area > reports/report_area.rpt
report_timing > reports/report_timing.rpt
check_drc -out_file reports/report_drc.rpt
check_connectivity -out_file reports/report_connectivity.rpt
write_stream -format gds reports/viterbi_final.gds
write_stream -format stream reports/viterbi_final.gds
write_db postRouteOpt
read_db postRouteOpt
