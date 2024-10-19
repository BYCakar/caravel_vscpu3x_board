# Caravel VSCPU3x Board

This repo is a customized version of Caravel Board repo that provides examples for VSCPU3x.

Refer to [quickstart guide](vscpu3x_docs/Quickstart.md) for an example test environment.

## Firmware

You will need python 3.6 or later.  

To program Caravel, connect the evaluation board using a USB micro B connector.

Please make sure that you set the variables `TOOLCHAIN_PATH`, `TOOLCHAIN_PREFIX`, `ARCH` properly in the makefile, according to your RISC-V toolchain environment. 

```bash
pip3 install pyftdi

cd firmware/vscpu3x/vscpu3x_test

make clean flash
```

### Install Toolchain for Compiling Code

#### For Mac

https://github.com/riscv/homebrew-riscv

#### For Linux

https://github.com/riscv/riscv-gnu-toolchain

Or just check [installation notes](vscpu3x_docs/Installation.md) for easier installation!

### Diagnostics

Makefiles in the firmware project directories use 

> firmware/chipignite/util/caravel_hkflash.py 

to program the flash on the board through Caravel's housekeeping SPI interface.

> firmware/chipignite/util/caravel_hkdebug.py 

provides menu-driven debug through the housekeeping SPI interface for Caravel.

## Hardware

The current evaluation board for Caravel can be found at 
> hardware/development/caravel-dev-v5-M.2

- The clock is driven by X1 with a frequency of 10MHz. To drive the clock with custom frequnecy, disable X1 through J6 and use the external pin for `xclk`
- The voltage regulator U5 and U6 supply `1.8V` and `3.3V` through J8 and J9. The traces have to be cut if they are supplied externally.
- `vccd1` is connected to `1.8V` through J3. The trace has to be cut if it is supplied externally
- `vddio` is connected to `3.3V` through J5. The trace has to be cut if it is supplied externally

The most updated breakout board for Caravel can be found at 
> QFN   hardware/breakout/caravel-M.2-card-QFN
