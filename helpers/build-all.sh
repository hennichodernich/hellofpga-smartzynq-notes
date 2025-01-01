source /opt/Xilinx/Vitis/2023.1/settings64.sh

JOBS=`nproc 2> /dev/null || echo 1`

make -j $JOBS cores

make NAME=led_blinker_122_88 all

PRJS="sdr_receiver_122_88 sdr_receiver_ft8_122_88 sdr_receiver_wspr_122_88 sdr_receiver_hpsdr_122_88"

printf "%s\n" $PRJS | xargs -n 1 -P $JOBS -I {} make NAME={} bit

sudo sh scripts/alpine.sh
