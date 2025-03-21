# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config  -id {Labtoolstcl 44-513}  -string {{ERROR: [Labtoolstcl 44-513] HW Target shutdown. Closing target: localhost:3121/xilinx_tcf/Digilent/210183A4D897A}}  -suppress 
set_msg_config  -id {Synth 8-3917}  -string {{WARNING: [Synth 8-3917] design CPU_tb has port Disable7Seg[3] driven by constant 1}}  -suppress 
set_msg_config  -id {Synth 8-3917}  -string {{WARNING: [Synth 8-3917] design CPU_tb has port Disable7Seg[2] driven by constant 1}}  -suppress 
set_msg_config  -id {Synth 8-3917}  -string {{WARNING: [Synth 8-3917] design CPU_tb has port Disable7Seg[1] driven by constant 1}}  -suppress 
set_msg_config  -id {Synth 8-3917}  -suppress 
set_msg_config  -id {Synth 8-3331}  -suppress 
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/FPGA_ARM/FPGA_ARM.cache/wt [current_project]
set_property parent.project_path C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/FPGA_ARM/FPGA_ARM.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/FPGA_ARM/FPGA_ARM.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib -sv {
  C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/verilog/Utilities.sv
  C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/verilog/cpu/ALU.sv
  C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/verilog/cpu/BCC.sv
  C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/verilog/cpu/CPU.sv
  C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/FPGA_ARM/FPGA_ARM.srcs/sources_1/new/CPU_tb.sv
  C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/verilog/cpu/DCache.sv
  C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/verilog/cpu/Decode.sv
  C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/verilog/cpu/Fetch.sv
  C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/verilog/cpu/GPIO.sv
  C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/verilog/cpu/ICache.sv
  C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/verilog/cpu/LittleEndianInverter.sv
  C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/verilog/cpu/Mux32.sv
  C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/verilog/cpu/RegReturnMux.sv
  C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/verilog/cpu/RegisterFile.sv
  C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/verilog/cpu/Execute.sv
  C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/FPGA_ARM/FPGA_ARM.srcs/sources_1/new/FrequencyDivider.sv
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/FPGA_ARM/FPGA_ARM.srcs/constrs_1/imports/new/Basys3.xdc
set_property used_in_implementation false [get_files C:/ProgramsWorkspace/ENSEA/Projet_2A/fpga_arm/FPGA_ARM/FPGA_ARM.srcs/constrs_1/imports/new/Basys3.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top CPU_tb -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef CPU_tb.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file CPU_tb_utilization_synth.rpt -pb CPU_tb_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
