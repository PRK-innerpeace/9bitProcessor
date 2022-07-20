# Project language 
System verilog

# IDE
Quartus-lite-16.0.0.211

# Processor features designed in the project

## ISA architecture
Instruction set architecture shall feature fixed-length instructions 9 bits wide.
## Data path length
All internal data paths and storage are 8 bits wide.
## Memory space
main memory of 256 bytes (8-bit address pointer).
## ROM size

you can see InstROM.sv file.

module InstROM #(parameter A=10, W=9) (
  input  logic   [A-1:0] InstAddress,
  output logic [W-1:0] InstOut
);
so ROM size is 2^10=1024 and my instruction memory is 9 bits wide, to hold my 9-bit machine code,so total size is 1024 * 9 bit.


