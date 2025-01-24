#!/bin/bash
set -eux
test -f "${SRC_DIR}/src/ncrystal_python/pyproject.toml"
python -m pip install "${SRC_DIR}/src/ncrystal_python" -vv --no-deps --no-build-isolation
