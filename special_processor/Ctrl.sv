		// Project Name:   CSE141L
		// Module Name:    Ctrl
		// Create Date:    ?
		// Last Update:    2022.01.13

		// control decoder (combinational, not clocked)
		// inputs from ... [instrROM, ALU flags, ?]
		// outputs to ...  [program_counter (fetch unit), ?]
		import Definitions::*;

		// n.b. This is an example / starter block
		//      Your processor **will be different**!
		module Ctrl (
		input  [8:0] Instruction,    // machine code
									 // some designs use ALU inputs here
		output logic       Jump,
						BranchEn, // branch at all?
						RegWrEn,  // write to reg_file (common)
						MemWrEn,  // write to mem (store only)
						LoadInst, // mem or ALU to reg_file ?
						Immediate_select,
						AddressSel,
						Ack,      // "done with program"
		output logic [3:0] ALUOp,
		output logic [2:0] TargSel   // how to target branch (maybe?)
		);

		// What follows is instruction decoding.
		// This codifies much of your ISA definition!
		//
		// Note: This **starter code** is not a complete ISA!




		// reserve instruction = 9'b111111111; for Ack
		assign Ack = &Instruction;

		// jump on right shift that generates a zero
		// equiv to simply: assign Jump = Instruction[2:0] == RSH;

always_comb begin

	case (Instruction[8:6])
	
		3'b000: begin 		//load 
			RegWrEn=1'b1;
			LoadInst=1'b1;
			Jump=1'b0;
			BranchEn=1'b0;
			MemWrEn=1'b0; // write to mem (store only)
			Immediate_select=1'b0;
			AddressSel=1'b0;
			ALUOp=4'bxxxx;
		end 

		3'b001: begin //write
			MemWrEn=1;
			Jump=1'b0;
			BranchEn=1'b0;
			RegWrEn=1'b0;  // write to reg_file (common)
			LoadInst=1'b0; // mem or ALU to reg_file ?
			Immediate_select=1'b0;
			AddressSel=1'b0;
			ALUOp=4'bxxxx;
		end
		
		3'b010: 	
		begin //write immediate value 0,1,30,64,94,128,160,192 to register(0-7) 
			Immediate_select=1;
			RegWrEn=1;
			Jump=1'b0;
			BranchEn=1'b0;
			MemWrEn=1'b0; // write to mem (store only)
			LoadInst=1'b0; // mem or ALU to reg_file ?
			AddressSel=1'b0;
			ALUOp=4'bxxxx;
		end

		3'b011: 
		begin  //ALU operation
			case (Instruction[1:0])
				2'b00: 
				begin 
					ALUOp = 4'b0000; 
					AddressSel=1'b1;					
					RegWrEn=1'b1; 
					Jump=1'b0;
					BranchEn=1'b0;
					MemWrEn=1'b0; // write to mem (store only)
					LoadInst=1'b0; // mem or ALU to reg_file ?
					Immediate_select=1'b0;
				end //add
						
						
				2'b01: 
				begin 
					ALUOp = 4'b0001; 
					AddressSel=1'b1;					
					RegWrEn=1'b1; 
					Jump=1'b0;
					BranchEn=1'b0;
					MemWrEn=1'b0; // write to mem (store only)
					LoadInst=1'b0; // mem or ALU to reg_file ?
					Immediate_select=1'b0;
				end //add
				2'b10: 
				begin 
					ALUOp = 4'b0010; 
					AddressSel=1'b1;					
					RegWrEn=1'b1; 
					Jump=1'b0;
					BranchEn=1'b0;
					MemWrEn=1'b0; // write to mem (store only)
					LoadInst=1'b0; // mem or ALU to reg_file ?
					Immediate_select=1'b0;
				end //add
				2'b11: 
				begin 
					ALUOp = 4'b0011; 
					AddressSel=1'b1;					
					RegWrEn=1'b1; 
					Jump=1'b0;
					BranchEn=1'b0;
					MemWrEn=1'b0; // write to mem (store only)
					LoadInst=1'b0; // mem or ALU to reg_file ?
					Immediate_select=1'b0;
				end //add
		endcase
		end

		3'b100:  //  for shift operation
			begin  
			case (Instruction[1:0])
				2'b00: 
				begin 
					ALUOp = 4'b0100;
					AddressSel=1'b1;					
					RegWrEn=1'b1; 
					Jump=1'b0;
					BranchEn=1'b0;
					MemWrEn=1'b0; // write to mem (store only)
					LoadInst=1'b0; // mem or ALU to reg_file ?
					Immediate_select=1'b0;
				end //add
				
				2'b01: 
				begin 
					ALUOp = 4'b0101;
					AddressSel=1'b1;					
					RegWrEn=1'b1; 
					Jump=1'b0;
					BranchEn=1'b0;
					MemWrEn=1'b0; // write to mem (store only)
					LoadInst=1'b0; // mem or ALU to reg_file ?
					Immediate_select=1'b0;
				end //add
				
				2'b10:   //BXOR
				begin 
					ALUOp = 4'b0110;
					AddressSel=1'b1;					
					RegWrEn=1'b1; 
					Jump=1'b0;
					BranchEn=1'b0;
					MemWrEn=1'b0; // write to mem (store only)
					LoadInst=1'b0; // mem or ALU to reg_file ?
					Immediate_select=1'b0;
				end //add
				2'b11: 
				begin 
					ALUOp = 4'b0111;
					AddressSel=1'b1;					
					RegWrEn=1'b1; 
					Jump=1'b0;
					BranchEn=1'b0;
					MemWrEn=1'b0; // write to mem (store only)
					LoadInst=1'b0; // mem or ALU to reg_file ?
					Immediate_select=1'b0;
				end //add
		endcase
		end

		3'b101:  
		begin  // mov rt,rs   :rt is Target register. rs is source register :rt=rs
			ALUOp = 4'b1000;
			RegWrEn=1;
			Jump=1'b0;
			BranchEn=1'b0;
			MemWrEn=1'b0; // write to mem (store only)
			LoadInst=1'b0; // mem or ALU to reg_file ?
			Immediate_select=1'b0;
			AddressSel=1'b0;
		end

		
		3'b110: 
		begin  // 
			case (Instruction[1:0])
				2'b00: 
				begin 
					ALUOp = 4'b1001;
					AddressSel=1'b1;					
					RegWrEn=1'b1; 
					Jump=1'b0;
					BranchEn=1'b0;
					MemWrEn=1'b0; // write to mem (store only)
					LoadInst=1'b0; // mem or ALU to reg_file ?
					Immediate_select=1'b0;
				end //add
				
				2'b01: 
				begin 
					ALUOp = 4'b1010;
					AddressSel=1'b1;					
					RegWrEn=1'b1; 
					Jump=1'b0;
					BranchEn=1'b0;
					MemWrEn=1'b0; // write to mem (store only)
					LoadInst=1'b0; // mem or ALU to reg_file ?
					Immediate_select=1'b0;
				end //add
				
				2'b10:   //MMSW
				begin 
					ALUOp = 4'b1011;
					AddressSel=1'b1;					
					RegWrEn=1'b1; 
					Jump=1'b0;
					BranchEn=1'b0;
					MemWrEn=1'b0; // write to mem (store only)
					LoadInst=1'b0; // mem or ALU to reg_file ?
					Immediate_select=1'b0;
				end //add
				2'b11: 
				begin 
					ALUOp = 4'b1100;
					AddressSel=1'b1;					
					RegWrEn=1'b1; 
					Jump=1'b0;
					BranchEn=1'b0;
					MemWrEn=1'b0; // write to mem (store only)
					LoadInst=1'b0; // mem or ALU to reg_file ?
					Immediate_select=1'b0;
				end //add
		endcase


		end
		
3'b111: 
		begin  // BREQ rt :if(rt)==0  
			case (Instruction[3]) 
				1'b0: 
				begin 
					ALUOp = 4'b1101;
					AddressSel=1'b1;					
					RegWrEn=1'b0; 
					Jump=1'b0;
					BranchEn=1'b1;
					MemWrEn=1'b0; // write to mem (store only)
					LoadInst=1'b0; // mem or ALU to reg_file ?
					Immediate_select=1'b0;
				end //add
				
				1'b1: //Jump d :d=0-7
				case (Instruction[5:4])
				2'b00:
				begin 
					ALUOp = 4'b1110;
					AddressSel=1'b0;					
					RegWrEn=1'b0; 
					Jump=1'b1;
					BranchEn=1'b0;
					MemWrEn=1'b0; // write to mem (store only)
					LoadInst=1'b0; // mem or ALU to reg_file ?
					Immediate_select=1'b0;
				end //add
				
				2'b01:
						begin
		Jump=1'bx;
		BranchEn=1'bx;
		MemWrEn=1'bx; // write to mem (store only)
		LoadInst=1'bx; // mem or ALU to reg_file ?
		Immediate_select=1'bx;
		AddressSel=1'bx;
		RegWrEn=1'bx;
		ALUOp = 4'bxXXX;


		end
				2'b10:
						begin
		Jump=1'bx;
		BranchEn=1'bx;
		MemWrEn=1'bx; // write to mem (store only)
		LoadInst=1'bx; // mem or ALU to reg_file ?
		Immediate_select=1'bx;
		AddressSel=1'bx;
		RegWrEn=1'bx;
		ALUOp = 4'bxXXX;


		end
		2'b11:
				begin
		Jump=1'bx;
		BranchEn=1'bx;
		MemWrEn=1'bx; // write to mem (store only)
		LoadInst=1'bx; // mem or ALU to reg_file ?
		Immediate_select=1'bx;
		AddressSel=1'bx;
		RegWrEn=1'bx;
		ALUOp = 4'bxXXX;


		end
				endcase
				

				
				
		endcase


		end		
		
		
		default : 
		begin
		Jump=1'bx;
		BranchEn=1'bx;
		MemWrEn=1'bx; // write to mem (store only)
		LoadInst=1'bx; // mem or ALU to reg_file ?
		Immediate_select=1'bx;
		AddressSel=1'bx;
		RegWrEn=1'bx;
		ALUOp = 4'bxXXX;


		end
		  // Quickly flag illegal ALU
		endcase








		//  if(Instruction[2:0] == RSH) begin
		//    Jump = 1;
		//  end else begin
		//    Jump = 0;
		//  end
		end

		// branch every time instruction = 9'b?????1111;
		//assign BranchEn = &Instruction[3:0];

		// Maybe define specific types of branches?
		assign TargSel  = Instruction[2:0];

		endmodule
