# General
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

# Clock
set_property PACKAGE_PIN W5 [get_ports {sysclk}]
set_property IOSTANDARD LVCMOS33 [get_ports {sysclk}]
create_clock -name sysclk -period 10 [get_ports {sysclk}]

# Switches
set_property PACKAGE_PIN V17 [get_ports {switches[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[0]}]
set_property PACKAGE_PIN V16 [get_ports {switches[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[1]}]
set_property PACKAGE_PIN W16 [get_ports {switches[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[2]}]
set_property PACKAGE_PIN W17 [get_ports {switches[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[3]}]
set_property PACKAGE_PIN W15 [get_ports {switches[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[4]}]
set_property PACKAGE_PIN V15 [get_ports {switches[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[5]}]
set_property PACKAGE_PIN W14 [get_ports {switches[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[6]}]
set_property PACKAGE_PIN W13 [get_ports {switches[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[7]}]
set_property PACKAGE_PIN V2 [get_ports {switches[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[8]}]
set_property PACKAGE_PIN T3 [get_ports {switches[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[9]}]
set_property PACKAGE_PIN T2 [get_ports {switches[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[10]}]
set_property PACKAGE_PIN R3 [get_ports {switches[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[11]}]
set_property PACKAGE_PIN W2 [get_ports {switches[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[12]}]
set_property PACKAGE_PIN U1 [get_ports {switches[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[13]}]
set_property PACKAGE_PIN T1 [get_ports {switches[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[14]}]
set_property PACKAGE_PIN R2 [get_ports {switches[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[15]}]

# Buttons
set_property PACKAGE_PIN T18 [get_ports {button_up}]
set_property IOSTANDARD LVCMOS33 [get_ports {button_up}]
set_property PACKAGE_PIN U17 [get_ports {button_down}]
set_property IOSTANDARD LVCMOS33 [get_ports {button_down}]
set_property PACKAGE_PIN W19 [get_ports {button_left}]
set_property IOSTANDARD LVCMOS33 [get_ports {button_left}]
set_property PACKAGE_PIN T17 [get_ports {button_right}]
set_property IOSTANDARD LVCMOS33 [get_ports {button_right}]
set_property PACKAGE_PIN U18 [get_ports {button_center}]
set_property IOSTANDARD LVCMOS33 [get_ports {button_center}]

# LEDs
set_property PACKAGE_PIN U16 [get_ports {leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]
set_property PACKAGE_PIN E19 [get_ports {leds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]
set_property PACKAGE_PIN U19 [get_ports {leds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]
set_property PACKAGE_PIN V19 [get_ports {leds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]
set_property PACKAGE_PIN W18 [get_ports {leds[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[4]}]
set_property PACKAGE_PIN U15 [get_ports {leds[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[5]}]
set_property PACKAGE_PIN U14 [get_ports {leds[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[6]}]
set_property PACKAGE_PIN V14 [get_ports {leds[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[7]}]
set_property PACKAGE_PIN V13 [get_ports {leds[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[8]}]
set_property PACKAGE_PIN V3 [get_ports {leds[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[9]}]
set_property PACKAGE_PIN W3 [get_ports {leds[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[10]}]
set_property PACKAGE_PIN U3 [get_ports {leds[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[11]}]
set_property PACKAGE_PIN P3 [get_ports {leds[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[12]}]
set_property PACKAGE_PIN N3 [get_ports {leds[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[13]}]
set_property PACKAGE_PIN P1 [get_ports {leds[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[14]}]
set_property PACKAGE_PIN L1 [get_ports {leds[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[15]}]

# Digit Disable
set_property PACKAGE_PIN W4 [get_ports {digit_disable[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit_disable[3]}]
set_property PACKAGE_PIN V4 [get_ports {digit_disable[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit_disable[2]}]
set_property PACKAGE_PIN U4 [get_ports {digit_disable[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit_disable[1]}]
set_property PACKAGE_PIN U2 [get_ports {digit_disable[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit_disable[0]}]

# Segments
set_property PACKAGE_PIN W7 [get_ports {segments[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segments[0]}]
set_property PACKAGE_PIN W6 [get_ports {segments[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segments[1]}]
set_property PACKAGE_PIN U8 [get_ports {segments[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segments[2]}]
set_property PACKAGE_PIN V8 [get_ports {segments[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segments[3]}]
set_property PACKAGE_PIN U5 [get_ports {segments[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segments[4]}]
set_property PACKAGE_PIN V5 [get_ports {segments[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segments[5]}]
set_property PACKAGE_PIN U7 [get_ports {segments[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segments[6]}]
set_property PACKAGE_PIN V7 [get_ports {segments[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segments[7]}]
