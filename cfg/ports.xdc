### LED

set_property IOSTANDARD LVCMOS33 [get_ports {led_o[0]}]
set_property SLEW SLOW [get_ports {led_o[0]}]
set_property DRIVE 4 [get_ports {led_o[0]}]

set_property PACKAGE_PIN P20 [get_ports {led_o[0]}]

set_property PACKAGE_PIN G21 [get_ports MDIO_PHY_0_mdc]
set_property PACKAGE_PIN H22 [get_ports MDIO_PHY_0_mdio_io]
set_property PACKAGE_PIN A22 [get_ports {RGMII_0_rd[0]}]
set_property PACKAGE_PIN A18 [get_ports {RGMII_0_rd[1]}]
set_property PACKAGE_PIN A19 [get_ports {RGMII_0_rd[2]}]
set_property PACKAGE_PIN B20 [get_ports {RGMII_0_rd[3]}]
set_property PACKAGE_PIN A21 [get_ports RGMII_0_rx_ctl]
set_property PACKAGE_PIN B19 [get_ports RGMII_0_rxc]
set_property PACKAGE_PIN E21 [get_ports {RGMII_0_td[0]}]
set_property PACKAGE_PIN F21 [get_ports {RGMII_0_td[1]}]
set_property PACKAGE_PIN F22 [get_ports {RGMII_0_td[2]}]
set_property PACKAGE_PIN G20 [get_ports {RGMII_0_td[3]}]
set_property PACKAGE_PIN G22 [get_ports RGMII_0_tx_ctl]
set_property PACKAGE_PIN D21 [get_ports RGMII_0_txc]
set_property PACKAGE_PIN M17 [get_ports UART_0_0_rxd]
set_property PACKAGE_PIN L17 [get_ports UART_0_0_txd]


set_property IOSTANDARD LVCMOS33 [get_ports MDIO_PHY_0_mdc]
set_property IOSTANDARD LVCMOS33 [get_ports MDIO_PHY_0_mdio_io]
set_property IOSTANDARD LVCMOS33 [get_ports {RGMII_0_rd[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RGMII_0_rd[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RGMII_0_rd[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RGMII_0_rd[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports RGMII_0_rx_ctl]
set_property IOSTANDARD LVCMOS33 [get_ports RGMII_0_rxc]
set_property IOSTANDARD LVCMOS33 [get_ports {RGMII_0_td[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RGMII_0_td[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RGMII_0_td[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RGMII_0_td[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports RGMII_0_tx_ctl]
set_property IOSTANDARD LVCMOS33 [get_ports RGMII_0_txc]
set_property IOSTANDARD LVCMOS33 [get_ports UART_0_0_rxd]
set_property IOSTANDARD LVCMOS33 [get_ports UART_0_0_txd]


set_property SLEW FAST [get_ports {RGMII_0_td[0]}]
set_property SLEW FAST [get_ports {RGMII_0_td[1]}]
set_property SLEW FAST [get_ports {RGMII_0_td[2]}]
set_property SLEW FAST [get_ports {RGMII_0_td[3]}]
set_property SLEW FAST [get_ports RGMII_0_tx_ctl]
set_property SLEW FAST [get_ports RGMII_0_txc]


create_clock -period 8.000 -name RGMII_0_rxc -waveform {0.000 4.000} [get_ports RGMII_0_rxc]

