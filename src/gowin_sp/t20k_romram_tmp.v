//Copyright (C)2014-2025 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.11.01 Education (64-bit)
//Part Number: GW2AR-LV18QN88C8/I7
//Device: GW2AR-18
//Device Version: C
//Created Time: Tue May  6 16:30:57 2025

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    t20k_romram your_instance_name(
        .dout(dout), //output [7:0] dout
        .clk(clk), //input clk
        .oce(oce), //input oce
        .ce(ce), //input ce
        .reset(reset), //input reset
        .wre(wre), //input wre
        .ad(ad), //input [12:0] ad
        .din(din) //input [7:0] din
    );

//--------Copy end-------------------
