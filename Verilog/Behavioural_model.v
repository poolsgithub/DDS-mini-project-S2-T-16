module load_balancer (
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
