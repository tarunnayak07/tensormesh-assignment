module scc(clk,reset,dw,de,ds,dn,green,yellow,cs,cn,cw,ce,gcount);
input [1:0]dw,de,dn,ds;
input clk,reset;
output reg [2:0]cw,ce,cn,cs;
reg [2:0]state,nstate;
output reg[3:0]gcount;
output reg [3:0]green,yellow; 

function [2:0]count;
input [2:0]c;
begin
count =c+1;
end
endfunction

always@(posedge clk)begin
    if(reset)begin
    green=0;
    yellow=0;
    state=0;
    cw=0;ce=0;cs=0;cn=0;
    gcount=0;
end
else begin 
    if(gcount==0) begin state<=nstate;
     case(nstate)
     1:begin gcount<=2*dw+4;cw=0;if(de)ce= count(ce);if(ds)cs= count(cs);if(dn) cn=count(cn);  end
     2:begin gcount<=2*de+4;ce=0;if(dw)cw= count(cw);if(ds)cs= count(cs);if(dn)cn= count(cn);  end
     3:begin gcount<=2*ds+4;cs=0;if(de) ce=count(ce);if(dw) cw=count(cw);if(dn) cn=count(cn);  end
     4:begin gcount<=2*dn+4;cn=0;if(de) ce=count(ce);if(ds)cs= count(cs);if(dw)cw= count(cw);  end
     default:gcount<=0;
     endcase
    end
    else gcount<=gcount-1;
    end
end
always@(*)begin
    case(state)
    0:begin yellow=0;green=0; end
    1:begin green=8; yellow=15-green;end
    2:begin green=4; yellow=15-green;end
    3:begin green=2; yellow=15-green;end
    4:begin green=1; yellow=15-green;end
    endcase
end
always@(*)begin
  if(cw==5||ce==5||cn==5||cs==5)begin
    if(cw==5) nstate=1;
    else if(ce==5) nstate=2;
    else if(cs==5) nstate=3;
    else if(cn==5) nstate=4;
 end
 else  if(cw==4||ce==4||cn==4||cs==4)begin
    if(cw==4) nstate=1;
    else if(ce==4) nstate=2;
    else if(cs==4) nstate=3;
    else if(cn==4) nstate=4;
 end
  else if(cw==3||ce==3||cn==3||cs==3)begin
    if(cw==3) nstate=1;
    else if(ce==3) nstate=2;
    else if(cs==3) nstate=3;
    else if(cn==3) nstate=4;
  end

 else begin
  if(dw==3||de==3||dn==3||ds==3)begin

  case(state)
    0:begin if(dw==3) nstate=1;else if(de==3) nstate=2; else if(ds==3) nstate=3; else if(dn==3) nstate=4; end
    1:begin if(de==3) nstate=2;else if(ds==3) nstate=3; else if(dn==3) nstate=4; else if(dw==3) nstate=1; end
    2:begin if(ds==3) nstate=3;else if(dn==3) nstate=4; else if(dw==3) nstate=1; else if(de==3) nstate=2; end
    3:begin if(dn==3) nstate=4;else if(dw==3) nstate=1; else if(de==3) nstate=2; else if(ds==3) nstate=3; end
    4:begin if(dw==3) nstate=1;else if(de==3) nstate=2; else if(ds==3) nstate=3; else if(dn==3) nstate=4; end
  endcase
    end
    else if(dw==2||de==2||dn==2||ds==2) begin
      case(state)
    0:begin if(dw==2) nstate=1;else if(de==2) nstate=2; else if(ds==2) nstate=3; else if(dn==2) nstate=4; end
    1:begin if(de==2) nstate=2;else if(ds==2) nstate=3; else if(dn==2) nstate=4; else if(dw==2) nstate=1; end
    2:begin if(ds==2) nstate=3;else if(dn==2) nstate=4; else if(dw==2) nstate=1; else if(de==2) nstate=2; end
    3:begin if(dn==2) nstate=4;else if(dw==2) nstate=1; else if(de==2) nstate=2; else if(ds==2) nstate=3; end
    4:begin if(dw==2) nstate=1;else if(de==2) nstate=2; else if(ds==2) nstate=3; else if(dn==2) nstate=4; end
  endcase
    end
 else if(dw==1||de==1||dn==1||ds==1)begin
  case(state)
    0:begin if(dw==1) nstate=1;else if(de==1) nstate=2; else if(ds==1) nstate=3; else if(dn==1) nstate=4; end
    1:begin if(de==1) nstate=2;else if(ds==1) nstate=3; else if(dn==1) nstate=4; else if(dw==1) nstate=1; end
    2:begin if(ds==1) nstate=3;else if(dn==1) nstate=4; else if(dw==1) nstate=1; else if(de==1) nstate=2; end
    3:begin if(dn==1) nstate=4;else if(dw==1) nstate=1; else if(de==1) nstate=2; else if(ds==1) nstate=3; end
    4:begin if(dw==1) nstate=1;else if(de==1) nstate=2; else if(ds==1) nstate=3; else if(dn==1) nstate=4; end
  endcase
 end

else begin
    if(state==1) nstate=2;
    else if(state==2) nstate=3;
    else if(state==3) nstate=4;
    else if(state==4) nstate=1;
end
 end
end
endmodule