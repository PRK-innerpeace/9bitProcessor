// Module Name:    ALU
// Project Name:   CSE141L
//
// Additional Comments:
//   combinational (unclocked) ALU

// includes package "Definitions"
import Definitions::*;

module ALU #(parameter W=8, Ops=4)(
  input        [W-1:0]   InputA,       // data inputs
                         InputB,
  input        [Ops-1:0] OP,           // ALU opcode, part of microcode
  input                  SC_in,        // shift or carry in
  output logic [W-1:0]   Out,          // data output
  output logic           Zero,         // output = zero flag    !(Out)
                         Parity,       // outparity flag        ^(Out)
                         Odd           // output odd flag        (Out[0])
                         // you may provide additional status flags, if desired
);

// type enum: used for convenient waveform viewing
op_mne op_mnemonic;

always_comb begin
  // No Op = default
  Out = 0;

  case(OP)
    ADD : Out = InputA + InputB;        // add 
	 SUB : Out = InputA -InputB;
	 MMSW: Out ={InputA[2:0],InputB[7:4],1'b0};
	 MLSW: Out ={InputB[3:1],1'b0,InputB[0],3'b000}; 
	
	 LSH : Out = {InputA[6:0],SC_in};    // shift left, fill in with SC_in r4,5,6,7 =inputB  // for logical left shift, tie SC_in = 0
	 LSHT: Out= {InputA[5:0],2'b00};
	 LSHF: Out= {InputA[3:0],4'b0000};
    RSH : Out = {1'b0, InputA[7:1]};   // shift right
	
	 
	 MOV:  Out =InputB;
	
	 BXOR: Out = {7'b0000_000, ^(InputB)};       // bitwise exclusive OR
	 BWXX: Out ={7'b0000_000, InputA[7]^InputA[6]^InputA[5]^InputA[4]^InputB[7]^InputB[6]^InputB[5]};//p4 = ^(b11:b8,b4,b3,b2) = 1; 
	 BWXY: Out ={7'b0000_000, InputA[7]^InputA[6]^InputA[3]^InputA[2]^InputB[7]^InputB[6]^InputB[3]};//p2 = ^(b11,b10,b7,b6,b4,b3,b1) = 0; 
	 BWXZ: Out ={7'b0000_000, InputA[7]^InputA[5]^InputA[3]^InputA[1]^InputB[7]^InputB[5]^InputB[3]};//p1 = ^(b11,b9,b7,b5,b4,b2,b1) = 1; 

    BREQ:Out = InputA;
	 
    
    default : Out = 8'bxxxx_xxxx;       // Quickly flag illegal ALU
  endcase
end

assign Zero   = ~|Out;                  // reduction NOR
assign Parity = ^Out;                   // reduction XOR
assign Odd    = Out[0];                 // odd/even -- just the value of the LSB

// Toolchain guard: icarus verilog doesn't support this debug feature.
`ifndef __ICARUS__
always_comb
  op_mnemonic = op_mne'(OP);            // displays operation name in waveform viewer
`endif

endmodule
