// Reset with SW[0]. Clock counter and memory with KEY[0]. Clock
// each instuction into the processor with KEY[1]. SW[9] is the Run input.
// Use KEY[0] to advance the memory as needed before each processor KEY[1]
// clock cycle.
module part2 (KEY, SW, LEDR,HEX0,HEX1,HEX2,HEX3);
    input [1:0] KEY;
    input [9:0] SW;
    output [9:0] LEDR;	
	 output [6:0] HEX0,HEX1,HEX2,HEX3;

    wire Done, Resetn, PClock, MClock, Run;
    wire [15:0] DIN;
    wire [4:0] pc;

    assign Resetn = SW[0];
    assign MClock = KEY[0];
    assign PClock = KEY[1];
    assign Run = SW[9];

	 wire [15:0] reg0,reg1;
	 
    proc U1 (DIN, Resetn, PClock, Run, Done,reg0,reg1);
	 
    assign LEDR[8] = Done;
    assign LEDR[9] = Run;
	 wire [15:0] OHEX;
	 alternateReg(reg0,reg1,SW[8],OHEX);
	 hexDisplay (OHEX[15:12],HEX3);
	 hexDisplay (OHEX[11:8],HEX2);
	 hexDisplay (OHEX[7:4],HEX1);
	 hexDisplay (OHEX[3:0],HEX0);
	 
	 assign LEDR[6:2] = pc;
	 

    inst_mem U2 (pc, MClock, DIN);
    count5 U3 (Resetn, MClock, pc);
endmodule

module count5 (Resetn, Clock, Q);
    input Resetn, Clock;
    output reg [4:0] Q;

    always @ (posedge Clock, negedge Resetn)
        if (Resetn == 0)
            Q <= 5'b00000;
        else
            Q <= Q + 1'b1;
 endmodule
 
 

module alternateReg(A,B,s,O);
	
	input s;
	input [15:0] A,B;
	output reg [15:0] O;
	
	always @ (*) begin
	if(s) O<=A;
	else O<=B;
	
	end
endmodule
module hexDisplay(X,D);
	input [3:0] X;
	output [6:0] D;
	
	assign D[0] = (~X[3]&~X[2]&~X[1]&X[0])|(~X[3]&X[2]&~X[1]&~X[0])|(X[3]&~X[2]&X[1]&X[0])|(X[3]&X[2]&~X[1]&X[0]);
	assign D[1] = (~X[3]&~X[1]&X[0])|(X[2]&X[1]&~X[0])|(X[3]&X[1]&X[0])|(X[3]&X[2]&~X[0]);
	assign D[2] = (X[3]&X[2]&~X[0])|(X[3]&X[2]&X[1])|(~X[3]&~X[2]&~X[1]&X[0])|(~X[3]&~X[2]&X[1]&~X[0]);
	assign D[3] = (~X[2]&~X[1]&X[0])|(X[2]&X[1]&X[0])|(~X[3]&X[2]&~X[1]&~X[0])|(X[3]&~X[2]&X[1]&~X[0]);
	assign D[4] = (~X[3]&X[1]&X[0])|(~X[3]&X[2]&~X[1])|(X[3]&~X[2]&~X[1]&X[0]);
	assign D[5] = (~X[3]&~X[2]&X[1])|(~X[3]&X[1]&X[0])|(X[3]&X[2]&~X[1]&X[0]);
	assign D[6] = (~X[3]&~X[2]&~X[1])|(~X[3]&X[2]&X[1]&X[0])|(X[3]&X[2]&~X[1]&~X[0]);
	

endmodule
