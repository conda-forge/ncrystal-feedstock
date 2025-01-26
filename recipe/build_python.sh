#!/usr/bin/env bash
set -eux
${PYTHON} -m pip install "${SRC_DIR}/src/ncrystal_python" -vv --no-deps --no-build-isolation
