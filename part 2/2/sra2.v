module sra2(clk,reset,reqA,reqB,dataA,dataB,grantA,grantB,data,out_valid);
input reqA,reqB,clk,reset;
input [7:0]dataA,dataB;
output reg grantA,grantB,out_valid;
output reg [7:0]data;
reg [1:0]state,nstate;
always@(posedge clk) begin
    if(reset)begin
        out_valid=0;
        grantA=0;
        grantB=0;
        state=3;
    end
    else begin
        out_valid <= (grantA || grantB);
        state<=nstate;
    end
end
always@(*)begin
        case(state)
        0: begin data=dataA ; grantA=1; grantB=0 ;  //A state
         if(reqB) nstate=1;
         else if(reqA==0 && reqB==0) nstate=3;
          end
        1:begin data=dataB ; grantB=1;grantA=0;    //Bstate
         if(reqA) nstate=0; 
          else if(reqA==0 && reqB==0) nstate=3;
         end   
        3:begin data=0;grantA=0;grantB=0; if(reqA) nstate=0; else if(reqB) nstate=1;end   //none state
        endcase
    end
endmodule


