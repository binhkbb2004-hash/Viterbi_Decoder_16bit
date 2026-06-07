# 1. Clock
create_clock -name clk -period 4.5 [get_ports clk]

# 2. Clock Uncertainty
set_clock_uncertainty 0.3 [get_clocks clk]

# 3. Input Delay
set_input_delay -clock clk 1.0 [remove_from_collection [all_inputs] [get_ports clk]]

# 4. Input Transition
set_input_transition 0.1 [remove_from_collection [all_inputs] [get_ports clk]]

# 5. Output Delay
set_output_delay -clock clk 1.0 [all_outputs]

# 6. Load
set_load 0.1 [all_outputs]
