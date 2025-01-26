#!/usr/bin/env bash
set -eux
test -f "${SRC_DIR}/src/ncrystal_python/pyproject.toml"

echo "TKTEST DOLLAR-PYTHON: ${PYTHON:-undefined}"
echo "TKTEST DOLLAR-CONDA_PREFIX: ${CONDA_PREFIX:-undefined}"
echo "TKTEST DOLLAR-PREFIX: ${PREFIX:-undefined}"
echo "TKTEST ls DOLLAR-CONDA_PREFIX/bin:"
if [ -d ${CONDA_PREFIX:-undefined}/bin ]; then
    ls -l ${CONDA_PREFIX:-undefined}/bin
fi
echo "TKTEST ls DOLLAR-PREFIX/bin:"
if [ -d ${PREFIX:-undefined}/bin ]; then
    ls -l ${PREFIX:-undefined}/bin
fi
echo "TKTEST which python"
which python

#was ${PYTHON} -m pip install "${SRC_DIR}/src/ncrystal_python" -vv --no-deps --no-build-isolation
pip install "${SRC_DIR}/src/ncrystal_python" -vv --no-deps --no-build-isolation

${PYTHON} -c 'print("TKTEST hello")'
