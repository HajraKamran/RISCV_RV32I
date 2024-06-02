export CORE_ROOT=/home/labit/projects/RISCV_RV32I/fetch_pipeline

all: icarus

icarus: icarus_compile
	vvp $(CORE_ROOT)/temp/microprocessor.output

icarus_compile:
	mkdir -p temp
	iverilog -f flist -o $(CORE_ROOT)/temp/microprocessor.output

clean:
	rm -rf temp