#!/usr/bin/env bash

# NOTICE: Keep synchronized with test_ncrystal.bat

set -eux

${PYTHON} -m pip list
${PYTHON} -m pip check
${PYTHON} -m pip show ncrystal-python
${PYTHON} -m pip show ncrystal-core
${PYTHON} -m pip show ncrystal

#To avoid the ncrystal packages becoming gargantuan (~megabytes as opposed to to
#kilobytes), we fetch the code manually again (rather silly, but so is 2MB
#metapackages!)
git clone --depth 1 --branch "v${PKG_VERSION}" "https://github.com/mctools/ncrystal" ./src2

${PYTHON} ./src2/devel/bin/ncdevtool verifytag -t "${PKG_VERSION}" --fail-if-devel -p 'X.Y.Z' --file-verify=VERSION
${PYTHON} ./src2/devel/bin/ncdevtool check -n fixme

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

test -f ./src2/ncrystal_pypluginmgr/pyproject.toml
test -f ./src2/examples/plugin/pyproject.toml

${PYTHON} -m pip install ./src2/ncrystal_pypluginmgr -vv --no-deps --no-build-isolation
${PYTHON} -m pip check
${PYTHON} -m pip install ./src2/examples/plugin -vv --no-deps --no-build-isolation
${PYTHON} -m pip check

export NCRYSTAL_PLUGIN_RUNTESTS=1
export NCRYSTAL_REQUIRED_PLUGINS=DummyPlugin
nctool --plugins
unset NCRYSTAL_PLUGIN_RUNTESTS
unset NCRYSTAL_REQUIRED_PLUGINS
nctool -d plugins::DummyPlugin/somefile.ncmat

${PYTHON} -m pip install ./src2/examples/plugin_dataonly -vv --no-deps --no-build-isolation
${PYTHON} -m pip check
nctool -d plugins::DummyDataPlugin/dummy.ncmat

#Finally run CTests as an extra platform validation:
#(workaround for missing gemmi on linux-aarch64):
${PYTHON} -c 'import gemmi' || pip install gemmi
${PYTHON} ./src2/devel/bin/ncdevtool cmake
