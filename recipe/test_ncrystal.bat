@REM NOTICE: Keep synchronized with test_ncrystal.sh

setlocal enableextensions
if errorlevel 1 echo Unable to enable extensions

%PYTHON% -m pip list

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -m pip check

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -m pip show ncrystal-python

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -m pip show ncrystal-core

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -m pip show ncrystal

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal-config --help

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal-config -s

@REM fixme test output of various ncrystal-config exists like in test_ncrystal.sh

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -c "import NCrystal; NCrystal.test()"

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -m "NCrystal.test" cmdline

if %errorlevel% neq 0 exit /b %errorlevel%

nctool --help

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal_cif2ncmat --help

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal_endf2ncmat --help

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal_hfg2ncmat --help

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal_mcstasunion --help

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal_ncmat2cpp --help

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal_ncmat2hkl --help

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal_vdos2ncmat --help

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal_verifyatompos --help

if %errorlevel% neq 0 exit /b %errorlevel%

nctool --test

if %errorlevel% neq 0 exit /b %errorlevel%

cmake --find-package -DNAME=NCrystal -DCOMPILER_ID=GNU -DLANGUAGE=CXX -DMODE=EXIST

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -m pip install ncrystal-pypluginmgr -vv --no-deps --no-build-isolation

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -m pip check

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -m pip install "git+https://github.com/mctools/ncrystal@v%PKG_VERSION%#subdirectory=examples/plugin" -vv --no-deps --no-build-isolation

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -m pip check

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal-pluginmanager --test DummyPlugin

if %errorlevel% neq 0 exit /b %errorlevel%

nctool -d "plugins::DummyPlugin/somefile.ncmat"

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -m pip install "git+https://github.com/mctools/ncrystal@v%PKG_VERSION%#subdirectory=examples/plugin_dataonly" -vv --no-deps --no-build-isolation

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -m pip check

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal-pluginmanager --test DummyDataPlugin

if %errorlevel% neq 0 exit /b %errorlevel%

nctool -d "plugins::DummyDataPlugin/dummy.ncmat"

if %errorlevel% neq 0 exit /b %errorlevel%

@REM Fixme Needed temporarily until ncrystal-verify ignores plugins:
%PYTHON% -m pip uninstall -y ncrystal-plugin-DummyDataPlugin
if %errorlevel% neq 0 exit /b %errorlevel%
%PYTHON% -m pip uninstall -y ncrystal-plugin-DummyPlugin
if %errorlevel% neq 0 exit /b %errorlevel%
%PYTHON% -m pip check
if %errorlevel% neq 0 exit /b %errorlevel%

@REM use %PYTHON% -m pip install "git+https://github.com/mctools/ncrystal@v%PKG_VERSION%#subdirectory=ncrystal_verify" -vv --no-deps --no-build-isolation
%PYTHON% -m pip install ncrystal-verify -vv --no-deps --no-build-isolation

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -m pip check

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal-verify

if %errorlevel% neq 0 exit /b %errorlevel%
