# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./mux8_1.sv"
vlog "./mux2_1.sv"
vlog "./mux4.sv"
vlog "./Half_Adder.sv"
vlog "./Full_Adder.sv"
vlog "./alu_1bit.sv"
vlog "./flagCheck.sv"
vlog "./alu.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work alustim

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do alu_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
