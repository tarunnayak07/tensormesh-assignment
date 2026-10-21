module skid(in,out,ivalid,ovalid,oready,iready,clk,reset,main,skid);
input clk,reset,iready,ivalid;
input [31:0]in;
output reg[31:0]main,skid,out;
output reg ovalid,oready;
reg [1:0]state;
always@(posedge clk or negedge reset)begin
    if(~reset) begin
        skid<=0;
        main<=0;
        state<=0;
        ovalid<=0;
        oready<=1;
    end
else if(state==0 && ivalid)begin
main<=in;
state<=1;
end
else if((state==1) && ~iready && ivalid )begin //skid protocol
    skid<=in;
    state<=2;
end
else if((state==1) && iready && ivalid)begin // normal transfer
    out<=main;
    main<=in;
end
else if((state==1) && iready && ~ivalid)begin // goes to state 0
    out<=main;
    main<=0;
    state<=0;
end

else if((state==2) && iready)begin // restart 
    state<=1;
    out<=main;
    main<=skid;
    skid<=0;
end
end
always@(*) begin
    case (state)
    0:begin ovalid=0;oready=1; end //both empty
    1:begin ovalid=1;oready=1; end //main filled
    2:begin ovalid=1;oready=0; end// both filled
    endcase
end
endmodule