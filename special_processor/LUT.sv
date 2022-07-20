// Design Name:    CSE141L
// Module Name:    LUT

// possible lookup table for PC target
// leverage a few-bit pointer to a wider number
// Lookup table acts like a function: here Target = f(Addr);
// in general, Output = f(Input)
//
// Lots of potential applications of LUTs!!

// You might consider parameterizing this!
module LUT(
  input        [2:0] Addr,
  output logic [9:0] Target,
  output logic [7:0] Immediate
);

always_comb begin

  case(Addr)
    3'b000: 
	 begin
	 Target = 10'h000; // -16, i.e., move back 16 lines of machine code
	 Immediate = 8'd0;
	 end
	 
    3'b001: 	 
	 begin
	 Target = 10'h002; // -16, i.e., move back 16 lines of machine code
	 Immediate = 8'd1;
	 end
    3'b010: 	 
	 begin
	 Target = 10'h1f0; // -16, i.e., move back 16 lines of machine code
	 Immediate = 8'd30;
	 end
    3'b011: 	 
	 begin
	 Target = 10'h2f0; // -16, i.e., move back 16 lines of machine code
	 Immediate = 8'd64;
	 end
	 3'b100: 	 
	 begin
	 Target = 10'h2ff; // -16, i.e., move back 16 lines of machine code
	 Immediate = 8'd94;
	 end
    3'b101: 	 
	 begin
	 Target = 10'h3f0; // -16, i.e., move back 16 lines of machine code
	 Immediate = 8'd128;
	 end
    3'b110:	 
	 begin
	 Target = 10'h3ff; // -16, i.e., move back 16 lines of machine code
	 Immediate = 8'd160;
	 end
    3'b111: 	
	 begin
	 Target = 10'h2f2; // -16, i.e., move back 16 lines of machine code
	 Immediate = 8'd192;
	 end
  endcase
end

endmodule
