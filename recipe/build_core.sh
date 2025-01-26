#!/usr/bin/env bash
set -eux
mkdir -p build_core

#NOTICE: Keep synchronized with build_core.bat

test -f "${SRC_DIR}/src/ncrystal_core/include/NCrystal/NCrystal.hh"

echo "TKTEST DOLLAR-PYTHON: ${PYTHON:-undefined}"
echo "TKTEST DOLLAR-CONDA_PREFIX: ${CONDA_PREFIX:-undefined}"
echo "TKTEST ls DOLLAR-CONDA_PREFIX/bin:"
ls -l ${CONDA_PREFIX:-undefined}/bin

cmake \
    -B ./build_core \
    -S "${SRC_DIR}/src/ncrystal_core" \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_BUILD_TYPE=Release \
    -DNCRYSTAL_ENABLE_DATA=EMBED \
    -DNCRYSTAL_NOTOUCH_CMAKE_BUILD_TYPE=ON \
    -DNCRYSTAL_MODIFY_RPATH=OFF \
    ${CMAKE_ARGS}

cmake --build ./build_core --config Release --parallel ${CPU_COUNT:-2}
cmake --install ./build_core
