module sra2_tb;
reg reqA,reqB,clk,reset;
reg [7:0]dataA,dataB;
wire grantA,grantB,out_valid;
wire [7:0]data;
sra2 uut(.reqA(reqA),.reqB(reqB),.clk(clk),.reset(reset),.dataA(dataA),.dataB(dataB),.grantA(grantA),.grantB(grantB),.out_valid(out_valid),.data(data));
always #5 clk=~clk;
always@(posedge clk)begin
      if(grantA==1 && grantB==1) $finish;
      else if (grantA==1 && data!=dataA) $finish;
      else if (grantB==1 && data!=dataB) $finish;
end
initial begin
     $dumpfile("nice2.vcd"); // Name of the file you want to create
    $dumpvars(0, sra2_tb);
    dataA=10;
    dataB=11;
    clk=0;
   #1 reset=1;
   #6 reset<=0;reqA<=1;reqB<=0;
    #16 reset<=0;reqA<=0;reqB<=1;
     #26 reset<=0;reqA<=1;reqB<=1;
      #126reset<=0;reqA<=0;reqB<=0;
      #186reset<=0;reqA<=1;reqB<=0;
      #196reset<=0;reqA<=0;reqB<=1;
      #226  $display("test at all points passed");$finish;
end
endmodule
