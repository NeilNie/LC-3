transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/Register\ File {C:/Users/USER1/Digital Logic/LC-3/Register File/RegisterFile.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/Register\ File {C:/Users/USER1/Digital Logic/LC-3/Register File/Register.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/Register\ File {C:/Users/USER1/Digital Logic/LC-3/Register File/mux_8_1_bit_16.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/Register\ File {C:/Users/USER1/Digital Logic/LC-3/Register File/decoder_3_8.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/Register\ File {C:/Users/USER1/Digital Logic/LC-3/Register File/d_flip_flop.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/PC {C:/Users/USER1/Digital Logic/LC-3/PC/PC.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/PC {C:/Users/USER1/Digital Logic/LC-3/PC/d_negedge_flip_flop.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/PC {C:/Users/USER1/Digital Logic/LC-3/PC/bit_16_register.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/NZP {C:/Users/USER1/Digital Logic/LC-3/NZP/NZP_register.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/NZP {C:/Users/USER1/Digital Logic/LC-3/NZP/NZP.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/Memory {C:/Users/USER1/Digital Logic/LC-3/Memory/Memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/Memory {C:/Users/USER1/Digital Logic/LC-3/Memory/mem.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/MARMux {C:/Users/USER1/Digital Logic/LC-3/MARMux/MARMux.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/LC3Control {C:/Users/USER1/Digital Logic/LC-3/LC3Control/LC3Control.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/IR {C:/Users/USER1/Digital Logic/LC-3/IR/IR.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/EAB {C:/Users/USER1/Digital Logic/LC-3/EAB/EAB.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3/ALU {C:/Users/USER1/Digital Logic/LC-3/ALU/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3 {C:/Users/USER1/Digital Logic/LC-3/LC3.v}
vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3 {C:/Users/USER1/Digital Logic/LC-3/bus_tri_state_buffer.v}

vlog -vlog01compat -work work +incdir+C:/Users/USER1/Digital\ Logic/LC-3 {C:/Users/USER1/Digital Logic/LC-3/general_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  general_tb

add wave *
view structure
view signals
run -all
