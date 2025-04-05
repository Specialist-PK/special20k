//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.03 (64-bit)
//Part Number: GW2AR-LV18QN88C8/I7
//Device: GW2AR-18
//Device Version: C
//Created Time: Mon Dec  9 18:31:54 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    t20k_vmemDP your_instance_name(
        .douta(douta), //output [10:0] douta
        .doutb(doutb), //output [10:0] doutb
        .clka(clka), //input clka
        .ocea(ocea), //input ocea
        .cea(cea), //input cea
        .reseta(reseta), //input reseta
        .wrea(wrea), //input wrea
        .clkb(clkb), //input clkb
        .oceb(oceb), //input oceb
        .ceb(ceb), //input ceb
        .resetb(resetb), //input resetb
        .wreb(wreb), //input wreb
        .ada(ada), //input [13:0] ada
        .dina(dina), //input [10:0] dina
        .adb(adb), //input [13:0] adb
        .dinb(dinb) //input [10:0] dinb
    );

//--------Copy end-------------------
