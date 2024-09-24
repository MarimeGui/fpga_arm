#! /bin/bash

# Assemble program to object file, raw binary machine code, and to textual hex file

mkdir -p out
arm-none-eabi-as -march=armv7 program.s -o out/program.o
arm-none-eabi-objcopy -O binary -j .text out/program.o out/program.bin
python to_hex.py out/program.bin out/program.hex
