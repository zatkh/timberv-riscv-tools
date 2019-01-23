#!/bin/bash

PATCHDIR=$PWD/patches

# Init all submodules
git submodule update --init --recursive

# Prepare riscv-gnu-toolchain:
# * checkout correct versions of submodules
# * apply patch
pushd riscv-gnu-toolchain/
git checkout 691e4e826251c7ec59f883cab18440c87baf45e7
  pushd riscv-binutils-gdb/
  git checkout 8bfcd4c90d3f9f93cacd29344d7cf81f0474ccfe
  git apply ${PATCHDIR}/riscv-binutils-gdb_8bfcd4c90d3f9f93cacd29344d7cf81f0474ccfe.patch
  popd

  pushd riscv-gcc/
  git fetch origin heads/riscv-gcc-7.3.0
  git checkout riscv-gcc-7.3.0
  popd
popd
