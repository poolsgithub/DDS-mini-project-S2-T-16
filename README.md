# DYNAMIC LOAD BALANCING IN COMPUTING

<!-- First Section -->
## Team Details
<details> 
  <summary>Meet us</summary>

  > Semester: 3rd Sem B. Tech. CSE

  > Section: S2

  >Team-ID: S2-T16 

  > Member-1:	G. SANTHOSH BALAJI , 231CS224 , santhoshbalajig.231cs224@nitk.edu.in


  > Member-2:	M. DATTATREYA LAXMI NARASIMHA , 231CS231 , manepallidattatreyalaxminarasimha.231cs231@nitk.edu.in


  > Member-3:	T. SAI NISHNATH RAO , 231CS260 , tungenasainishnathrao.231cs260@nitk.edu.in

</details>

<!-- Second Section -->
## Abstract
<details>
  <summary>See Our Abstract</summary>
  
 ### Motivation
 
  In an era where computing demands are increasing hence, efficient resource management is crucial to
  ensure better performance and reliability in distributed systems and cloud infrastructures.
  General static load balancing methods generally fail in dynamically changing workloads, 
  leading to inefficiencies. Dynamic load balancing emerges as a crucial solution.

### Problem Statement

This project aims to create a dynamic load balancing system that automatically adjusts on how workloads are shared among servers to prevent any single server from becoming
overwhelmed. The goal is to improve overall system speed and efficiency, especially when the number
of tasks change.

### Features

• The clock is used to synchronize the operations of all components. This guarantees that no two
tasks are allocated at the same time, preventing conflicts or misallocations. It displays the time
for the request to get accepted by server.

• LEDs are incorporated to provide real-time visual feedback of the system’s operation.

• If a server’s counter exceeds a predefined threshold, the system initiates load rebalancing.Which
reassigns the request to different server.

• Dynamic load balancing systems can prioritize certain tasks over others based on predefined
criteria such as urgency, resource intensity or deadline.

• Dynamic load balancing can reduce the overall power consumption of a system.


</details>



## Functional Block Diagram
<details>
  <summary>Click to view</summary>  


![dds](https://github.com/user-attachments/assets/120739ab-7096-4d4e-b12c-97c9306b10cf)

</details>

## Working

<details>

<summary> Working is Here (click) </summary>

### Working

 ####  Load Balancer Description
 Dynamic Load Balancer is designed to distribute tasks efficiently across three servers based on their current
 load. It receives an 8-bit input, where each bit represents a specific task, once a task is identified it compares
 loads of the three servers and assigns the task to the least loaded server. After allocation it checks whether
 any of the servers are approaching the predefined load threshold If one or more servers are nearing this
 threshold, the load balancer generates a signal alerting the system to the increasing load. If all servers exceed
 the threshold, an overload signal is triggered, indicating that no server can take more tasks without being
 overburdened. The system operates continuously, processing tasks one by one and dynamically distributing
 them to maintain load balance across the servers.

 ![main](https://github.com/user-attachments/assets/cbaecf4f-cd7a-4c8b-b6c9-8c8193ffef83)

 (a) Truth Table of Load Balancer
  #### Key Components of the Load Balancer Design
 ##### Priority Encoder (8-to-3):
 • Function:
 Converts an 8-bit input signal (representing tasks) into a 3-bit output signal. The 3-bit output indicates
 the position of the highest-priority task (i.e., the first non-zero bit).
 • Working:
 The encoder checks each bit of the input from highest (bit 7) to lowest (bit 0). It outputs a 3-bit code
 representing the index of the highest-priority bit that is set to ’1’.

 ![priority](https://github.com/user-attachments/assets/61c136fe-c99c-4280-8bc4-404c98759d13)

(b) Priority encoder Truth Table

  ##### Decoder (3-to-8):
 • Function:
 Takes the 3-bit input from the priority encoder and outputs an 8-bit signal, with one bit set to ’1’
 representing the corresponding task position.
 • Working:
 The decoder maps the 3-bit input to a single active line in the 8-bit output. This active line represents
 the task that will be processed, with all other tasks cleared.

 ![decoder](https://github.com/user-attachments/assets/1bd82847-305a-490c-80a1-73d795971b6f)

 (c) Decoder 3 to 8 Truth Table
 ##### Multiplexer:
 • Function:
 The Multiplexer (MUX) has several inputs and additional input called select lines and a single output
 which is based on the select lines.
 • Working:
 The Multiplexer (MUX) selects one of several input signals and forwards the selected input into a
 single output line based on the select lines which determines the qualities of the output.

 ![multiplexer](https://github.com/user-attachments/assets/041799ca-4433-4c58-a7b3-64344bb4e392)

(d) Multiplexer Truth Table
 ##### D Flip-Flop:
 • Function:
 A simple memory element used to store a bit value. It updates its output on the rising edge of the
 clock or reset signal.
 
• Working:
 In this circuit, the D flip-flop is not explicitly used in the load balancer design, but it could be used
 for task or state synchronization.
  ##### 4-Bit Comparator:
 • Function:
 Compares two 4-bit inputs and outputs signal indicates whether inputs are equal or which input is
 greater.
 
 • Working:
 The comparators in this circuit are used to compare the current load of the servers. They help identify
 which server has the least number of tasks.
 
 • Comparison Equation for server counts:
 
 server1_least=(server1_count<=server2_count)(server1_count<=server3_count)
 
 server2_least=(server2_count<=server3_count)(server2_count<server1_count)
 
 server3_least=(server3_count<server1_count)(server3_count<server2_count
 

![4-bit comp](https://github.com/user-attachments/assets/3776bd52-cf93-47ec-8c96-367949245a94)

 (e) 4-bit comparator Truth Table
 ##### 4-Bit Counter:
 • Function:
 Increments a 4-bit count on each clock cycle.
 • Working:
 When a clock is at positive edge then the counter increases by one unit
 
 • Server Count Update:

 ![server](https://github.com/user-attachments/assets/61b1d390-d7ac-4175-a77b-39584d037de1)

 
##### HEX-Display:
 • Function: HEX display is a type of 7-segment display designed to represent hexadecimal (base-16)
 digits. It can display numbers from 0 to 9 and letters from A to F, which correspond to hexadecimal
 digits.The hex display operates using binary inputs that are converted into hexadecimal output.
#### Load balancing Module
 ##### Input Signals:
 • Tasks: An 8-bit input representing available tasks.
 
 • Clock and Reset: Clock and reset signals for synchronous operation.
 
##### Output Signals:
 • HEX-display: HEX display’s are used for indicating the number of tasks assigned to a server.
 
 • LED: LED’s are used to indicate the overload and trigger.
 
 • Trigger: Signal indicating if any server’s task count exceeds a threshold.
 
 • Overload: Signal indicating if all servers’ task counts exceed the threshold.
 
 ##### Internal Logic:
 • Task Encoding: The Priority Encoder encodes the current task to a 3-bit code representing the
 highest-priority task.
 
 • Task Decoding: The Decoder decodes this 3-bit code to an 8-bit signal representing the remaining
 tasks after processing the current one.
 
 • Task Assignment: The output of the 3-Input 4-bit comparator we built , the server with the fewest
 tasks receives the new task. The multiplexer is used to assign the corresponding server hence the task
 counter is incremented.
 
 • Task Update: The 8-Input Flip-Flop register updates to reflect the remaining tasks.
 
 • Threshold Monitoring: The Comparator compares each server’s count with a threshold (set to 3).
 
 If any server exceeds the threshold, the system triggers for rebalancing an LED is used to display it .
 
 If all servers exceed the threshold, the system overloads a LED is used to display it.
 #### Operation Flow
 • Task Input: The input (8 bits) indicates which tasks are currently available.
 
 • Priority Encoding: The priority encoder identifies the highest priority active task.
 
 • Task Assignment: The decoder activates the corresponding task output, allowing the system to
 determine which task is to be handled next.
 
 • Load Tracking: The comparator compares the current load on each server. Then a multiplexer is
 used to assign the task to the server with the least current load.
 
 • Threshold Monitoring: If the load on any server exceeds a predefined threshold, the overload
 signal is activated, allowing for potential scaling or alerting mechanisms.


### Flowchart


![flowchart](https://github.com/user-attachments/assets/cf6bb252-001f-4627-a021-8c0b6b446b7e)


</details>


## Logisim Circuit Diagram

<details>

<summary> circuits we built </summary>


![S2-T16](https://github.com/user-attachments/assets/fbabd67f-6a85-46a2-ba13-0e4d5a0a6395)


![8-Input flip flop ](https://github.com/user-attachments/assets/ca8849b2-f49e-4251-802b-7bdd85dd3bb5)

![3-Input 4-bit comparator ](https://github.com/user-attachments/assets/28bf059e-dcfb-48a0-a1cf-7f78662a216f)


  
</details>

## Verilog Code

<details>

<summary>Gate-level</summary>

#### Load_balancer:

 The load balancer continuously monitors the task counts of each server. If any server's load exceeds a predefined threshold, the system generates an overload signal, indicating that the server is at capacity. This design enhances the efficiency and performance of the overall system, especially in dynamic computing environments where task loads fluctuate.

 
    module load_balancer_gate_level (
    input [7:0] tasks,
    input clk, reset,
    output reg [3:0] server1_count, server2_count, server3_count,
    output trigger,
    output overload
    );

    wire [2:0] priority_task;
    wire [7:0] remaining_tasks;
    reg [7:0] tasks_reg;
    
    wire server1_least, server2_least, server3_least;

    
    priority_encoder_8to3 encoder(.in(tasks_reg), .out(priority_task));

    
    decoder_3to8 decoder(.in(priority_task), .out(remaining_tasks));

    
    always @(posedge clk or posedge reset) begin
        if (reset)
            tasks_reg <= tasks;
        else if (tasks_reg != 0)
            tasks_reg <= remaining_tasks;
    end

   
    comparator_4bit comp1(.a(server1_count), .b(server2_count), .less_than(server1_least));
    comparator_4bit comp2(.a(server2_count), .b(server3_count), .less_than(server2_least));
    comparator_4bit comp3(.a(server3_count), .b(server1_count), .less_than(server3_least));

    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            server1_count <= 0;
            server2_count <= 0;
            server3_count <= 0;
        end
        else if (tasks_reg != 0) begin
            if (server1_least) 
                server1_count <= server1_count + 1;
            else if (server2_least) 
                server2_count <= server2_count + 1;
            else 
                server3_count <= server3_count + 1;
        end
    end

    reg [3:0]threshold = 4'b0011;
    wire server1_threshold, server2_threshold, server3_threshold;

    comparator_4bit thre1(.a(threshold), .b(server1_count), .less_than(server1_threshold));
    comparator_4bit thre2(.a(threshold), .b(server2_count), .less_than(server2_threshold));
    comparator_4bit thre3(.a(threshold), .b(server3_count), .less_than(server3_threshold));

    or(trigger,server1_threshold,server2_threshold,server3_threshold);
    and(overload,server1_threshold,server2_threshold,server3_threshold);

    endmodule

#### Priority Encoder (8-to-3):
This module takes an 8-bit input representing tasks and outputs a 3-bit signal indicating the highest priority task. The highest bit represents the task that should be assigned first based on the current load.


    module priority_encoder_8to3 (
    input [7:0] in,
    output [2:0] out
    );

    wire in_high, in_mid;
    wire in7_or_in6, in7_or_in6_or_in5, in7_or_in6_or_in5_or_in4, in3_or_in2, not_in6, not_in_high, not_in_mid;


    or (in7_or_in6, in[7], in[6]);
    or (in7_or_in6_or_in5, in7_or_in6, in[5]);
    or (in_high, in7_or_in6_or_in5, in[4]);


    or (in3_or_in2, in[3], in[2]);
    assign in_mid = in3_or_in2;


    and (out[2], in_high);

    not (not_in_high, in_high);
    and (Y1_mid_term, not_in_high, in_mid);
    or (Y1_or_term, in[7], in[6], Y1_mid_term);
    and (out[1], Y1_or_term);

    not (not_in6, in[6]);
    not (not_in_mid, in_mid);
    and (Y0_mid_term1, not_in6, in[5]);
    and (Y0_mid_term2, not_in_high, not_in_mid, in[1]);
    or (Y0_or_term, in[7], Y0_mid_term1, Y0_mid_term2);
    and (out[0], Y0_or_term);

    endmodule

#### Decoder (3-to-8):
The decoder converts the 3-bit output from the priority encoder back into an 8-bit signal. This 8-bit signal activates the corresponding task output, ensuring that the correct task is assigned to the identified server.

    module decoder_3to8 (
    input [2:0] in,
    output [7:0] out
    );

    wire in0_inv, in1_inv, in2_inv;

    not (in0_inv, in[0]);
    not (in1_inv, in[1]);
    not (in2_inv, in[2]);

    and (out[0], in0_inv, in1_inv, in2_inv);
    and (out[1], in[0], in1_inv, in2_inv);
    and (out[2], in0_inv, in[1], in2_inv);
    and (out[3], in[0], in[1], in2_inv);
    and (out[4], in0_inv, in1_inv, in[2]);
    and (out[5], in[0], in1_inv, in[2]);
    and (out[6], in0_inv, in[1], in[2]);
    and (out[7], in[0], in[1], in[2]);

    endmodule

#### D Flip-Flop: 
This flip-flop is used to store the current state of the task and updates the state on the rising edge of the clock. It ensures that the system correctly tracks which tasks are currently being processed.

    module d_flip_flop (
    input clk, reset, d,
    output reg q
    );


    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else
            q <= d;
    end

    endmodule
#### 4-Bit Comparator: 
The comparator is essential for comparing the task counts of the three servers. It determines which server has the least load and therefore should receive the next task. By continually comparing the loads, the system can make informed decisions on task distribution.

    module comparator_4bit (
      input [3:0] a,
      input [3:0] b,
      output less_than
     );
  
  
    wire eq0, eq1, eq2, eq3;
    wire lt0, lt1, lt2, lt3;
  
    wire eq01, eq012, eq0123;
    wire lt01, lt012, lt0123;
  
    xnor(eq0, a[0], b[0]);
    xnor(eq1, a[1], b[1]);
    xnor(eq2, a[2], b[2]);
    xnor(eq3, a[3], b[3]);
  
    and(lt0, ~a[0], b[0]);
    and(lt1, ~a[1], b[1]);
    and(lt2, ~a[2], b[2]);
    and(lt3, ~a[3], b[3]);
  
    and(eq01, eq0, eq1);
    and(eq012, eq01, eq2);
    and(eq0123, eq012, eq3);
  
    wire eq1_and_lt0, eq2_and_lt01, eq3_and_lt012;
    and(eq1_and_lt0, eq1, lt0);
    or(lt01, lt1, eq1_and_lt0);
  
    and(eq2_and_lt01, eq2, lt01);
    or(lt012, lt2, eq2_and_lt01);
  
    and(eq3_and_lt012, eq3, lt012);
    or(lt0123, lt3, eq3_and_lt012);
  
    assign less_than = lt0123;

    endmodule

#### 2-Bit Counter: 

This counter keeps track of the number of tasks assigned to each server. It increments its count on each clock cycle, allowing the load balancer to monitor the distribution of tasks accurately.


    module counter_2bit (
    input clk, reset,
    output reg [1:0] count
    );


    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 0;
        else
            count <= count + 1;
    end
    endmodule


   
</details>
    

<details>

<summary>Behaviourial_model</summary>


    module load_balancer_behavioral (
    input [7:0] tasks,
    input clk,
    input reset,
    output reg [3:0] server3_count,
    output reg [3:0] server2_count,
    output reg [3:0] server1_count,
    output reg trigger,
    output reg overload
    );

    reg [3:0] server_load [0:2];
    integer i;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            server3_count <= 0;  
            server2_count <= 0;
            server1_count <= 0;
            server_load[0] <= 2;
            server_load[1] <= 0;
            server_load[2] <= 0;
            trigger <= 0;
            overload <= 0;
        end 
        else begin
            for (i = 0; i < 8; i = i + 1) begin
                if (tasks[i] == 1) begin
                    if (server_load[0] <= server_load[1] && server_load[0] <= server_load[2]) begin
                        server_load[0] <= server_load[0] + 1;
                        server3_count <= server3_count + 1;
                    end
                    else if (server_load[1] <= server_load[0] && server_load[1] <= server_load[2]) begin
                        server_load[1] <= server_load[1] + 1;
                        server2_count <= server2_count + 1;
                    end
                    else begin
                        server_load[2] <= server_load[2] + 1;
                        server1_count <= server1_count + 1;
                    end
                end
            end
        end


        if (server1_count >= 4'b0011 || server2_count >= 4'b0011 || server3_count >= 4'b0011) begin
            trigger <= 1'b1;
        end 
        else begin
            trigger <= 1'b0;
        end


        if (server1_count >= 4'b0011 && server2_count >= 4'b0011 && server3_count >= 4'b0011) begin
            overload <= 1'b1;
        end 
        else begin
            overload <= 1'b0;
        end
    end
    endmodule
</details>

<details>

<summary>Test_bench</summary>


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

</details>

<details>

 <summary>verilog_output</summary>

 ![outputs](https://github.com/user-attachments/assets/d7570b58-e32a-4a2e-9241-f970a2bfe7e0)

  </details>

## References

<details>

  <summary>References</summary>
  [Cardellini et al., 1999] Cardellini, V., Colajanni, M., and Yu, P. S. (1999). Dynamic load balancing on
  web-server systems. IEEE Internet computing, 3(3):28–39.
  
</details>
<details>

  <summary>links</summary>
  
https://www.geeksforgeeks.org/load-balancing-algorithms/  
https://kemptechnologies.com/load-balancer/load-balancing-algorithms-techniques/  
https://www.cloudflare.com/learning/performance/types-of-load-balancing-algorithms/  
  
  </details>
