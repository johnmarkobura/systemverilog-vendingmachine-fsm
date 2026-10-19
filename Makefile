# TOOLS
IVERILOG = iverilog 
VVP      = vvp 
GTKWAVE  = gtkwave 

# FILES
SOURCE = vendingMachine.sv 
TB = vendingMachine_tb.sv
OUTPUT = vendingMachine_sim
WAVE   = vendingMachine.vcd

# run and compile the vending machine
all: run

# compile the systemVerilog
compile:
	$(IVERILOG) -g2012 -s vending_machine_tb -o $(OUTPUT) $(SOURCE) $(TB)

# run the compiled code
run: compile
	$(VVP) $(OUTPUT)

wave: run 
	$(GTKWAVE) $(WAVE)

clean:
	rm -f $(WAVE) $(OUTPUT)
