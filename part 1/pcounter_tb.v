`timescale 1ns/1ps

module tb_pcounter();
    reg clk;
    reg rst;
    reg start;
    reg stop;
    wire [1:0] state;
    wire [3:0] count;

    pcounter uut (.clk(clk),.rst(rst),.start(start),.stop(stop),.state(state), .count(count));
    always #5 clk = ~clk;
    always @(posedge clk) begin
        if (state == 2'b01) begin // ACTIVE state
            if (!(count == 4'd2  || count == 4'd3  || 
                  count == 4'd5  || count == 4'd7  || 
                  count == 4'd11 || count == 4'd13)) begin
                $display("FAIL: Invalid count value %0d while ACTIVE at time %0t ns", count, $time);
                $finish;
            end
        end
    end
    initial begin
       $dumpfile("epic.vcd");
    $dumpvars(0, tb_pcounter);
        // Initialize inputs
        clk = 0;
        rst = 1;
        start = 0;
        stop = 0;
        #12;
        rst = 0;
        #15;
        start = 1;
        #12;
        #10; if (count !== 4'd3)  begin $display("FAIL"); $finish; end
        #10; if (count !== 4'd5)  begin $display("FAIL"); $finish; end
        #10; if (count !== 4'd7)  begin $display("FAIL"); $finish; end
        #10; if (count !== 4'd11) begin $display("FAIL"); $finish; end
        #10; if (count !== 4'd13) begin $display("FAIL"); $finish; end
        #10; if (count !== 4'd2)  begin $display("FAIL"); $finish; end
        $display("PASS: Full prime sequence and wrap-around from 13 to 2 verified.");

   
        stop = 1;
        #10; 
        #2;
        stop = 0; 
        #12;
        #10; 
        start = 1;
        #12;$finish;
   
    end
endmodule