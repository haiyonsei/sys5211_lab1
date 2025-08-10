

TB              := ../src/test/verilog/tb_npuexetop.sv
GEN_SRCS 		:= NpuExeTop.v
SRCS			:= ../src/main/verilog/NpuExeTop.v ../src/main/verilog/NpuExeController.v


simv: $(SRCS) $(TB)
	vcs -full64 -sverilog -timescale=1ns/1ps $(TB) $(SRCS) -debug_access+all 

gui: $(SRCS) $(TB)
	vcs -full64 -sverilog -timescale=1ns/1ps $(SRCS) $(TB) -debug_access+all -gui -kdb

ref: $(GEN_SRCS) $(TB)
	vcs -full64 -sverilog -timescale=1ns/1ps $(TB) $(GEN_SRCS) -debug_access+all 

refgui: $(GEN_SRCS) $(TB)
	vcs -full64 -sverilog -timescale=1ns/1ps $(TB) $(GEN_SRCS) -debug_access+all -gui -kdb

NpuExeTop.v:
	cd ..; java -jar /hai/projects/haf/202507/chipyard/generators/rocket-chip/sbt-launch.jar "runMain npu.EmitVerilog --target-dir build"; cd build

run:
	./simv

clean:
	rm -rf NpuExeTop.v ./simv* ./project *.fir *.json  novas*.* *.fsdb verdiLog ucli.key csrc target
