#!/usr/bin/env bash

# NOTICE: Keep synchronized with test_core.bat

set -eu

ncrystal-config --help
ncrystal-config -s
test -f $(ncrystal-config --show libpath)
test -f $(ncrystal-config --show shlibpath)
test -d $(ncrystal-config --show includedir)
cmake --find-package -DNAME=NCrystal -DCOMPILER_ID=GNU -DLANGUAGE=CXX -DMODE=EXIST

#fixme: Also actually build downstream cmake project.
