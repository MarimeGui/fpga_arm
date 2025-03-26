# General
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

# Clock
set_property PACKAGE_PIN R2 [get_ports {sysclk}]
set_property IOSTANDARD LVCMOS33 [get_ports {sysclk}]
create_clock -name sysclk -period 10 [get_ports {sysclk}]

# Switches
set_property PACKAGE_PIN H14 [get_ports {switches[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[0]}]
set_property PACKAGE_PIN H18 [get_ports {switches[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[1]}]
set_property PACKAGE_PIN G18 [get_ports {switches[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[2]}]
set_property PACKAGE_PIN M5 [get_ports {switches[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[3]}]

# Buttons
set_property PACKAGE_PIN G15 [get_ports {buttons[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[0]}]
set_property PACKAGE_PIN K16 [get_ports {buttons[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[1]}]
set_property PACKAGE_PIN J16 [get_ports {buttons[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[2]}]
set_property PACKAGE_PIN H13 [get_ports {buttons[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[3]}]

# Green LEDs
set_property PACKAGE_PIN E18 [get_ports {leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]
set_property PACKAGE_PIN F13 [get_ports {leds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]
set_property PACKAGE_PIN E13 [get_ports {leds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]
set_property PACKAGE_PIN H15 [get_ports {leds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]

# RGB LEDs
set_property PACKAGE_PIN J15 [get_ports {rgb_leds[0][0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb_leds[0][0]}]
set_property PACKAGE_PIN G17 [get_ports {rgb_leds[0][1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb_leds[0][1]}]
set_property PACKAGE_PIN F15 [get_ports {rgb_leds[0][2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb_leds[0][2]}]

set_property PACKAGE_PIN E15 [get_ports {rgb_leds[1][0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb_leds[1][0]}]
set_property PACKAGE_PIN F18 [get_ports {rgb_leds[1][1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb_leds[1][1]}]
set_property PACKAGE_PIN E14 [get_ports {rgb_leds[1][2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgb_leds[1][2]}]
