#!/usr/bin/env bash

# NOTICE: Keep synchronized with test_ncrystal.bat

set -eu

pip check
ncrystal-config --help
ncrystal-config -s
test -f $(ncrystal-config --show libpath)
test -f $(ncrystal-config --show shlibpath)
test -d $(ncrystal-config --show includedir)
test -f $(ncrystal-config --show includedir)/NCrystal/NCrystal.hh
test -f $(ncrystal-config --show includedir)/NCrystal/ncapi.h

${PYTHON} -c 'import NCrystal; NCrystal.test()'
${PYTHON} -mNCrystal.test cmdline
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

#Fixme: Also actually try to compile a downstream CMake project (there is one in
#./src/examples/downstream_cmake

# fixme pip show ncrystal, ncrystal-core, ncrystal-python commands

#fixme: also try to install a plugin and verify that it works?
