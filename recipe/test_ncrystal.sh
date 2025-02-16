#!/usr/bin/env bash

# NOTICE: Keep synchronized with test_ncrystal.bat

set -eux

${PYTHON} -m pip list
${PYTHON} -m pip check
${PYTHON} -m pip show ncrystal-python
${PYTHON} -m pip show ncrystal-core
${PYTHON} -m pip show ncrystal

ncrystal-config --help
ncrystal-config -s

test -f "$(ncrystal-config --show libpath)"
test -f "$(ncrystal-config --show shlibpath)"
test -d "$(ncrystal-config --show includedir)"
test -f "$(ncrystal-config --show includedir)/NCrystal/NCrystal.hh"
test -f "$(ncrystal-config --show includedir)/NCrystal/ncrystal.h"
test -f "$(ncrystal-config --show includedir)/NCrystal/ncapi.h"

${PYTHON} -c 'import NCrystal; NCrystal.test()'
${PYTHON} -m "NCrystal.test" cmdline
nctool --help
ncrystal_cif2ncmat --help
ncrystal_endf2ncmat --help
ncrystal_hfg2ncmat --help
ncrystal_mcstasunion --help
ncrystal_ncmat2cpp --help
ncrystal_ncmat2hkl --help
ncrystal_vdos2ncmat --help
ncrystal_verifyatompos --help
nctool --test
cmake --find-package -DNAME=NCrystal -DCOMPILER_ID=GNU -DLANGUAGE=CXX -DMODE=EXIST

${PYTHON} -m pip install ncrystal-pypluginmgr -vv --no-deps --no-build-isolation
${PYTHON} -m pip check

${PYTHON} -m pip install "git+https://github.com/mctools/ncrystal@v${PKG_VERSION}#subdirectory=examples/plugin" -vv --no-deps --no-build-isolation
${PYTHON} -m pip check
ncrystal-pluginmanager --test DummyPlugin
nctool -d plugins::DummyPlugin/somefile.ncmat

${PYTHON} -m pip install "git+https://github.com/mctools/ncrystal@v${PKG_VERSION}#subdirectory=examples/plugin_dataonly" -vv --no-deps --no-build-isolation
${PYTHON} -m pip check
ncrystal-pluginmanager --test DummyDataPlugin
nctool -d plugins::DummyDataPlugin/dummy.ncmat

#Workaround for potentially missing gemmi on linux-aarch64:
#${PYTHON} -c 'import gemmi' || ${PYTHON} -m pip install gemmi

#FIXME should use: ${PYTHON} -m pip install "git+https://github.com/mctools/ncrystal@v${PKG_VERSION}#subdirectory=ncrystal_verify" -vv --no-deps --no-build-isolation
${PYTHON} -m pip install ncrystal-verify -vv --no-deps --no-build-isolation
${PYTHON} -m pip check
ncrystal-verify
