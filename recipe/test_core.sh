#!/usr/bin/env bash

# NOTICE: Keep synchronized with test_core.bat

set -eux

ncrystal-config --help
ncrystal-config -s
test -f "$(ncrystal-config --show libpath)"
test -f "$(ncrystal-config --show shlibpath)"
test -d "$(ncrystal-config --show includedir)"
test -f "$(ncrystal-config --show includedir)/NCrystal/NCrystal.hh"
test -f "$(ncrystal-config --show includedir)/NCrystal/ncrystal.h"
test -f "$(ncrystal-config --show includedir)/NCrystal/ncapi.h"
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

test -f ./install_ds/bin/testapp

./install_ds/bin/testapp
