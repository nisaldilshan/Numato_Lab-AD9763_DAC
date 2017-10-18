`timescale 1ns / 1ps

module Main(
         clk,                 
         rst_n,               
         sel_n,               
			LED,					
         // Interface with AD9763 DAC Expansion Module
         dac_clk1,
         dac_clk2,
         dac_wrt1,
         dac_wrt2,
         dac_c1,
         dac_c2
    );
	 
input clk,rst_n;
input [3:0] sel_n;
output reg [3:0] LED;
output dac_clk1,dac_clk2,dac_wrt1,dac_wrt2;
output reg [9:0] dac_c1,dac_c2;

reg [4:0] address  = 5'b0;

reg [9:0] halfsine [0:31];
reg [9:0] sine [0:31];
reg [9:0] fsine [0:31];

assign dac_wrt1 =  clk;
assign dac_wrt2 =  clk;
assign dac_clk1 =  clk;
assign dac_clk2 =  clk;

initial begin
    halfsine[0] = 0;
	 halfsine[1] = 64;
    halfsine[2] = 128;
	 halfsine[3] = 188;
    halfsine[4] = 248;
	 halfsine[5] = 304;
    halfsine[6] = 360;
	 halfsine[7] = 412;
    halfsine[8] = 464;
	 halfsine[9] = 500;
    halfsine[10] = 536;
	 halfsine[11] = 564;
    halfsine[12] = 592;
	 halfsine[13] = 604;
    halfsine[14] = 616;
	 halfsine[15] = 624;
	 halfsine[16] = 632;
	 halfsine[17] = 624;
    halfsine[18] = 616;
	 halfsine[19] = 604;
    halfsine[20] = 592;
	 halfsine[21] = 564;
    halfsine[22] = 536;
	 halfsine[23] = 500;
    halfsine[24] = 464;
	 halfsine[25] = 412;
    halfsine[26] = 360;
	 halfsine[27] = 304;
    halfsine[28] = 248;
	 halfsine[29] = 188;
    halfsine[30] = 128;
	 halfsine[31] = 64;
	 
	 sine[0] = 0;
    sine[1] = 64;
    sine[2] = 128;
    sine[3] = 192;
    sine[4] = 256;
    sine[5] = 320;
    sine[6] = 384;
    sine[7] = 448;
	 sine[8] = 512;
    sine[9] = 576;
    sine[10] = 640;
    sine[11] = 704;
    sine[12] = 768;
    sine[13] = 832;
    sine[14] = 896;
    sine[15] = 960;
	 sine[16] = 1023;
    sine[17] = 960;
    sine[18] = 896;
    sine[19] = 832;
    sine[20] = 768;
    sine[21] = 704;
    sine[22] = 640;
    sine[23] = 576;
	 sine[24] = 512;
    sine[25] = 448;
    sine[26] = 384;
    sine[27] = 320;
    sine[28] = 256;
    sine[29] = 192;
    sine[30] = 128;
    sine[31] = 64;
	 
	 fsine[0] = 474;
    fsine[1] = 570;
    fsine[2] = 660;
    fsine[3] = 744;
    fsine[4] = 822;
    fsine[5] = 876;
    fsine[6] = 918;
    fsine[7] = 936;
	 fsine[8] = 948;
    fsine[9] = 936;
    fsine[10] = 918;
    fsine[11] = 876;
    fsine[12] = 822;
    fsine[13] = 744;
    fsine[14] = 660;
    fsine[15] = 570;
	 fsine[16] = 474;
    fsine[17] = 378;
    fsine[18] = 288;
    fsine[19] = 204;
    fsine[20] = 126;
    fsine[21] = 72;
    fsine[22] = 30;
    fsine[23] = 12;
	 fsine[24] = 0;
    fsine[25] = 12;
    fsine[26] = 30;
    fsine[27] = 72;
    fsine[28] = 126;
    fsine[29] = 204;
    fsine[30] = 288;
    fsine[31] = 378;
end 

always@(negedge clk or negedge rst_n)
begin
	if(rst_n == 1'b0)
	begin
		address   <= 4'b0;
      dac_c1    <= 10'b0;
      dac_c2    <= 10'b0; 
	end

	else
	begin 
		case(sel_n)
			4'b1110: begin
				dac_c1<=halfsine[address];
				dac_c2<=halfsine[address];
				address <= address+1;
				LED <= 4'b1110;
				end
			4'b1101: begin
				dac_c1<=sine[address];
				dac_c2<=sine[address];
				address <= address+1;
				LED <= 4'b1101;
				end
			4'b1011: begin
				dac_c1<=halfsine[address];
				dac_c2<=halfsine[address];
				address <= address+1;
				LED <= 4'b1011;
				end
			default: begin
				dac_c1<=fsine[address];
				dac_c2<=fsine[address];
				address <= address+1;
				LED <= 4'b0111;
				end
		endcase
	end
end


endmodule
