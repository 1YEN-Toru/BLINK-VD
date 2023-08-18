--------
# BLINK-VD
 This is a project for Xilinx Vivado.

 It blinks on-board LED of [Cmod A7](https://digilent.com/reference/programmable-logic/cmod-a7/start) FPGA board.

 You can see the explanations in Japanese from the following link.

- [Designing with RTL](http://hello.world.coocan.jp/ARDUINO15/arduino15_2.html)
- [Implementation on FPGA board (Cmod A7)](http://hello.world.coocan.jp/ARDUINO26/arduino26_6.html)

## Vivado project
 Vivado is the Integrated Development Environment (IDE) of Xilinx FPGAs.
 
- BLINKV.xpr

## RTL
 Register Transfer Level (RTL) Hardware Description Language (HDL).
 
- [blinkv.v](BLINKV.srcs/sources_1/blinkv.v)
- [blinkv_fsm.v](BLINKV.srcs/sources_1/blinkv_fsm.v)

## Constraint
 Constraints file for Xilinx Artix-7 XC7A35T.

- [blinkv.xdc](BLINKV.srcs/constrs_1/blinkv.xdc)

## Test bench
 Behavioral test bench for blinkv.

- [test.v](BLINKV.srcs/sim_1/test.v)

--------
# Demonstration movie
 Check out [YouTube](https://www.youtube.com/@cgch1) channel below.

- [Arduino FPGA Xilinx Vivado demo](https://www.youtube.com/watch?v=XDAk97i88ek)

--------
# Download
 Select "<>Code => Local => Download ZIP".

 Unzip down loaded file.

--------
# Disclaimer
 All data in this repository are unsupported and unguaranteed.

 Use at your own risk.

--------
