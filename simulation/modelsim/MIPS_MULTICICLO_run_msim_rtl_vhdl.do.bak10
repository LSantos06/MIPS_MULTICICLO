transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/EXTEND_SIGNAL/EXTEND_SHAMT.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/MUX/Mux2x1/MIPS_Mux2x1_8bits_IouD.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/SHIFT_2LEFT/32bits/SHIFT_2LEFT_32.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/SHIFT_2LEFT/26bits/SHIFT_2LEFT_26.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/REG32/reg32.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/PC_BRANCH/PC_enable_combinacional.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/MUX/Mux4x1/MIPS_Mux4x1_32bits_ORIGBALU.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/MUX/Mux3x1/Mux3x1_32bits_OrigPC.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/MUX/Mux2x1/MIPS_Mux2x1_32bits_OrigAALU.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/MUX/Mux2x1/MIPS_Mux2x1_32bits_MemparaReg.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/MUX/Mux2x1/MIPS_Mux2x1_5bits_RegEscrita.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/MEM/RAM_MIPS.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/EXTEND_SIGNAL/EXTEND_SIGNAL.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/CONTROL/somador.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/CONTROL/romDespacho2.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/CONTROL/romDespacho1.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/CONTROL/mux4.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/CONTROL/microPC.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/CONTROL/microCodigo.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/CONTROL/enderecamento.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/CONTROL/cntrMIPS.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/BREG/bregMIPS.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/ALU_CONTROL/ALUcontrol.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/ALU/ULA_OAC.vhd}
vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/MIPS_MULTICICLO.vhd}

vcom -93 -work work {C:/altera/13.0/projects/multiciclo32/MIPS_MULTICILO_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii -L rtl_work -L work -voptargs="+acc"  MIPS_MULTICICLO_tb

add wave *
view structure
view signals
run -all
