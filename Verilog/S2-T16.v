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


//Behavioural Model

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
