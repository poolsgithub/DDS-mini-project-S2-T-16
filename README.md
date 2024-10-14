# DYNAMIC LOAD BALANCING IN COMPUTING

<!-- First Section -->
## Team Details
<details> 
  <summary>Detail</summary>

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
  <summary>Detail</summary>
  
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
  <summary>Detail</summary>  


![dds](https://github.com/user-attachments/assets/120739ab-7096-4d4e-b12c-97c9306b10cf)

</details>

## Working

<details>

<summary>Detail</summary>

### working

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
 server3_least=(server3_count<server1_count)(server3_count<server2_count)
 (e) 4-bit comparator Truth Table
 ##### 4-Bit Counter:
 • Function:
 Increments a 4-bit count on each clock cycle.
 • Working:
 When a clock is at positive edge then the counter increases by one unit
 • Server Count Update:
 
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

### functional table

### flowchart


![flowchart](https://github.com/user-attachments/assets/cf6bb252-001f-4627-a021-8c0b6b446b7e)


</details>


## Logisim Circuit Diagram

<details>

<summary>Detail</summary>

![Main ](https://github.com/user-attachments/assets/25d033cf-1b90-44fc-a4ac-de58e834eb1c)

![8-Input flip flop ](https://github.com/user-attachments/assets/ca8849b2-f49e-4251-802b-7bdd85dd3bb5)

![3-Input 4-bit comparator ](https://github.com/user-attachments/assets/28bf059e-dcfb-48a0-a1cf-7f78662a216f)


  
</details>

## Verilog Code

<details>

<summary>Detail</summary>
  
### Test bench File

</details>

## References
<details>

  <summary>Detail</summary>
  
</details>
