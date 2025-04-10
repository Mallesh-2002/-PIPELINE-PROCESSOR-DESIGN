module pipeline_processor_tb;
    reg clk;
    reg reset;
    reg [31:0] instruction_in;
    wire [31:0] result;
	
    pipeline_processor uut (.clk(clk),.reset(reset),.instruction_in(instruction_in),.result(result));

    always begin
        #5 clk = ~clk; 
    end

    initial begin
        clk = 0;
        reset = 0;
        instruction_in = 32'b0;

        reset = 1;
        #10;
        reset = 0;

        // Test ADD instruction
        instruction_in = 32'b000000_00001_00010_00000_00000_100000; 
        #10;
        
        // Test SUB instruction
        instruction_in = 32'b000000_00011_00100_00000_00000_100010; 

        // Test LOAD instruction
        instruction_in = 32'b100011_00000_00001_00000_00000_000000; 
        #10;
        $finish;
    end

    initial begin
        $monitor("Time = %0t | Result = %0d", $time, result);
    end

endmodule

