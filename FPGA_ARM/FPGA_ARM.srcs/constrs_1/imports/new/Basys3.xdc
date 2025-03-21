#######################################
# Basys3 Pin Assignments              #
#######################################


##########
# Clock  #
##########

# Clock 100 MHZ
set_property PACKAGE_PIN W5 [get_ports {CLK100MHZ}]
    set_property IOSTANDARD LVCMOS33 [get_ports {CLK100MHZ}]
    create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK100MHZ]

## Clock signal
#set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports CLK100MHZ]
#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK100MHZ]


#############
# Switches  #
#############

# Swicth n�15
set_property PACKAGE_PIN R2 [get_ports {SW[15]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SW[15]}]
# Swicth n�14
set_property PACKAGE_PIN T1 [get_ports {SW[14]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SW[14]}]
# Swicth n�13
set_property PACKAGE_PIN U1 [get_ports {SW[13]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SW[13]}]
# Swicth n�12
set_property PACKAGE_PIN W2 [get_ports {SW[12]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SW[12]}]
# Swicth n�11
set_property PACKAGE_PIN R3 [get_ports {SW[11]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SW[11]}]
# Swicth n�10
set_property PACKAGE_PIN T2 [get_ports {SW[10]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SW[10]}]
# Swicth n�9
set_property PACKAGE_PIN T3 [get_ports {SW[9]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SW[9]}]
# Swicth n�8
set_property PACKAGE_PIN V2 [get_ports {SW[8]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SW[8]}]
# Swicth n�7
set_property PACKAGE_PIN W13 [get_ports {SW[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SW[7]}]
# Swicth n�6
set_property PACKAGE_PIN W14 [get_ports {SW[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SW[6]}]
# Swicth n�5
set_property PACKAGE_PIN V15 [get_ports {SW[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SW[5]}]
# Swicth n�4
set_property PACKAGE_PIN W15 [get_ports {SW[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SW[4]}]
# Swicth n�3
set_property PACKAGE_PIN W17 [get_ports {SW[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SW[3]}]
# Swicth n�2
set_property PACKAGE_PIN W16 [get_ports {SW[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SW[2]}]
# Swicth n�1
set_property PACKAGE_PIN V16 [get_ports {SW[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SW[1]}]
# Swicth n�0
set_property PACKAGE_PIN V17 [get_ports {SW[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SW[0]}]


#####################
# On-board Buttons  #
#####################

# Button left
set_property PACKAGE_PIN W19 [get_ports {BTNL}]
set_property IOSTANDARD LVCMOS33 [get_ports {BTNL}]
# Button right
set_property PACKAGE_PIN T17 [get_ports {BTNR}]
set_property IOSTANDARD LVCMOS33 [get_ports {BTNR}]
# Button up
set_property PACKAGE_PIN T18 [get_ports {BTNU}]
set_property IOSTANDARD LVCMOS33 [get_ports {BTNU}]
# Button down
set_property PACKAGE_PIN U17 [get_ports {BTND}]
set_property IOSTANDARD LVCMOS33 [get_ports {BTND}]
# Button center
set_property PACKAGE_PIN U18 [get_ports {BTNC}]
set_property IOSTANDARD LVCMOS33 [get_ports {BTNC}]

##################
# On-board LEDs  #
##################

# LED n�15
set_property PACKAGE_PIN L1 [get_ports {LED[15]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[15]}]
# LED n�14
set_property PACKAGE_PIN P1 [get_ports {LED[14]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[14]}]
# LED n�13
set_property PACKAGE_PIN N3 [get_ports {LED[13]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[13]}]
# LED n�12
set_property PACKAGE_PIN P3 [get_ports {LED[12]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[12]}]
# LED n�11
set_property PACKAGE_PIN U3 [get_ports {LED[11]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[11]}]
# LED n�10
set_property PACKAGE_PIN W3 [get_ports {LED[10]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[10]}]
# LED n�9
set_property PACKAGE_PIN V3 [get_ports {LED[9]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[9]}]
# LED n�8
set_property PACKAGE_PIN V13 [get_ports {LED[8]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[8]}]
# LED n�7
set_property PACKAGE_PIN V14 [get_ports {LED[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[7]}]
# LED n�6
set_property PACKAGE_PIN U14 [get_ports {LED[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[6]}]
# LED n�5
set_property PACKAGE_PIN U15 [get_ports {LED[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[5]}]
# LED n�4
set_property PACKAGE_PIN W18 [get_ports {LED[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[4]}]
# LED n�3
set_property PACKAGE_PIN V19 [get_ports {LED[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[3]}]
# LED n�2
set_property PACKAGE_PIN U19 [get_ports {LED[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[2]}]
# LED n�1
set_property PACKAGE_PIN E19 [get_ports {LED[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[1]}]
# LED n�0
set_property PACKAGE_PIN U16 [get_ports {LED[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[0]}]

###############################
# On-board 7-segment Display  #
###############################

## Dote�Point
set_property PACKAGE_PIN V7 [get_ports {DP}]
    set_property IOSTANDARD LVCMOS33 [get_ports {DP}]

## SEGMENTS
# Segment n�6
set_property PACKAGE_PIN U7 [get_ports {Seg[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Seg[6]}]
# Segment n�5
set_property PACKAGE_PIN V5 [get_ports {Seg[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Seg[5]}]
# Segment n�4
set_property PACKAGE_PIN U5 [get_ports {Seg[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Seg[4]}]
# Segment n�3
set_property PACKAGE_PIN V8 [get_ports {Seg[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Seg[3]}]
# Segment n�2
set_property PACKAGE_PIN U8 [get_ports {Seg[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Seg[2]}]
# Segment n�1
set_property PACKAGE_PIN W6 [get_ports {Seg[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Seg[1]}]
# Segment n�0
set_property PACKAGE_PIN W7 [get_ports {Seg[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Seg[0]}]

## DISABLE DISPLAYS 7-SEGMENTS
# Disable display n�3
set_property PACKAGE_PIN W4 [get_ports {Disable7Seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Disable7Seg[3]}]
# Disable display n�2
set_property PACKAGE_PIN V4 [get_ports {Disable7Seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Disable7Seg[2]}]
# Disable display n�1
set_property PACKAGE_PIN U4 [get_ports {Disable7Seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Disable7Seg[1]}]
# Disable display n�0
set_property PACKAGE_PIN U2 [get_ports {Disable7Seg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Disable7Seg[0]}]

############################
# On-board Input / Output  #
############################

##Pmod Header JA
#set_property -dict { PACKAGE_PIN J1   IOSTANDARD LVCMOS33 } [get_ports {JA[0]}];#Sch name = JA1
#set_property -dict { PACKAGE_PIN L2   IOSTANDARD LVCMOS33 } [get_ports {JA[1]}];#Sch name = JA2
#set_property -dict { PACKAGE_PIN J2   IOSTANDARD LVCMOS33 } [get_ports {JA[2]}];#Sch name = JA3
#set_property -dict { PACKAGE_PIN G2   IOSTANDARD LVCMOS33 } [get_ports {JA[3]}];#Sch name = JA4
#set_property -dict { PACKAGE_PIN H1   IOSTANDARD LVCMOS33 } [get_ports {JA[4]}];#Sch name = JA7
#set_property -dict { PACKAGE_PIN K2   IOSTANDARD LVCMOS33 } [get_ports {JA[5]}];#Sch name = JA8
#set_property -dict { PACKAGE_PIN H2   IOSTANDARD LVCMOS33 } [get_ports {JA[6]}];#Sch name = JA9
#set_property -dict { PACKAGE_PIN G3   IOSTANDARD LVCMOS33 } [get_ports {JA[7]}];#Sch name = JA10

##Pmod Header JB
#set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports {JB[0]}];#Sch name = JB1
#set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS33 } [get_ports {JB[1]}];#Sch name = JB2
#set_property -dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS33 } [get_ports {JB[2]}];#Sch name = JB3
#set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33 } [get_ports {JB[3]}];#Sch name = JB4
#set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS33 } [get_ports {JB[4]}];#Sch name = JB7
#set_property -dict { PACKAGE_PIN A17   IOSTANDARD LVCMOS33 } [get_ports {JB[5]}];#Sch name = JB8
#set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS33 } [get_ports {JB[6]}];#Sch name = JB9
#set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports {JB[7]}];#Sch name = JB10

##Pmod Header JC
#set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports {JC[0]}];#Sch name = JC1
#set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports {JC[1]}];#Sch name = JC2
#set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports {JC[2]}];#Sch name = JC3
#set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports {JC[3]}];#Sch name = JC4
#set_property -dict { PACKAGE_PIN L17   IOSTANDARD LVCMOS33 } [get_ports {JC[4]}];#Sch name = JC7
#set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVCMOS33 } [get_ports {JC[5]}];#Sch name = JC8
#set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports {JC[6]}];#Sch name = JC9
#set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports {JC[7]}];#Sch name = JC10

##Pmod Header JXADC
#set_property -dict { PACKAGE_PIN J3   IOSTANDARD LVCMOS33 } [get_ports {JXADC[0]}];#Sch name = XA1_P
#set_property -dict { PACKAGE_PIN L3   IOSTANDARD LVCMOS33 } [get_ports {JXADC[1]}];#Sch name = XA2_P
#set_property -dict { PACKAGE_PIN M2   IOSTANDARD LVCMOS33 } [get_ports {JXADC[2]}];#Sch name = XA3_P
#set_property -dict { PACKAGE_PIN N2   IOSTANDARD LVCMOS33 } [get_ports {JXADC[3]}];#Sch name = XA4_P
#set_property -dict { PACKAGE_PIN K3   IOSTANDARD LVCMOS33 } [get_ports {JXADC[4]}];#Sch name = XA1_N
#set_property -dict { PACKAGE_PIN M3   IOSTANDARD LVCMOS33 } [get_ports {JXADC[5]}];#Sch name = XA2_N
#set_property -dict { PACKAGE_PIN M1   IOSTANDARD LVCMOS33 } [get_ports {JXADC[6]}];#Sch name = XA3_N
#set_property -dict { PACKAGE_PIN N1   IOSTANDARD LVCMOS33 } [get_ports {JXADC[7]}];#Sch name = XA4_N


##VGA Connector
#set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS33 } [get_ports {vgaRed[0]}]
#set_property -dict { PACKAGE_PIN H19   IOSTANDARD LVCMOS33 } [get_ports {vgaRed[1]}]
#set_property -dict { PACKAGE_PIN J19   IOSTANDARD LVCMOS33 } [get_ports {vgaRed[2]}]
#set_property -dict { PACKAGE_PIN N19   IOSTANDARD LVCMOS33 } [get_ports {vgaRed[3]}]
#set_property -dict { PACKAGE_PIN N18   IOSTANDARD LVCMOS33 } [get_ports {vgaBlue[0]}]
#set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports {vgaBlue[1]}]
#set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports {vgaBlue[2]}]
#set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports {vgaBlue[3]}]
#set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports {vgaGreen[0]}]
#set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports {vgaGreen[1]}]
#set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports {vgaGreen[2]}]
#set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports {vgaGreen[3]}]
#set_property -dict { PACKAGE_PIN P19   IOSTANDARD LVCMOS33 } [get_ports Hsync]
#set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports Vsync]


##USB-RS232 Interface
#set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports RsRx]
#set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports RsTx]


##USB HID (PS/2)
#set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33   PULLUP true } [get_ports PS2Clk]
#set_property -dict { PACKAGE_PIN B17   IOSTANDARD LVCMOS33   PULLUP true } [get_ports PS2Data]


##Quad SPI Flash
##Note that CCLK_0 cannot be placed in 7 series devices. You can access it using the
##STARTUPE2 primitive.
#set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports {QspiDB[0]}]
#set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports {QspiDB[1]}]
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports {QspiDB[2]}]
#set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports {QspiDB[3]}]
#set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports QspiCSn]


## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## SPI configuration mode options for QSPI boot, can be used for all designs
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
