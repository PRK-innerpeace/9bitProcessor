// Create Date:   2022.02.23
// Design Name:   TopLevel Test Bench for Final Submission Testing
// Module Name:   FinalSubmission_tb.v
// CSE141L WI22


// NOTE: We provide this testbench as a reference to assist you as starting point.
// You are responsible for ensuring that your final submission includes a testbench
// that clearly demonstrates your processor's ability to execute the three required
// programs.
//
// If you are unable to get the Start/Done signalling working, you should create
// three separate test benches that exercise each program individually.


module FinalSubmission_tb;

timeunit 1ns;
timeprecision 1ps;

// Storage for final data memory to compare against
logic [8-1:0] DataA,DataB,reg_inputdata,Immediate,datamemory_output;
logic [8:0] inst_information;
logic [9:0]pc_number;
logic [2:0]AddressA,AddressB;

// To DUT Inputs
bit Reset = 1'b1;

//bit Start;
bit Clk;

// From DUT Outputs
wire Ack;              // done flag

TopLevel dut(
.Reset(Reset),
//.Start  (Start),
.Clk(Clk),
.Ack(Ack),
.RegDatatestOutA(DataA),
.RegDatatestOutB(DataB),
.pc_number(pc_number),
.reg_inputdata(reg_inputdata),
.datamemory_output(datamemory_output),
.Immediate(Immediate),
.AddressA(AddressA),
.AddressB(AddressB),
.inst_information(inst_information)
);


// This is the important part of the testbench, where logic might be added
initial begin
  // Reset begins asserted.

  // Load the "golden image" data memory once at the beginning
  // Did you choose the 11-bit or 16-bit interpretation for Program 2?
 // $readmemh("data_mem_01-golden-P2_11.hex", DataMemoryAtFinish);
  //$readmemh("data_mem_01-golden-P2_16.hex", DataMemoryAtFinish);

  // De-assert Reset, Assert Start to "load" P1 as-needed
	#10 Reset = 'b0;
  // #10 Start = 'b1;
	  $display("*** P1 Start");
//	#10 Start = 0;
	#1000 $stop;
end

// This generates the system clock
always begin   // clock period = 10 Verilog time units
  #5 Clk = 1'b1;
  #5 Clk = 1'b0;
end

endmodule

