 module pcounter(clk,rst,start,stop,state,count);
 input clk,rst,start,stop;
 output reg [1:0]state;
 output reg [3:0]count;
 reg [1:0]nstate;
 //idle=0 active=1 done=3
 initial
 state = 2'b00;
 //state register
 always@(posedge clk)begin
    if(rst) begin
    state<=0;
    count<=0;
    end
  else state<=nstate ;
 end

 
 //state transition
 always@(*) begin
    case(state)
    0: if(start && ~stop ) begin nstate=1;end else nstate=0;  //idle
    1:if(stop) nstate=3; //active
    3:nstate=0; //done
    endcase
 end
 //counter
 always@(posedge clk)begin
   if(count==0 && nstate==1) count=2;
 else if(state==1 && stop==0) begin
        case(count)
        2: count=3;
        3:count=5;
        5:count=7;
        7:count=11;
        11:count=13;
        13:count=2;
        endcase
    end
 end 
    
 endmodule