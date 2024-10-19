# Installation
**Dev Note:** _It has been more than a year since I installed my environment, by building [riscv-gnu-toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain) repo, but after one year only God knows how I did this :D. However, I found an easier way to install RISC-V toolchain so no need to worry :)_

To install RISC-V toolchain, download [xpack-riscv-none-elf-gcc-12.2.0-3](https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/tag/v12.2.0-3/) and extract it in a proper directory in your system. 

Then the only thing you need to do is change two variables in the makefile that you are going to use.

```Makefile
TOOLCHAIN_PATH=/path/to/your/xpack-riscv-none-elf-gcc-12.2.0-3/bin/

TOOLCHAIN_PREFIX=riscv-none-elf
```
Now you are ready to use RISC-V toolchain!

**Dev Note Again:** _If you want to build your toolchain from riscv-gnu-toolchain repo, please make sure that you build `rv32i_zicsr` architecture, since `rv32i` architecture will cause error while compiling applications for Caravel._