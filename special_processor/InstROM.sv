// Create Date:    15:50:22 10/02/2019
// Project Name:   CSE141L
// Module Name:    InstROM 
// Description: Instruction ROM template preprogrammed with instruction values
// (see case statement)
//
// Revision:       2020.08.08
// Last Update:    2022.01.13

// Parameters:
//  A: Number of address bits in instruction memory
//  W: Width of instruction memory entry
module InstROM #(parameter A=10, W=9) (
  input  logic   [A-1:0] InstAddress,
  output logic [W-1:0] InstOut
);

// Sample instruction format:
//   {3bit opcode; 3bit rs or rt; 3bit rt, immediate, or branch target}
//   then use LUT to map 3 bits to 10 for branch target, 8 for immediate


// Approach 1: Write machine code directly as combinational cases.
//
// This may be easier when first starting, before you have an assembler
// written or any way of automatically generating machine code.
//
// This is usually the fastest / easiest way to test individual instructions.

always_comb begin 
  InstOut = 'b000_000_000;       // default
  case (InstAddress)
    // Note: The `Effect`s listed here assume that some entries in
    // the data memory have been initialzed, specifically:
    // MEM[0] = 16
    // MEM[16] = 254

0:InstOut  = 'b010000000;
1:InstOut  = 'b010001010;
2:InstOut  = 'b000100000; 
3:InstOut  = 'b010101001;
4:InstOut  ='b011000100;
5:InstOut  ='b010010000;
6:InstOut  ='b101011010;
7:InstOut  ='b011100010;
8 :InstOut  ='b011110011;
9	:InstOut  ='b101110010;
10	:InstOut  ='b110101000;
11	:InstOut  ='b011101000;
12:InstOut  ='b011010100;
13	:InstOut  ='b001010001;
14:InstOut  ='b101101010;
15:InstOut  ='b101100011;
16:InstOut  ='b110100001;
17:InstOut  ='b100100010;
18:InstOut ='b010111111;
19:InstOut='b011011101;
	 

    // (default case already covered by opening statement)
  endcase
end



// Approach 2: Create an actual instruction memory, and populate it
// from an external file.
//
// This is usually what you will switch to fairly quickly, once you
// start testing your actual program implementations on your core,
// rather than individual instructions.
//
//
//// Declare 2-dimensional array, W bits wide, 2**A words deep
//logic [W-1:0] inst_rom[2**A];
//
//// This is where memory is read
//always_comb InstOut = inst_rom[InstAddress];
//
//// And this runs once during initalization to load instruction memory from
//// external file using $readmemh or $readmemb.
//initial begin
//  // NOTE: This may not work depending on your simulator
//  //       e.g. Questa needs the file in path of the application .exe,
//  //       it doesn't care where you project code is
//  $readmemb("../inst_mem.hex",inst_rom);
//
//  // So you are probably better off with an absolute path,
//  // but you will have to change this example path when you
//  // try this on your machine most likely:
//  //$readmemb("//vmware-host/Shared Folders/Downloads/basic_proc2/machine_code.txt", inst_rom);
//end


endmodule
