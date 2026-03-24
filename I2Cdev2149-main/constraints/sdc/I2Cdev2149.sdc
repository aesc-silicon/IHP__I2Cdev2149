current_design SG13CMOS5LTop

create_clock [get_pins sg13cmos5l_IOPad_io_clock/p2c] -name clk_core -period 20.0 -waveform {0 10.0}
set_clock_uncertainty 0.05 [get_clocks clk_core]
set_clock_transition 0.25 [get_clocks clk_core]
set input_delay_value_clk_core 4.00
set output_delay_value_clk_core 4.00
set clk_core_inout_16mA_ports [get_ports {
	io_gpio_0_PAD
	io_gpio_1_PAD
	io_gpio_2_PAD
	io_gpio_3_PAD
	io_gpio_4_PAD
	io_gpio_5_PAD
	io_gpio_6_PAD
	io_gpio_7_PAD
}]
set_driving_cell -lib_cell sg13cmos5l_IOPadInOut16mA -pin pad $clk_core_inout_16mA_ports
set_input_delay -max $input_delay_value_clk_core -clock clk_core $clk_core_inout_16mA_ports
set_input_delay -min 0.5 -clock clk_core $clk_core_inout_16mA_ports
set_load -pin_load 4 $clk_core_inout_16mA_ports
set_output_delay -max $output_delay_value_clk_core -clock clk_core $clk_core_inout_16mA_ports
set_output_delay -min 0.5 -clock clk_core $clk_core_inout_16mA_ports
set clk_core_inout_4mA_ports [get_ports {
	io_i2c_scl_PAD
	io_i2c_sda_PAD
}]
set_driving_cell -lib_cell sg13cmos5l_IOPadInOut4mA -pin pad $clk_core_inout_4mA_ports
set_input_delay -max $input_delay_value_clk_core -clock clk_core $clk_core_inout_4mA_ports
set_input_delay -min 0.5 -clock clk_core $clk_core_inout_4mA_ports
set_load -pin_load 4 $clk_core_inout_4mA_ports
set_output_delay -max $output_delay_value_clk_core -clock clk_core $clk_core_inout_4mA_ports
set_output_delay -min 0.5 -clock clk_core $clk_core_inout_4mA_ports
set clk_core_input_ports [get_ports {
	io_reset_PAD
	io_address_0_PAD
	io_address_1_PAD
	io_address_2_PAD
}]
set_driving_cell -lib_cell sg13cmos5l_IOPadIn -pin pad $clk_core_input_ports
set_input_delay -max $input_delay_value_clk_core -clock clk_core $clk_core_input_ports
set_input_delay -min 0.5 -clock clk_core $clk_core_input_ports
set clk_core_output_4mA_ports [get_ports {
	io_i2c_interrupt_PAD
}]
set_load -pin_load 4 $clk_core_output_4mA_ports
set_output_delay -max $output_delay_value_clk_core -clock clk_core $clk_core_output_4mA_ports
set_output_delay -min 0.5 -clock clk_core $clk_core_output_4mA_ports

set clock_ports [get_ports {
	io_clock_PAD
}]
set_driving_cell -lib_cell sg13cmos5l_IOPadIn -pin pad $clock_ports
set_timing_derate -early 0.95
set_timing_derate -late 1.05
