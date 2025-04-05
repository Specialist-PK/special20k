//Copyright (C)2014-2024 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.10.03 (64-bit) 
//Created Time: 2024-12-11 17:34:49

//create_clock -name cpu_clk -period 500 -waveform {0 250} [get_nets {cpu_div[3]}]
create_clock -name clk27mhz -period 37.037 -waveform {0 18.518} [get_ports {clk27mhz}]
create_clock -name clkU12mhz -period 83.333 -waveform {0 41.666} [get_nets {clkU12mhz}]
create_clock -name clkU32mhz -period 31.25 -waveform {0 15.625} [get_nets {clkU32mhz}]
create_clock -name clkB27mhz -period 37.037 -waveform {0 18.518} [get_nets {clkB27mhz}]
