![TIMBER-V Toolchain](logo/timberv_logo.png)

TIMBER-V Toolchain
==================

TIMBER-V is a novel protection mechanism for small RISC-V processors,
combining traditional MPU isolation with fine-grained and flexible tag
isolation. This allows to create tiny enclaves within MPU-isolated tasks.
Enclave memory is tightly interleaved with the application task, thus
reducing overall memory fragmentation.

This repo provides the TIMBER-V toolchain with all source code.
We open-source all the code to make TIMBER-V accessible to the research
community and provide a basis for transparent performance evaluation.

Disclaimer: All code is proof-of-concept without proper code review,
so use it at your own risk! Have fun!

# Getting started
Read the original RISC-V [README](README-RISC-V.md) for details about
the RISC-V toolchain this project is based on.

## Important folders

TIMBER-V is based on the following folders:

| Folder                | Description                                  |
|-----------------------|----------------------------------------------|
| `riscv-opcodes`       | Opcodes including TIMBER-V instructions      |
| `riscv-isa-sim`       | Spike simulator with TIMBER-V support        |
| `riscv-fesvr`         | Front-end server                             |
| `riscv-openocd`       | Openocd for debugging Spike with GDB         |
| `riscv-gnu-toolchain` | Gnu binutils for compiling TIMBER-V programs |
| `timberv-runtime`     | TIMBER-V software stack running on Spike     |
| `timberv-tag-tests`   | Standalone tests for some TIMBER-V features  |

The folders `riscv-pk` and `riscv-tests` are not needed for TIMBER-V.

## Preparation
To initialize and prepare all sub-repositories, execute `init_submodules.sh`. 
While most sub-repositories are directly linked to the correct commit,
the `riscv-gnu-toolchain` is not. Instead, the script manually checks out
the appropriate commits and applies appropriate patches.

## Build from scratch
To build everything from scratch, set the environment variables
`RISCVBASE=/opt/riscv` and `RISCV_XLEN=32`, before executing
`build-timberv.sh`.

Note that `timberv-tag-tests` do not work in 32-bit mode. To build it,
use `RISCV_XLEN=64`.

## Install pre-built binaries
To avoid long compilation times, you can install pre-built binaries from
[here](https://github.com/sam1013/timberv-riscv-tools/releases/tag/v1.0.0).
This covers Spike, openocd as well as GNU binutils.
Pre-built binaries are tested under Ubuntu 16.04.

## Run
To use the TIMBER-V toolchain, add `/opt/riscv/32/bin` or `/opt/riscv/64/bin`
to your `PATH`.

# References
* Weiser, S., Werner, M., Brasser, F., Malenko, M., Mangard, S. and Sadeghi, A-R. (2019).
  TIMBER-V: Tag-Isolated Memory Bringing Fine-grained Enclaves to RISC-V.
  In Network and Distributed System Security Symposium (NDSS) 2019.
