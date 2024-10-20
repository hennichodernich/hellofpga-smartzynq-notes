# Create ports
create_bd_port -dir I adc_clk_p
create_bd_port -dir I adc_clk_n

create_bd_port -dir I -from 15 -to 0 adc_dat_p
create_bd_port -dir I -from 15 -to 0 adc_dat_n

create_bd_port -dir O -from 0 -to 0 led_o

create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 UART_0_0

create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 MDIO_PHY_0

create_bd_intf_port -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 RGMII_0

# Create xlconstant
cell xilinx.com:ip:xlconstant const_0

# Create clk_wiz
cell xilinx.com:ip:clk_wiz pll_0 {
  PRIMITIVE PLL
  PRIM_IN_FREQ.VALUE_SRC USER
  PRIM_IN_FREQ 122.88
  PRIM_SOURCE Differential_clock_capable_pin
  CLKOUT1_USED true
  CLKOUT1_REQUESTED_OUT_FREQ 122.88
  CLKOUT1_REQUESTED_PHASE 180
  USE_RESET false
} {
  clk_in1_p adc_clk_p  
  clk_in1_n adc_clk_n  
  locked led_o
}

# Create processing_system7
cell xilinx.com:ip:processing_system7 ps_0 {
  PCW_IMPORT_BOARD_PRESET cfg/hellofpga_smart_zynq_sl_7020.xml
  PCW_USE_M_AXI_GP1 1
  PCW_FPGA0_PERIPHERAL_FREQMHZ 200
  PCW_CLK0_FREQ 200000000
  PCW_FPGA_FCLK0_ENABLE 1
} {
  M_AXI_GP0_ACLK pll_0/clk_out1
  M_AXI_GP1_ACLK pll_0/clk_out1
  UART_0 UART_0_0
}

# Create all required interconnections
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {
  make_external {FIXED_IO, DDR}
  Master Disable
  Slave Disable
} [get_bd_cells ps_0]

# Create proc_sys_reset
cell xilinx.com:ip:proc_sys_reset rst_0 {} {
  ext_reset_in const_0/dout
  dcm_locked pll_0/locked
  slowest_sync_clk pll_0/clk_out1
}




# Create instance: util_vector_logic_1, and set properties
cell xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_1 {
  C_OPERATION not
  C_SIZE 1
} {
  Op1 ps_0/FCLK_RESET0_N
}


  # Create instance: gmii_to_rgmii_0, and set properties
cell xilinx.com:ip:gmii_to_rgmii:4.1 gmii_to_rgmii_0 {
  SupportLevel Include_Shared_Logic_in_Core
} {
  clkin ps_0/FCLK_CLK0
  tx_reset util_vector_logic_1/Res
  rx_reset util_vector_logic_1/Res
  GMII ps_0/GMII_ETHERNET_0
  MDIO_GEM ps_0/MDIO_ETHERNET_0
  RGMII RGMII_0
  MDIO_PHY MDIO_PHY_0
}



# ADC

# Create util_ds_buf
cell xilinx.com:ip:util_ds_buf buf_0 {
  C_SIZE 16
  C_BUF_TYPE IBUFDS
} {
  IBUF_DS_P adc_dat_p
  IBUF_DS_N adc_dat_n
}

# HUB

# Create axi_hub
cell pavel-demin:user:axi_hub hub_0 {
  CFG_DATA_WIDTH 544
  STS_DATA_WIDTH 32
} {
  S_AXI ps_0/M_AXI_GP0
  aclk pll_0/clk_out1
  aresetn rst_0/peripheral_aresetn
}

# RX 0

# Create port_slicer
cell pavel-demin:user:port_slicer rst_slice_0 {
  DIN_WIDTH 544 DIN_FROM 7 DIN_TO 0
} {
  din hub_0/cfg_data
}

# Create port_slicer
cell pavel-demin:user:port_slicer cfg_slice_0 {
  DIN_WIDTH 544 DIN_FROM 543 DIN_TO 32
} {
  din hub_0/cfg_data
}

module rx_0 {
  source projects/sdr_receiver_wspr_122_88/rx.tcl
} {
  slice_0/din rst_slice_0/dout
  slice_1/din cfg_slice_0/dout
  slice_2/din cfg_slice_0/dout
  slice_3/din cfg_slice_0/dout
  slice_4/din cfg_slice_0/dout
  slice_5/din cfg_slice_0/dout
  slice_6/din cfg_slice_0/dout
  slice_7/din cfg_slice_0/dout
  slice_8/din cfg_slice_0/dout
  slice_9/din cfg_slice_0/dout
  slice_10/din cfg_slice_0/dout
  slice_11/din cfg_slice_0/dout
  slice_12/din cfg_slice_0/dout
  slice_13/din cfg_slice_0/dout
  slice_14/din cfg_slice_0/dout
  slice_15/din cfg_slice_0/dout
  slice_16/din cfg_slice_0/dout
  fifo_0/read_count hub_0/sts_data
  conv_2/M_AXIS hub_0/S00_AXIS
}

# PPS and level measurement

#module common_0 {
#  source projects/common_tools/block_design.tcl
#}
