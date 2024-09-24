# ARM FPGA Core
Verilog implementation of a Cortex-M3-like ARM core.

32-bit, Little-endian, `armv7`

## Assemble
User can write the assembly code to be run in the `assembly/program.s` file.

In order to assemble, users need to install `python` along with :
- `gcc-arm-none-eabi` on Ubuntu-based systems
- `arm-none-eabi-gcc` on Arch-based systems

Then, proceed to run the `assembly/assemble.sh` script. Output is reviewable by running `assembly/print.sh`.
