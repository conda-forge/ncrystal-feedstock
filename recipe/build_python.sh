#!/usr/bin/env bash
set -eux
test -f "${SRC_DIR}/src/ncrystal_python/pyproject.toml"
${PYTHON} -m pip install "${SRC_DIR}/src/ncrystal_python" -vv --no-deps --no-build-isolation
