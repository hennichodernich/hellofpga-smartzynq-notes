# Create ports
create_bd_port -dir I adc_clk_p
create_bd_port -dir I adc_clk_n

create_bd_port -dir O -from 0 -to 0 led_o

create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 UART_0_0

create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 MDIO_PHY_0

create_bd_intf_port -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 RGMII_0

# Create xlconstant
cell xilinx.com:ip:xlconstant const_0

# Create clk_wiz
cell xilinx.com:ip:clk_wiz pll_0 {
    CLKOUT1_REQUESTED_OUT_FREQ 122.88
    CLKOUT1_REQUESTED_PHASE 180
    CLKOUT1_USED true
    PRIMITIVE PLL
    PRIM_IN_FREQ 122.88
    PRIM_SOURCE Differential_clock_capable_pin
    USE_RESET false
} {
  clk_in1_p adc_clk_p  
  clk_in1_n adc_clk_n  
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
# LED

# Create c_counter_binary
cell xilinx.com:ip:c_counter_binary cntr_0 {
  Output_Width 32
} {
  CLK pll_0/clk_out1
}

# Create xlslice
cell xilinx.com:ip:xlslice slice_1 {
  DIN_WIDTH 32 DIN_FROM 25 DIN_TO 25 DOUT_WIDTH 1
} {
  Din cntr_0/Q
  Dout led_o
}
