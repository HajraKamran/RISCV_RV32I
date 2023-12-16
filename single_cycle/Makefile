export CORE_ROOT=/home/hajra/RISCV_RV32I/single_cycle

all: icarus

icarus: icarus_compile
	vvp $(CORE_ROOT)/temp/Microprocessor.output

icarus_compile:
	mkdir -p temp
	iverilog -f flist -o $(CORE_ROOT)/temp/Microprocessor.output

clean:
	rm -rf temp