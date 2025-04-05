//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//Tool Version: V1.9.10.03 (64-bit)
//Part Number: GW2AR-LV18QN88C8/I7
//Device: GW2AR-18
//Device Version: C
//Created Time: Mon Dec  9 18:31:54 2024

module t20k_vmemDP (douta, doutb, clka, ocea, cea, reseta, wrea, clkb, oceb, ceb, resetb, wreb, ada, dina, adb, dinb);

output [10:0] douta;
output [10:0] doutb;
input clka;
input ocea;
input cea;
input reseta;
input wrea;
input clkb;
input oceb;
input ceb;
input resetb;
input wreb;
input [13:0] ada;
input [10:0] dina;
input [13:0] adb;
input [10:0] dinb;

wire [8:0] dpx9b_inst_0_douta_w;
wire [8:0] dpx9b_inst_0_douta;
wire [8:0] dpx9b_inst_0_doutb_w;
wire [8:0] dpx9b_inst_0_doutb;
wire [8:0] dpx9b_inst_1_douta_w;
wire [8:0] dpx9b_inst_1_douta;
wire [8:0] dpx9b_inst_1_doutb_w;
wire [8:0] dpx9b_inst_1_doutb;
wire [8:0] dpx9b_inst_2_douta_w;
wire [8:0] dpx9b_inst_2_douta;
wire [8:0] dpx9b_inst_2_doutb_w;
wire [8:0] dpx9b_inst_2_doutb;
wire [8:0] dpx9b_inst_3_douta_w;
wire [8:0] dpx9b_inst_3_douta;
wire [8:0] dpx9b_inst_3_doutb_w;
wire [8:0] dpx9b_inst_3_doutb;
wire [8:0] dpx9b_inst_4_douta_w;
wire [8:0] dpx9b_inst_4_douta;
wire [8:0] dpx9b_inst_4_doutb_w;
wire [8:0] dpx9b_inst_4_doutb;
wire [8:0] dpx9b_inst_5_douta_w;
wire [8:0] dpx9b_inst_5_douta;
wire [8:0] dpx9b_inst_5_doutb_w;
wire [8:0] dpx9b_inst_5_doutb;
wire [8:0] dpx9b_inst_6_douta_w;
wire [8:0] dpx9b_inst_6_douta;
wire [8:0] dpx9b_inst_6_doutb_w;
wire [8:0] dpx9b_inst_6_doutb;
wire [8:0] dpx9b_inst_7_douta_w;
wire [8:0] dpx9b_inst_7_douta;
wire [8:0] dpx9b_inst_7_doutb_w;
wire [8:0] dpx9b_inst_7_doutb;
wire [14:0] dpb_inst_8_douta_w;
wire [14:0] dpb_inst_8_doutb_w;
wire [14:0] dpb_inst_9_douta_w;
wire [14:0] dpb_inst_9_doutb_w;
wire dff_q_0;
wire dff_q_1;
wire dff_q_2;
wire dff_q_3;
wire dff_q_4;
wire dff_q_5;
wire mux_o_0;
wire mux_o_1;
wire mux_o_2;
wire mux_o_3;
wire mux_o_4;
wire mux_o_5;
wire mux_o_7;
wire mux_o_8;
wire mux_o_9;
wire mux_o_10;
wire mux_o_11;
wire mux_o_12;
wire mux_o_14;
wire mux_o_15;
wire mux_o_16;
wire mux_o_17;
wire mux_o_18;
wire mux_o_19;
wire mux_o_21;
wire mux_o_22;
wire mux_o_23;
wire mux_o_24;
wire mux_o_25;
wire mux_o_26;
wire mux_o_28;
wire mux_o_29;
wire mux_o_30;
wire mux_o_31;
wire mux_o_32;
wire mux_o_33;
wire mux_o_35;
wire mux_o_36;
wire mux_o_37;
wire mux_o_38;
wire mux_o_39;
wire mux_o_40;
wire mux_o_42;
wire mux_o_43;
wire mux_o_44;
wire mux_o_45;
wire mux_o_46;
wire mux_o_47;
wire mux_o_49;
wire mux_o_50;
wire mux_o_51;
wire mux_o_52;
wire mux_o_53;
wire mux_o_54;
wire mux_o_56;
wire mux_o_57;
wire mux_o_58;
wire mux_o_59;
wire mux_o_60;
wire mux_o_61;
wire mux_o_63;
wire mux_o_64;
wire mux_o_65;
wire mux_o_66;
wire mux_o_67;
wire mux_o_68;
wire mux_o_70;
wire mux_o_71;
wire mux_o_72;
wire mux_o_73;
wire mux_o_74;
wire mux_o_75;
wire mux_o_77;
wire mux_o_78;
wire mux_o_79;
wire mux_o_80;
wire mux_o_81;
wire mux_o_82;
wire mux_o_84;
wire mux_o_85;
wire mux_o_86;
wire mux_o_87;
wire mux_o_88;
wire mux_o_89;
wire mux_o_91;
wire mux_o_92;
wire mux_o_93;
wire mux_o_94;
wire mux_o_95;
wire mux_o_96;
wire mux_o_98;
wire mux_o_99;
wire mux_o_100;
wire mux_o_101;
wire mux_o_102;
wire mux_o_103;
wire mux_o_105;
wire mux_o_106;
wire mux_o_107;
wire mux_o_108;
wire mux_o_109;
wire mux_o_110;
wire mux_o_112;
wire mux_o_113;
wire mux_o_114;
wire mux_o_115;
wire mux_o_116;
wire mux_o_117;
wire mux_o_119;
wire mux_o_120;
wire mux_o_121;
wire mux_o_122;
wire mux_o_123;
wire mux_o_124;
wire cea_w;
wire ceb_w;
wire gw_gnd;

assign cea_w = ~wrea & cea;
assign ceb_w = ~wreb & ceb;
assign gw_gnd = 1'b0;

DPX9B dpx9b_inst_0 (
    .DOA({dpx9b_inst_0_douta_w[8:0],dpx9b_inst_0_douta[8:0]}),
    .DOB({dpx9b_inst_0_doutb_w[8:0],dpx9b_inst_0_doutb[8:0]}),
    .CLKA(clka),
    .OCEA(ocea),
    .CEA(cea),
    .RESETA(reseta),
    .WREA(wrea),
    .CLKB(clkb),
    .OCEB(oceb),
    .CEB(ceb),
    .RESETB(resetb),
    .WREB(wreb),
    .BLKSELA({ada[13],ada[12],ada[11]}),
    .BLKSELB({adb[13],adb[12],adb[11]}),
    .ADA({ada[10:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIA({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dina[8:0]}),
    .ADB({adb[10:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIB({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dinb[8:0]})
);

defparam dpx9b_inst_0.READ_MODE0 = 1'b0;
defparam dpx9b_inst_0.READ_MODE1 = 1'b0;
defparam dpx9b_inst_0.WRITE_MODE0 = 2'b00;
defparam dpx9b_inst_0.WRITE_MODE1 = 2'b00;
defparam dpx9b_inst_0.BIT_WIDTH_0 = 9;
defparam dpx9b_inst_0.BIT_WIDTH_1 = 9;
defparam dpx9b_inst_0.BLK_SEL_0 = 3'b000;
defparam dpx9b_inst_0.BLK_SEL_1 = 3'b000;
defparam dpx9b_inst_0.RESET_MODE = "SYNC";

DPX9B dpx9b_inst_1 (
    .DOA({dpx9b_inst_1_douta_w[8:0],dpx9b_inst_1_douta[8:0]}),
    .DOB({dpx9b_inst_1_doutb_w[8:0],dpx9b_inst_1_doutb[8:0]}),
    .CLKA(clka),
    .OCEA(ocea),
    .CEA(cea),
    .RESETA(reseta),
    .WREA(wrea),
    .CLKB(clkb),
    .OCEB(oceb),
    .CEB(ceb),
    .RESETB(resetb),
    .WREB(wreb),
    .BLKSELA({ada[13],ada[12],ada[11]}),
    .BLKSELB({adb[13],adb[12],adb[11]}),
    .ADA({ada[10:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIA({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dina[8:0]}),
    .ADB({adb[10:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIB({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dinb[8:0]})
);

defparam dpx9b_inst_1.READ_MODE0 = 1'b0;
defparam dpx9b_inst_1.READ_MODE1 = 1'b0;
defparam dpx9b_inst_1.WRITE_MODE0 = 2'b00;
defparam dpx9b_inst_1.WRITE_MODE1 = 2'b00;
defparam dpx9b_inst_1.BIT_WIDTH_0 = 9;
defparam dpx9b_inst_1.BIT_WIDTH_1 = 9;
defparam dpx9b_inst_1.BLK_SEL_0 = 3'b001;
defparam dpx9b_inst_1.BLK_SEL_1 = 3'b001;
defparam dpx9b_inst_1.RESET_MODE = "SYNC";

DPX9B dpx9b_inst_2 (
    .DOA({dpx9b_inst_2_douta_w[8:0],dpx9b_inst_2_douta[8:0]}),
    .DOB({dpx9b_inst_2_doutb_w[8:0],dpx9b_inst_2_doutb[8:0]}),
    .CLKA(clka),
    .OCEA(ocea),
    .CEA(cea),
    .RESETA(reseta),
    .WREA(wrea),
    .CLKB(clkb),
    .OCEB(oceb),
    .CEB(ceb),
    .RESETB(resetb),
    .WREB(wreb),
    .BLKSELA({ada[13],ada[12],ada[11]}),
    .BLKSELB({adb[13],adb[12],adb[11]}),
    .ADA({ada[10:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIA({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dina[8:0]}),
    .ADB({adb[10:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIB({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dinb[8:0]})
);

defparam dpx9b_inst_2.READ_MODE0 = 1'b0;
defparam dpx9b_inst_2.READ_MODE1 = 1'b0;
defparam dpx9b_inst_2.WRITE_MODE0 = 2'b00;
defparam dpx9b_inst_2.WRITE_MODE1 = 2'b00;
defparam dpx9b_inst_2.BIT_WIDTH_0 = 9;
defparam dpx9b_inst_2.BIT_WIDTH_1 = 9;
defparam dpx9b_inst_2.BLK_SEL_0 = 3'b010;
defparam dpx9b_inst_2.BLK_SEL_1 = 3'b010;
defparam dpx9b_inst_2.RESET_MODE = "SYNC";

DPX9B dpx9b_inst_3 (
    .DOA({dpx9b_inst_3_douta_w[8:0],dpx9b_inst_3_douta[8:0]}),
    .DOB({dpx9b_inst_3_doutb_w[8:0],dpx9b_inst_3_doutb[8:0]}),
    .CLKA(clka),
    .OCEA(ocea),
    .CEA(cea),
    .RESETA(reseta),
    .WREA(wrea),
    .CLKB(clkb),
    .OCEB(oceb),
    .CEB(ceb),
    .RESETB(resetb),
    .WREB(wreb),
    .BLKSELA({ada[13],ada[12],ada[11]}),
    .BLKSELB({adb[13],adb[12],adb[11]}),
    .ADA({ada[10:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIA({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dina[8:0]}),
    .ADB({adb[10:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIB({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dinb[8:0]})
);

defparam dpx9b_inst_3.READ_MODE0 = 1'b0;
defparam dpx9b_inst_3.READ_MODE1 = 1'b0;
defparam dpx9b_inst_3.WRITE_MODE0 = 2'b00;
defparam dpx9b_inst_3.WRITE_MODE1 = 2'b00;
defparam dpx9b_inst_3.BIT_WIDTH_0 = 9;
defparam dpx9b_inst_3.BIT_WIDTH_1 = 9;
defparam dpx9b_inst_3.BLK_SEL_0 = 3'b011;
defparam dpx9b_inst_3.BLK_SEL_1 = 3'b011;
defparam dpx9b_inst_3.RESET_MODE = "SYNC";

DPX9B dpx9b_inst_4 (
    .DOA({dpx9b_inst_4_douta_w[8:0],dpx9b_inst_4_douta[8:0]}),
    .DOB({dpx9b_inst_4_doutb_w[8:0],dpx9b_inst_4_doutb[8:0]}),
    .CLKA(clka),
    .OCEA(ocea),
    .CEA(cea),
    .RESETA(reseta),
    .WREA(wrea),
    .CLKB(clkb),
    .OCEB(oceb),
    .CEB(ceb),
    .RESETB(resetb),
    .WREB(wreb),
    .BLKSELA({ada[13],ada[12],ada[11]}),
    .BLKSELB({adb[13],adb[12],adb[11]}),
    .ADA({ada[10:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIA({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dina[8:0]}),
    .ADB({adb[10:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIB({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dinb[8:0]})
);

defparam dpx9b_inst_4.READ_MODE0 = 1'b0;
defparam dpx9b_inst_4.READ_MODE1 = 1'b0;
defparam dpx9b_inst_4.WRITE_MODE0 = 2'b00;
defparam dpx9b_inst_4.WRITE_MODE1 = 2'b00;
defparam dpx9b_inst_4.BIT_WIDTH_0 = 9;
defparam dpx9b_inst_4.BIT_WIDTH_1 = 9;
defparam dpx9b_inst_4.BLK_SEL_0 = 3'b100;
defparam dpx9b_inst_4.BLK_SEL_1 = 3'b100;
defparam dpx9b_inst_4.RESET_MODE = "SYNC";

DPX9B dpx9b_inst_5 (
    .DOA({dpx9b_inst_5_douta_w[8:0],dpx9b_inst_5_douta[8:0]}),
    .DOB({dpx9b_inst_5_doutb_w[8:0],dpx9b_inst_5_doutb[8:0]}),
    .CLKA(clka),
    .OCEA(ocea),
    .CEA(cea),
    .RESETA(reseta),
    .WREA(wrea),
    .CLKB(clkb),
    .OCEB(oceb),
    .CEB(ceb),
    .RESETB(resetb),
    .WREB(wreb),
    .BLKSELA({ada[13],ada[12],ada[11]}),
    .BLKSELB({adb[13],adb[12],adb[11]}),
    .ADA({ada[10:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIA({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dina[8:0]}),
    .ADB({adb[10:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIB({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dinb[8:0]})
);

defparam dpx9b_inst_5.READ_MODE0 = 1'b0;
defparam dpx9b_inst_5.READ_MODE1 = 1'b0;
defparam dpx9b_inst_5.WRITE_MODE0 = 2'b00;
defparam dpx9b_inst_5.WRITE_MODE1 = 2'b00;
defparam dpx9b_inst_5.BIT_WIDTH_0 = 9;
defparam dpx9b_inst_5.BIT_WIDTH_1 = 9;
defparam dpx9b_inst_5.BLK_SEL_0 = 3'b101;
defparam dpx9b_inst_5.BLK_SEL_1 = 3'b101;
defparam dpx9b_inst_5.RESET_MODE = "SYNC";

DPX9B dpx9b_inst_6 (
    .DOA({dpx9b_inst_6_douta_w[8:0],dpx9b_inst_6_douta[8:0]}),
    .DOB({dpx9b_inst_6_doutb_w[8:0],dpx9b_inst_6_doutb[8:0]}),
    .CLKA(clka),
    .OCEA(ocea),
    .CEA(cea),
    .RESETA(reseta),
    .WREA(wrea),
    .CLKB(clkb),
    .OCEB(oceb),
    .CEB(ceb),
    .RESETB(resetb),
    .WREB(wreb),
    .BLKSELA({ada[13],ada[12],ada[11]}),
    .BLKSELB({adb[13],adb[12],adb[11]}),
    .ADA({ada[10:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIA({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dina[8:0]}),
    .ADB({adb[10:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIB({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dinb[8:0]})
);

defparam dpx9b_inst_6.READ_MODE0 = 1'b0;
defparam dpx9b_inst_6.READ_MODE1 = 1'b0;
defparam dpx9b_inst_6.WRITE_MODE0 = 2'b00;
defparam dpx9b_inst_6.WRITE_MODE1 = 2'b00;
defparam dpx9b_inst_6.BIT_WIDTH_0 = 9;
defparam dpx9b_inst_6.BIT_WIDTH_1 = 9;
defparam dpx9b_inst_6.BLK_SEL_0 = 3'b110;
defparam dpx9b_inst_6.BLK_SEL_1 = 3'b110;
defparam dpx9b_inst_6.RESET_MODE = "SYNC";

DPX9B dpx9b_inst_7 (
    .DOA({dpx9b_inst_7_douta_w[8:0],dpx9b_inst_7_douta[8:0]}),
    .DOB({dpx9b_inst_7_doutb_w[8:0],dpx9b_inst_7_doutb[8:0]}),
    .CLKA(clka),
    .OCEA(ocea),
    .CEA(cea),
    .RESETA(reseta),
    .WREA(wrea),
    .CLKB(clkb),
    .OCEB(oceb),
    .CEB(ceb),
    .RESETB(resetb),
    .WREB(wreb),
    .BLKSELA({ada[13],ada[12],ada[11]}),
    .BLKSELB({adb[13],adb[12],adb[11]}),
    .ADA({ada[10:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIA({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dina[8:0]}),
    .ADB({adb[10:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIB({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dinb[8:0]})
);

defparam dpx9b_inst_7.READ_MODE0 = 1'b0;
defparam dpx9b_inst_7.READ_MODE1 = 1'b0;
defparam dpx9b_inst_7.WRITE_MODE0 = 2'b00;
defparam dpx9b_inst_7.WRITE_MODE1 = 2'b00;
defparam dpx9b_inst_7.BIT_WIDTH_0 = 9;
defparam dpx9b_inst_7.BIT_WIDTH_1 = 9;
defparam dpx9b_inst_7.BLK_SEL_0 = 3'b111;
defparam dpx9b_inst_7.BLK_SEL_1 = 3'b111;
defparam dpx9b_inst_7.RESET_MODE = "SYNC";

DPB dpb_inst_8 (
    .DOA({dpb_inst_8_douta_w[14:0],douta[9]}),
    .DOB({dpb_inst_8_doutb_w[14:0],doutb[9]}),
    .CLKA(clka),
    .OCEA(ocea),
    .CEA(cea),
    .RESETA(reseta),
    .WREA(wrea),
    .CLKB(clkb),
    .OCEB(oceb),
    .CEB(ceb),
    .RESETB(resetb),
    .WREB(wreb),
    .BLKSELA({gw_gnd,gw_gnd,gw_gnd}),
    .BLKSELB({gw_gnd,gw_gnd,gw_gnd}),
    .ADA(ada[13:0]),
    .DIA({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dina[9]}),
    .ADB(adb[13:0]),
    .DIB({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dinb[9]})
);

defparam dpb_inst_8.READ_MODE0 = 1'b0;
defparam dpb_inst_8.READ_MODE1 = 1'b0;
defparam dpb_inst_8.WRITE_MODE0 = 2'b00;
defparam dpb_inst_8.WRITE_MODE1 = 2'b00;
defparam dpb_inst_8.BIT_WIDTH_0 = 1;
defparam dpb_inst_8.BIT_WIDTH_1 = 1;
defparam dpb_inst_8.BLK_SEL_0 = 3'b000;
defparam dpb_inst_8.BLK_SEL_1 = 3'b000;
defparam dpb_inst_8.RESET_MODE = "SYNC";

DPB dpb_inst_9 (
    .DOA({dpb_inst_9_douta_w[14:0],douta[10]}),
    .DOB({dpb_inst_9_doutb_w[14:0],doutb[10]}),
    .CLKA(clka),
    .OCEA(ocea),
    .CEA(cea),
    .RESETA(reseta),
    .WREA(wrea),
    .CLKB(clkb),
    .OCEB(oceb),
    .CEB(ceb),
    .RESETB(resetb),
    .WREB(wreb),
    .BLKSELA({gw_gnd,gw_gnd,gw_gnd}),
    .BLKSELB({gw_gnd,gw_gnd,gw_gnd}),
    .ADA(ada[13:0]),
    .DIA({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dina[10]}),
    .ADB(adb[13:0]),
    .DIB({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,dinb[10]})
);

defparam dpb_inst_9.READ_MODE0 = 1'b0;
defparam dpb_inst_9.READ_MODE1 = 1'b0;
defparam dpb_inst_9.WRITE_MODE0 = 2'b00;
defparam dpb_inst_9.WRITE_MODE1 = 2'b00;
defparam dpb_inst_9.BIT_WIDTH_0 = 1;
defparam dpb_inst_9.BIT_WIDTH_1 = 1;
defparam dpb_inst_9.BLK_SEL_0 = 3'b000;
defparam dpb_inst_9.BLK_SEL_1 = 3'b000;
defparam dpb_inst_9.RESET_MODE = "SYNC";

DFFE dff_inst_0 (
  .Q(dff_q_0),
  .D(ada[13]),
  .CLK(clka),
  .CE(cea_w)
);
DFFE dff_inst_1 (
  .Q(dff_q_1),
  .D(ada[12]),
  .CLK(clka),
  .CE(cea_w)
);
DFFE dff_inst_2 (
  .Q(dff_q_2),
  .D(ada[11]),
  .CLK(clka),
  .CE(cea_w)
);
DFFE dff_inst_3 (
  .Q(dff_q_3),
  .D(adb[13]),
  .CLK(clkb),
  .CE(ceb_w)
);
DFFE dff_inst_4 (
  .Q(dff_q_4),
  .D(adb[12]),
  .CLK(clkb),
  .CE(ceb_w)
);
DFFE dff_inst_5 (
  .Q(dff_q_5),
  .D(adb[11]),
  .CLK(clkb),
  .CE(ceb_w)
);
MUX2 mux_inst_0 (
  .O(mux_o_0),
  .I0(dpx9b_inst_0_douta[0]),
  .I1(dpx9b_inst_1_douta[0]),
  .S0(dff_q_2)
);
MUX2 mux_inst_1 (
  .O(mux_o_1),
  .I0(dpx9b_inst_2_douta[0]),
  .I1(dpx9b_inst_3_douta[0]),
  .S0(dff_q_2)
);
MUX2 mux_inst_2 (
  .O(mux_o_2),
  .I0(dpx9b_inst_4_douta[0]),
  .I1(dpx9b_inst_5_douta[0]),
  .S0(dff_q_2)
);
MUX2 mux_inst_3 (
  .O(mux_o_3),
  .I0(dpx9b_inst_6_douta[0]),
  .I1(dpx9b_inst_7_douta[0]),
  .S0(dff_q_2)
);
MUX2 mux_inst_4 (
  .O(mux_o_4),
  .I0(mux_o_0),
  .I1(mux_o_1),
  .S0(dff_q_1)
);
MUX2 mux_inst_5 (
  .O(mux_o_5),
  .I0(mux_o_2),
  .I1(mux_o_3),
  .S0(dff_q_1)
);
MUX2 mux_inst_6 (
  .O(douta[0]),
  .I0(mux_o_4),
  .I1(mux_o_5),
  .S0(dff_q_0)
);
MUX2 mux_inst_7 (
  .O(mux_o_7),
  .I0(dpx9b_inst_0_douta[1]),
  .I1(dpx9b_inst_1_douta[1]),
  .S0(dff_q_2)
);
MUX2 mux_inst_8 (
  .O(mux_o_8),
  .I0(dpx9b_inst_2_douta[1]),
  .I1(dpx9b_inst_3_douta[1]),
  .S0(dff_q_2)
);
MUX2 mux_inst_9 (
  .O(mux_o_9),
  .I0(dpx9b_inst_4_douta[1]),
  .I1(dpx9b_inst_5_douta[1]),
  .S0(dff_q_2)
);
MUX2 mux_inst_10 (
  .O(mux_o_10),
  .I0(dpx9b_inst_6_douta[1]),
  .I1(dpx9b_inst_7_douta[1]),
  .S0(dff_q_2)
);
MUX2 mux_inst_11 (
  .O(mux_o_11),
  .I0(mux_o_7),
  .I1(mux_o_8),
  .S0(dff_q_1)
);
MUX2 mux_inst_12 (
  .O(mux_o_12),
  .I0(mux_o_9),
  .I1(mux_o_10),
  .S0(dff_q_1)
);
MUX2 mux_inst_13 (
  .O(douta[1]),
  .I0(mux_o_11),
  .I1(mux_o_12),
  .S0(dff_q_0)
);
MUX2 mux_inst_14 (
  .O(mux_o_14),
  .I0(dpx9b_inst_0_douta[2]),
  .I1(dpx9b_inst_1_douta[2]),
  .S0(dff_q_2)
);
MUX2 mux_inst_15 (
  .O(mux_o_15),
  .I0(dpx9b_inst_2_douta[2]),
  .I1(dpx9b_inst_3_douta[2]),
  .S0(dff_q_2)
);
MUX2 mux_inst_16 (
  .O(mux_o_16),
  .I0(dpx9b_inst_4_douta[2]),
  .I1(dpx9b_inst_5_douta[2]),
  .S0(dff_q_2)
);
MUX2 mux_inst_17 (
  .O(mux_o_17),
  .I0(dpx9b_inst_6_douta[2]),
  .I1(dpx9b_inst_7_douta[2]),
  .S0(dff_q_2)
);
MUX2 mux_inst_18 (
  .O(mux_o_18),
  .I0(mux_o_14),
  .I1(mux_o_15),
  .S0(dff_q_1)
);
MUX2 mux_inst_19 (
  .O(mux_o_19),
  .I0(mux_o_16),
  .I1(mux_o_17),
  .S0(dff_q_1)
);
MUX2 mux_inst_20 (
  .O(douta[2]),
  .I0(mux_o_18),
  .I1(mux_o_19),
  .S0(dff_q_0)
);
MUX2 mux_inst_21 (
  .O(mux_o_21),
  .I0(dpx9b_inst_0_douta[3]),
  .I1(dpx9b_inst_1_douta[3]),
  .S0(dff_q_2)
);
MUX2 mux_inst_22 (
  .O(mux_o_22),
  .I0(dpx9b_inst_2_douta[3]),
  .I1(dpx9b_inst_3_douta[3]),
  .S0(dff_q_2)
);
MUX2 mux_inst_23 (
  .O(mux_o_23),
  .I0(dpx9b_inst_4_douta[3]),
  .I1(dpx9b_inst_5_douta[3]),
  .S0(dff_q_2)
);
MUX2 mux_inst_24 (
  .O(mux_o_24),
  .I0(dpx9b_inst_6_douta[3]),
  .I1(dpx9b_inst_7_douta[3]),
  .S0(dff_q_2)
);
MUX2 mux_inst_25 (
  .O(mux_o_25),
  .I0(mux_o_21),
  .I1(mux_o_22),
  .S0(dff_q_1)
);
MUX2 mux_inst_26 (
  .O(mux_o_26),
  .I0(mux_o_23),
  .I1(mux_o_24),
  .S0(dff_q_1)
);
MUX2 mux_inst_27 (
  .O(douta[3]),
  .I0(mux_o_25),
  .I1(mux_o_26),
  .S0(dff_q_0)
);
MUX2 mux_inst_28 (
  .O(mux_o_28),
  .I0(dpx9b_inst_0_douta[4]),
  .I1(dpx9b_inst_1_douta[4]),
  .S0(dff_q_2)
);
MUX2 mux_inst_29 (
  .O(mux_o_29),
  .I0(dpx9b_inst_2_douta[4]),
  .I1(dpx9b_inst_3_douta[4]),
  .S0(dff_q_2)
);
MUX2 mux_inst_30 (
  .O(mux_o_30),
  .I0(dpx9b_inst_4_douta[4]),
  .I1(dpx9b_inst_5_douta[4]),
  .S0(dff_q_2)
);
MUX2 mux_inst_31 (
  .O(mux_o_31),
  .I0(dpx9b_inst_6_douta[4]),
  .I1(dpx9b_inst_7_douta[4]),
  .S0(dff_q_2)
);
MUX2 mux_inst_32 (
  .O(mux_o_32),
  .I0(mux_o_28),
  .I1(mux_o_29),
  .S0(dff_q_1)
);
MUX2 mux_inst_33 (
  .O(mux_o_33),
  .I0(mux_o_30),
  .I1(mux_o_31),
  .S0(dff_q_1)
);
MUX2 mux_inst_34 (
  .O(douta[4]),
  .I0(mux_o_32),
  .I1(mux_o_33),
  .S0(dff_q_0)
);
MUX2 mux_inst_35 (
  .O(mux_o_35),
  .I0(dpx9b_inst_0_douta[5]),
  .I1(dpx9b_inst_1_douta[5]),
  .S0(dff_q_2)
);
MUX2 mux_inst_36 (
  .O(mux_o_36),
  .I0(dpx9b_inst_2_douta[5]),
  .I1(dpx9b_inst_3_douta[5]),
  .S0(dff_q_2)
);
MUX2 mux_inst_37 (
  .O(mux_o_37),
  .I0(dpx9b_inst_4_douta[5]),
  .I1(dpx9b_inst_5_douta[5]),
  .S0(dff_q_2)
);
MUX2 mux_inst_38 (
  .O(mux_o_38),
  .I0(dpx9b_inst_6_douta[5]),
  .I1(dpx9b_inst_7_douta[5]),
  .S0(dff_q_2)
);
MUX2 mux_inst_39 (
  .O(mux_o_39),
  .I0(mux_o_35),
  .I1(mux_o_36),
  .S0(dff_q_1)
);
MUX2 mux_inst_40 (
  .O(mux_o_40),
  .I0(mux_o_37),
  .I1(mux_o_38),
  .S0(dff_q_1)
);
MUX2 mux_inst_41 (
  .O(douta[5]),
  .I0(mux_o_39),
  .I1(mux_o_40),
  .S0(dff_q_0)
);
MUX2 mux_inst_42 (
  .O(mux_o_42),
  .I0(dpx9b_inst_0_douta[6]),
  .I1(dpx9b_inst_1_douta[6]),
  .S0(dff_q_2)
);
MUX2 mux_inst_43 (
  .O(mux_o_43),
  .I0(dpx9b_inst_2_douta[6]),
  .I1(dpx9b_inst_3_douta[6]),
  .S0(dff_q_2)
);
MUX2 mux_inst_44 (
  .O(mux_o_44),
  .I0(dpx9b_inst_4_douta[6]),
  .I1(dpx9b_inst_5_douta[6]),
  .S0(dff_q_2)
);
MUX2 mux_inst_45 (
  .O(mux_o_45),
  .I0(dpx9b_inst_6_douta[6]),
  .I1(dpx9b_inst_7_douta[6]),
  .S0(dff_q_2)
);
MUX2 mux_inst_46 (
  .O(mux_o_46),
  .I0(mux_o_42),
  .I1(mux_o_43),
  .S0(dff_q_1)
);
MUX2 mux_inst_47 (
  .O(mux_o_47),
  .I0(mux_o_44),
  .I1(mux_o_45),
  .S0(dff_q_1)
);
MUX2 mux_inst_48 (
  .O(douta[6]),
  .I0(mux_o_46),
  .I1(mux_o_47),
  .S0(dff_q_0)
);
MUX2 mux_inst_49 (
  .O(mux_o_49),
  .I0(dpx9b_inst_0_douta[7]),
  .I1(dpx9b_inst_1_douta[7]),
  .S0(dff_q_2)
);
MUX2 mux_inst_50 (
  .O(mux_o_50),
  .I0(dpx9b_inst_2_douta[7]),
  .I1(dpx9b_inst_3_douta[7]),
  .S0(dff_q_2)
);
MUX2 mux_inst_51 (
  .O(mux_o_51),
  .I0(dpx9b_inst_4_douta[7]),
  .I1(dpx9b_inst_5_douta[7]),
  .S0(dff_q_2)
);
MUX2 mux_inst_52 (
  .O(mux_o_52),
  .I0(dpx9b_inst_6_douta[7]),
  .I1(dpx9b_inst_7_douta[7]),
  .S0(dff_q_2)
);
MUX2 mux_inst_53 (
  .O(mux_o_53),
  .I0(mux_o_49),
  .I1(mux_o_50),
  .S0(dff_q_1)
);
MUX2 mux_inst_54 (
  .O(mux_o_54),
  .I0(mux_o_51),
  .I1(mux_o_52),
  .S0(dff_q_1)
);
MUX2 mux_inst_55 (
  .O(douta[7]),
  .I0(mux_o_53),
  .I1(mux_o_54),
  .S0(dff_q_0)
);
MUX2 mux_inst_56 (
  .O(mux_o_56),
  .I0(dpx9b_inst_0_douta[8]),
  .I1(dpx9b_inst_1_douta[8]),
  .S0(dff_q_2)
);
MUX2 mux_inst_57 (
  .O(mux_o_57),
  .I0(dpx9b_inst_2_douta[8]),
  .I1(dpx9b_inst_3_douta[8]),
  .S0(dff_q_2)
);
MUX2 mux_inst_58 (
  .O(mux_o_58),
  .I0(dpx9b_inst_4_douta[8]),
  .I1(dpx9b_inst_5_douta[8]),
  .S0(dff_q_2)
);
MUX2 mux_inst_59 (
  .O(mux_o_59),
  .I0(dpx9b_inst_6_douta[8]),
  .I1(dpx9b_inst_7_douta[8]),
  .S0(dff_q_2)
);
MUX2 mux_inst_60 (
  .O(mux_o_60),
  .I0(mux_o_56),
  .I1(mux_o_57),
  .S0(dff_q_1)
);
MUX2 mux_inst_61 (
  .O(mux_o_61),
  .I0(mux_o_58),
  .I1(mux_o_59),
  .S0(dff_q_1)
);
MUX2 mux_inst_62 (
  .O(douta[8]),
  .I0(mux_o_60),
  .I1(mux_o_61),
  .S0(dff_q_0)
);
MUX2 mux_inst_63 (
  .O(mux_o_63),
  .I0(dpx9b_inst_0_doutb[0]),
  .I1(dpx9b_inst_1_doutb[0]),
  .S0(dff_q_5)
);
MUX2 mux_inst_64 (
  .O(mux_o_64),
  .I0(dpx9b_inst_2_doutb[0]),
  .I1(dpx9b_inst_3_doutb[0]),
  .S0(dff_q_5)
);
MUX2 mux_inst_65 (
  .O(mux_o_65),
  .I0(dpx9b_inst_4_doutb[0]),
  .I1(dpx9b_inst_5_doutb[0]),
  .S0(dff_q_5)
);
MUX2 mux_inst_66 (
  .O(mux_o_66),
  .I0(dpx9b_inst_6_doutb[0]),
  .I1(dpx9b_inst_7_doutb[0]),
  .S0(dff_q_5)
);
MUX2 mux_inst_67 (
  .O(mux_o_67),
  .I0(mux_o_63),
  .I1(mux_o_64),
  .S0(dff_q_4)
);
MUX2 mux_inst_68 (
  .O(mux_o_68),
  .I0(mux_o_65),
  .I1(mux_o_66),
  .S0(dff_q_4)
);
MUX2 mux_inst_69 (
  .O(doutb[0]),
  .I0(mux_o_67),
  .I1(mux_o_68),
  .S0(dff_q_3)
);
MUX2 mux_inst_70 (
  .O(mux_o_70),
  .I0(dpx9b_inst_0_doutb[1]),
  .I1(dpx9b_inst_1_doutb[1]),
  .S0(dff_q_5)
);
MUX2 mux_inst_71 (
  .O(mux_o_71),
  .I0(dpx9b_inst_2_doutb[1]),
  .I1(dpx9b_inst_3_doutb[1]),
  .S0(dff_q_5)
);
MUX2 mux_inst_72 (
  .O(mux_o_72),
  .I0(dpx9b_inst_4_doutb[1]),
  .I1(dpx9b_inst_5_doutb[1]),
  .S0(dff_q_5)
);
MUX2 mux_inst_73 (
  .O(mux_o_73),
  .I0(dpx9b_inst_6_doutb[1]),
  .I1(dpx9b_inst_7_doutb[1]),
  .S0(dff_q_5)
);
MUX2 mux_inst_74 (
  .O(mux_o_74),
  .I0(mux_o_70),
  .I1(mux_o_71),
  .S0(dff_q_4)
);
MUX2 mux_inst_75 (
  .O(mux_o_75),
  .I0(mux_o_72),
  .I1(mux_o_73),
  .S0(dff_q_4)
);
MUX2 mux_inst_76 (
  .O(doutb[1]),
  .I0(mux_o_74),
  .I1(mux_o_75),
  .S0(dff_q_3)
);
MUX2 mux_inst_77 (
  .O(mux_o_77),
  .I0(dpx9b_inst_0_doutb[2]),
  .I1(dpx9b_inst_1_doutb[2]),
  .S0(dff_q_5)
);
MUX2 mux_inst_78 (
  .O(mux_o_78),
  .I0(dpx9b_inst_2_doutb[2]),
  .I1(dpx9b_inst_3_doutb[2]),
  .S0(dff_q_5)
);
MUX2 mux_inst_79 (
  .O(mux_o_79),
  .I0(dpx9b_inst_4_doutb[2]),
  .I1(dpx9b_inst_5_doutb[2]),
  .S0(dff_q_5)
);
MUX2 mux_inst_80 (
  .O(mux_o_80),
  .I0(dpx9b_inst_6_doutb[2]),
  .I1(dpx9b_inst_7_doutb[2]),
  .S0(dff_q_5)
);
MUX2 mux_inst_81 (
  .O(mux_o_81),
  .I0(mux_o_77),
  .I1(mux_o_78),
  .S0(dff_q_4)
);
MUX2 mux_inst_82 (
  .O(mux_o_82),
  .I0(mux_o_79),
  .I1(mux_o_80),
  .S0(dff_q_4)
);
MUX2 mux_inst_83 (
  .O(doutb[2]),
  .I0(mux_o_81),
  .I1(mux_o_82),
  .S0(dff_q_3)
);
MUX2 mux_inst_84 (
  .O(mux_o_84),
  .I0(dpx9b_inst_0_doutb[3]),
  .I1(dpx9b_inst_1_doutb[3]),
  .S0(dff_q_5)
);
MUX2 mux_inst_85 (
  .O(mux_o_85),
  .I0(dpx9b_inst_2_doutb[3]),
  .I1(dpx9b_inst_3_doutb[3]),
  .S0(dff_q_5)
);
MUX2 mux_inst_86 (
  .O(mux_o_86),
  .I0(dpx9b_inst_4_doutb[3]),
  .I1(dpx9b_inst_5_doutb[3]),
  .S0(dff_q_5)
);
MUX2 mux_inst_87 (
  .O(mux_o_87),
  .I0(dpx9b_inst_6_doutb[3]),
  .I1(dpx9b_inst_7_doutb[3]),
  .S0(dff_q_5)
);
MUX2 mux_inst_88 (
  .O(mux_o_88),
  .I0(mux_o_84),
  .I1(mux_o_85),
  .S0(dff_q_4)
);
MUX2 mux_inst_89 (
  .O(mux_o_89),
  .I0(mux_o_86),
  .I1(mux_o_87),
  .S0(dff_q_4)
);
MUX2 mux_inst_90 (
  .O(doutb[3]),
  .I0(mux_o_88),
  .I1(mux_o_89),
  .S0(dff_q_3)
);
MUX2 mux_inst_91 (
  .O(mux_o_91),
  .I0(dpx9b_inst_0_doutb[4]),
  .I1(dpx9b_inst_1_doutb[4]),
  .S0(dff_q_5)
);
MUX2 mux_inst_92 (
  .O(mux_o_92),
  .I0(dpx9b_inst_2_doutb[4]),
  .I1(dpx9b_inst_3_doutb[4]),
  .S0(dff_q_5)
);
MUX2 mux_inst_93 (
  .O(mux_o_93),
  .I0(dpx9b_inst_4_doutb[4]),
  .I1(dpx9b_inst_5_doutb[4]),
  .S0(dff_q_5)
);
MUX2 mux_inst_94 (
  .O(mux_o_94),
  .I0(dpx9b_inst_6_doutb[4]),
  .I1(dpx9b_inst_7_doutb[4]),
  .S0(dff_q_5)
);
MUX2 mux_inst_95 (
  .O(mux_o_95),
  .I0(mux_o_91),
  .I1(mux_o_92),
  .S0(dff_q_4)
);
MUX2 mux_inst_96 (
  .O(mux_o_96),
  .I0(mux_o_93),
  .I1(mux_o_94),
  .S0(dff_q_4)
);
MUX2 mux_inst_97 (
  .O(doutb[4]),
  .I0(mux_o_95),
  .I1(mux_o_96),
  .S0(dff_q_3)
);
MUX2 mux_inst_98 (
  .O(mux_o_98),
  .I0(dpx9b_inst_0_doutb[5]),
  .I1(dpx9b_inst_1_doutb[5]),
  .S0(dff_q_5)
);
MUX2 mux_inst_99 (
  .O(mux_o_99),
  .I0(dpx9b_inst_2_doutb[5]),
  .I1(dpx9b_inst_3_doutb[5]),
  .S0(dff_q_5)
);
MUX2 mux_inst_100 (
  .O(mux_o_100),
  .I0(dpx9b_inst_4_doutb[5]),
  .I1(dpx9b_inst_5_doutb[5]),
  .S0(dff_q_5)
);
MUX2 mux_inst_101 (
  .O(mux_o_101),
  .I0(dpx9b_inst_6_doutb[5]),
  .I1(dpx9b_inst_7_doutb[5]),
  .S0(dff_q_5)
);
MUX2 mux_inst_102 (
  .O(mux_o_102),
  .I0(mux_o_98),
  .I1(mux_o_99),
  .S0(dff_q_4)
);
MUX2 mux_inst_103 (
  .O(mux_o_103),
  .I0(mux_o_100),
  .I1(mux_o_101),
  .S0(dff_q_4)
);
MUX2 mux_inst_104 (
  .O(doutb[5]),
  .I0(mux_o_102),
  .I1(mux_o_103),
  .S0(dff_q_3)
);
MUX2 mux_inst_105 (
  .O(mux_o_105),
  .I0(dpx9b_inst_0_doutb[6]),
  .I1(dpx9b_inst_1_doutb[6]),
  .S0(dff_q_5)
);
MUX2 mux_inst_106 (
  .O(mux_o_106),
  .I0(dpx9b_inst_2_doutb[6]),
  .I1(dpx9b_inst_3_doutb[6]),
  .S0(dff_q_5)
);
MUX2 mux_inst_107 (
  .O(mux_o_107),
  .I0(dpx9b_inst_4_doutb[6]),
  .I1(dpx9b_inst_5_doutb[6]),
  .S0(dff_q_5)
);
MUX2 mux_inst_108 (
  .O(mux_o_108),
  .I0(dpx9b_inst_6_doutb[6]),
  .I1(dpx9b_inst_7_doutb[6]),
  .S0(dff_q_5)
);
MUX2 mux_inst_109 (
  .O(mux_o_109),
  .I0(mux_o_105),
  .I1(mux_o_106),
  .S0(dff_q_4)
);
MUX2 mux_inst_110 (
  .O(mux_o_110),
  .I0(mux_o_107),
  .I1(mux_o_108),
  .S0(dff_q_4)
);
MUX2 mux_inst_111 (
  .O(doutb[6]),
  .I0(mux_o_109),
  .I1(mux_o_110),
  .S0(dff_q_3)
);
MUX2 mux_inst_112 (
  .O(mux_o_112),
  .I0(dpx9b_inst_0_doutb[7]),
  .I1(dpx9b_inst_1_doutb[7]),
  .S0(dff_q_5)
);
MUX2 mux_inst_113 (
  .O(mux_o_113),
  .I0(dpx9b_inst_2_doutb[7]),
  .I1(dpx9b_inst_3_doutb[7]),
  .S0(dff_q_5)
);
MUX2 mux_inst_114 (
  .O(mux_o_114),
  .I0(dpx9b_inst_4_doutb[7]),
  .I1(dpx9b_inst_5_doutb[7]),
  .S0(dff_q_5)
);
MUX2 mux_inst_115 (
  .O(mux_o_115),
  .I0(dpx9b_inst_6_doutb[7]),
  .I1(dpx9b_inst_7_doutb[7]),
  .S0(dff_q_5)
);
MUX2 mux_inst_116 (
  .O(mux_o_116),
  .I0(mux_o_112),
  .I1(mux_o_113),
  .S0(dff_q_4)
);
MUX2 mux_inst_117 (
  .O(mux_o_117),
  .I0(mux_o_114),
  .I1(mux_o_115),
  .S0(dff_q_4)
);
MUX2 mux_inst_118 (
  .O(doutb[7]),
  .I0(mux_o_116),
  .I1(mux_o_117),
  .S0(dff_q_3)
);
MUX2 mux_inst_119 (
  .O(mux_o_119),
  .I0(dpx9b_inst_0_doutb[8]),
  .I1(dpx9b_inst_1_doutb[8]),
  .S0(dff_q_5)
);
MUX2 mux_inst_120 (
  .O(mux_o_120),
  .I0(dpx9b_inst_2_doutb[8]),
  .I1(dpx9b_inst_3_doutb[8]),
  .S0(dff_q_5)
);
MUX2 mux_inst_121 (
  .O(mux_o_121),
  .I0(dpx9b_inst_4_doutb[8]),
  .I1(dpx9b_inst_5_doutb[8]),
  .S0(dff_q_5)
);
MUX2 mux_inst_122 (
  .O(mux_o_122),
  .I0(dpx9b_inst_6_doutb[8]),
  .I1(dpx9b_inst_7_doutb[8]),
  .S0(dff_q_5)
);
MUX2 mux_inst_123 (
  .O(mux_o_123),
  .I0(mux_o_119),
  .I1(mux_o_120),
  .S0(dff_q_4)
);
MUX2 mux_inst_124 (
  .O(mux_o_124),
  .I0(mux_o_121),
  .I1(mux_o_122),
  .S0(dff_q_4)
);
MUX2 mux_inst_125 (
  .O(doutb[8]),
  .I0(mux_o_123),
  .I1(mux_o_124),
  .S0(dff_q_3)
);
endmodule //t20k_vmemDP
