#!/usr/bin/env bash

# NOTICE: Keep synchronized with build_ncrystal.bat

set -eux
${PYTHON} -m pip install "${SRC_DIR}/src/ncrystal_metapkg" -vv --no-deps --no-build-isolation
