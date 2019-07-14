# !/bin/bash

MODE=$1

export RISCV=/opt/riscv/$MODE
export PATH=$PATH:$RISCV/bin
export RISCVBASE=/opt/riscv
export RISCV_XLEN=$MODE #tests won't work in 32
