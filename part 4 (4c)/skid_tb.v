`timescale 1ns/1ps
module skid_tb;
reg clk,reset,iready,ivalid;
reg [31:0]in;
wire [31:0]main,skid,out;
wire ovalid,oready;
skid uut(.clk(clk),.reset(reset),.ivalid(ivalid),.iready(iready),.in(in),.main(main),.skid(skid),.out(out),.ovalid(ovalid),.oready(oready));
wire o_ready ;
assign o_ready = iready | ~ovalid; //diferent oready check as mentioned in pdf
always #5 clk=~clk;

initial begin
         $dumpfile("skidi.vcd"); // Name of the file you want to create
    $dumpvars(0, skid_tb);
    clk=0;
    in=1;
    reset=1;
    iready=1;
    ivalid=1;
    #1;reset=0;
    #1;reset=1;
    #100; iready=1;ivalid=1;
    #50 ;iready=0;ivalid=1; //skid
    #30; iready=1;ivalid=0;
    #20;iready=1;ivalid=1;
    #100; $finish;
end
always@(posedge clk) begin
if(ivalid==1) in=in+1;
end
endmodule