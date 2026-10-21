`timescale 1ns/1ps
module scc_tb;
reg [1:0]dw,de,dn,ds;
reg clk,reset;
wire [2:0]cw,ce,cn,cs;
wire[3:0]gcount;
wire [3:0]green,yellow;
scc uut ( .ds(ds),.dn(dn),.dw(dw),.de(de),.clk(clk),.reset(reset),.cn(cn),
.cs(cs),.cw(cw),.ce(ce),.gcount(gcount),.green(green),.yellow(yellow));
always #5 clk=~clk;
initial begin
    $dumpfile("traffic.vcd"); 
        $dumpvars(0, scc_tb);
    clk=0;
    reset=1;
    dw=0;de=0;ds=0;dn=0;
    #6 ;reset=0;
    #3; dw=2;de=2;ds=2;dn=2;  // 1
    #600;
     dw=1;de=1;ds=1;dn=3;  // 2 
     #600;$finish;



end
endmodule
