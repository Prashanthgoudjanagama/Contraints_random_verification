

vlib work
vlog -sv 01_Basic_keywords_and_ranges.sv
vsim -voptargs=+acc work.top_basic_constraints
run -all