#! /bin/bash
#
# Script to build RISC-V ISA simulator, proxy kernel, and GNU toolchain.
# Tools will be installed to $RISCV.

if [ "x$RISCVBASE" = "x" ]
then
  echo "Please set the RISCVBASE environment variable to your preferred install path."
  exit 1
fi

if [ "x$RISCV_XLEN" = "x" ]
then
  echo "Please set RISCV_XLEN to 32 or 64 bits."
  exit 1
fi

export RISCV=${RISCVBASE}/${RISCV_XLEN}

. build-timberv.common

echo "Starting RISC-V Toolchain build process"

if ! [[ -d ${RISCVBASE} ]]; then
  mkdir -p ${RISCVBASE} || exit 1
else
  touch ${RISCVBASE}/.testfile || exit 1
  rm ${RISCVBASE}/.testfile
  mkdir -p ${RISCVBASE}/.testdir || exit 1
  rm -rf ${RISCVBASE}/.testdir
fi

if [ "${RISCV_XLEN}" = "32" ]
then
  RISCV_GNU_FLAGS="--with-arch=rv32ima --with-abi=ilp32"
  RISCV_ISA_SIM_FLAGS="--with-isa=rv32ima"
fi

update_opcodes
build_project ${RISCV_XLEN} riscv-openocd --enable-remote-bitbang --enable-jtag_vpi --disable-werror
build_project ${RISCV_XLEN} riscv-fesvr 
build_project ${RISCV_XLEN} riscv-isa-sim --with-fesvr=${RISCVBASE}/${RISCV_XLEN} ${RISCV_ISA_SIM_FLAGS} --enable-histogram
build_project ${RISCV_XLEN} riscv-gnu-toolchain ${RISCV_GNU_FLAGS}
if [ "${RISCV_XLEN}" = "64" ]
then
  build_project ${RISCV_XLEN} timberv-tag-tests --host=riscv${RISCV_XLEN}-unknown-elf
fi
make -C timberv-runtime RISCV_XLEN=${RISCV_XLEN}

echo -e "\\nRISC-V Toolchain installation completed!"
