module pipeline_processor (
    input clk,
    input reset,
    input [31:0] instruction_in,  
    output reg [31:0] result);

    reg [31:0] IF_ID_instr, ID_EX_instr, EX_MEM_instr, MEM_WB_instr;
    reg [31:0] IF_ID_pc, ID_EX_pc, EX_MEM_pc, MEM_WB_pc;
    reg [31:0] registers [0:31]; // 32 registers

    reg [3:0] alu_op;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            IF_ID_instr <= 32'b0;
            ID_EX_instr <= 32'b0;
            EX_MEM_instr <= 32'b0;
            MEM_WB_instr <= 32'b0;
            result <= 32'b0;
        end else begin
            
            IF_ID_instr <= instruction_in;
            IF_ID_pc <= IF_ID_pc + 4; 
            ID_EX_instr <= IF_ID_instr;
            ID_EX_pc <= IF_ID_pc;
            
            EX_MEM_instr <= ID_EX_instr;
            EX_MEM_pc <= ID_EX_pc;

            MEM_WB_instr <= EX_MEM_instr;

            if (MEM_WB_instr[31:26] == 6'b000000) 
			begin 
                    6'b100000: result <= registers[MEM_WB_instr[25:21]] + registers[MEM_WB_instr[20:16]]; 
                    6'b100010: result <= registers[MEM_WB_instr[25:21]] - registers[MEM_WB_instr[20:16]]; 
                   
                endcase
            end else if (MEM_WB_instr[31:26] == 6'b100011)
			begin 
                result <= registers[MEM_WB_instr[25:21]]; 
            end
        end
    end
endmodule

