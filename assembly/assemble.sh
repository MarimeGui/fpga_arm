#! /bin/bash

arm-none-eabi-as -march=armv7 program.s -o compile.o
arm-none-eabi-objcopy -O binary -j .text compile.o rawcompiled
