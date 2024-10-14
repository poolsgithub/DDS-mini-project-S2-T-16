module testbench;
    reg [7:0] tasks;
    reg clk, reset;
    wire [3:0] server1_count, server2_count, server3_count;
    wire trigger;
    wire overload;
    integer i, num_tasks;

    load_balancer lb(.tasks(tasks), .clk(clk), .reset(reset), .server1_count(server1_count), .server2_count(server2_count), .server3_count(server3_count), .trigger(trigger), .overload(overload));
 
    always #5 clk = ~clk;

    initial begin
        clk = 0; 
        reset = 1; 
        tasks = 8'b1011111;
        
        num_tasks = 0;
        for (i = 0; i < 8; i = i + 1) begin
            if (tasks[i] == 1'b1)
                num_tasks = num_tasks + 1;
        end 

        #10 reset = 0; 
        
        for (i = 0; i < num_tasks; i = i + 1) begin
            #10;
        end

        $finish;
    end

    
    initial begin
        $dumpfile("DDS.vcd");
        $dumpvars(0,testbench);
        $display("Task queue:%b",tasks);
        $monitor("Time: %0d || Server3: %d || Server2: %d || Server1: %d || trigger: %b || overload: %b ", $time, server1_count, server2_count, server3_count, trigger, overload);
    end
    
endmodule
