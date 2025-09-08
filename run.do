

vlib work
vlog -sv 10_Inline_Soft_constraints.sv
vsim -voptargs=+acc work.top_inline_soft
run -all