//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1.2 (win64) Build 2615518 Fri Aug  9 15:55:25 MDT 2019
//Date        : Tue Mar 11 17:06:13 2025
//Host        : c306-pc3 running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (CLK100MHZ,
    LED,
    reset_rtl_0);
  input CLK100MHZ;
  output [7:0]LED;
  input reset_rtl_0;

  wire CLK100MHZ;
  wire [7:0]LED;
  wire reset_rtl_0;

  design_1 design_1_i
       (.CLK100MHZ(CLK100MHZ),
        .LED(LED),
        .reset_rtl_0(reset_rtl_0));
endmodule
