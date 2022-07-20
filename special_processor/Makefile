iverilog ?= iverilog
vvp ?= vvp

# There is a bug parsing command line arguments with the default
# brew install of GTKWave; this helps work around that, for more
# details: https://ughe.github.io/2018/11/06/gtkwave-osx
gtkwave ?= /Applications/gtkwave.app/Contents/Resources/bin/gtkwave

.PHONY:	default
default:
	@echo Just a shortcut for getting flags and commands for tools right.
	@echo Look inside the makefile for valid targets for tools.

inst_mem.hex:	basic.asm generate_inst_memory.py
	./generate_inst_memory.py

data_mem.hex:	generate_data_memory.py
	./generate_data_memory.py

.PHONY:	icarus
icarus:	inst_mem.hex data_mem.hex
	rm -f icarus/basic_proc.vvp
	rm -f icarus/alu.vvp
	rm -f icarus/prog_cntr.vvp
	@#
	$(iverilog) -Winfloop -o icarus/basic_proc.vvp -tvvp -g2012 Definitions.sv ALU.sv Ctrl.sv DataMem.sv InstROM.sv LUT.sv ProgCtr.sv RegFile.sv TopLevel.sv TopLevel_tb.sv
	$(iverilog) -Winfloop -o icarus/alu.vvp -tvvp -g2012 Definitions.sv ALU.sv ALU_tb.sv
	$(iverilog) -Winfloop -o icarus/prog_cntr.vvp -tvvp -g2012 ProgCtr.sv ProgCtr_tb.sv
	@#
	pushd icarus/ && $(vvp) basic_proc.vvp
	pushd icarus/ && $(vvp) alu.vvp
	pushd icarus/ && $(vvp) prog_cntr.vvp

.PHONY:	gtkwave
gtkwave:
	$(gtkwave) icarus/basic_proc.vcd &

.PHONY:	gtkwave-regmem
gtkwave-regmem:
	$(gtkwave) icarus/basic_proc.vcd gtkwave/RegMem.gtkw &
