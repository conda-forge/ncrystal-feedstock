#!/usr/bin/env bash

# NOTICE: Keep synchronized with test_core.bat

set -eux

ncrystal-config --help
ncrystal-config -s
test -f $(ncrystal-config --show libpath)
test -f $(ncrystal-config --show shlibpath)
test -d $(ncrystal-config --show includedir)
cmake --find-package -DNAME=NCrystal -DCOMPILER_ID=GNU -DLANGUAGE=CXX -DMODE=EXIST

test -f ./src/examples/downstream_cmake/CMakeLists.txt

mkdir -p ./build_ds
cmake \
    -S ./src/examples/downstream_cmake \
    -B ./build_ds \
    ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=./install_ds

cmake --build ./build_ds --config Release
cmake --install ./build_ds

ls -l ./install_ds || true
ls -l ./install_ds/bin || true
tree ./install_ds || true
test -f ./install_ds/bin/testapp

./install_ds/bin/testapp
