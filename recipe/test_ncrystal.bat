@REM NOTICE: Keep synchronized with test_ncrystal.sh

setlocal eneableextensions
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

@REM see comments in test_ncrystal.sh for why we clone:
git clone --depth 1 --branch "v%PKG_VERSION%" "https://github.com/mctools/ncrystal" .\src2

%PYTHON% %CD%\src2\devel\bin\ncdevtool verifytag -t "%PKG_VERSION%" --fail-if-devel -p "X.Y.Z" --file-verify=VERSION

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% %CD%\src2\devel\bin\ncdevtool check -n fixme

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal-config --help

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal-config -s

@REM fixme test output of various ncrystal-config exists like in test_ncrystal.sh

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -c "import NCrystal; NCrystal.test()"

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% "-mNCrystal.test" cmdline

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

%PYTHON% -m pip install %CD%\src2\ncrystal_pypluginmgr -vv --no-deps --no-build-isolation
if %errorlevel% neq 0 exit /b %errorlevel%
%PYTHON% -m pip check
if %errorlevel% neq 0 exit /b %errorlevel%
%PYTHON% -m pip install %CD%\src2\examples\plugin -vv --no-deps --no-build-isolation
if %errorlevel% neq 0 exit /b %errorlevel%
%PYTHON% -m pip check
if %errorlevel% neq 0 exit /b %errorlevel%

if NOT EXIST %CD%\src2\ncrystal_pypluginmgr\pyproject.toml exit /b 1

if NOT EXIST %CD%\src2\examples\plugin\pyproject.toml exit /b 1

set "NCRYSTAL_PLUGIN_RUNTESTS=1"
if %errorlevel% neq 0 exit /b %errorlevel%
set "NCRYSTAL_REQUIRED_PLUGINS=DummyPlugin"
if %errorlevel% neq 0 exit /b %errorlevel%
nctool --plugins
if %errorlevel% neq 0 exit /b %errorlevel%
set "NCRYSTAL_PLUGIN_RUNTESTS="
if %errorlevel% neq 0 exit /b %errorlevel%
set "NCRYSTAL_REQUIRED_PLUGINS="
if %errorlevel% neq 0 exit /b %errorlevel%
nctool -d "plugins::DummyPlugin/somefile.ncmat"
if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -m pip install %CD%\src2\examples\plugin_dataonly -vv --no-deps --no-build-isolation
if %errorlevel% neq 0 exit /b %errorlevel%
%PYTHON% -m pip check
if %errorlevel% neq 0 exit /b %errorlevel%
nctool -d "plugins::DummyDataPlugin/dummy.ncmat"
if %errorlevel% neq 0 exit /b %errorlevel%

@REM fixme stuff from ncrystal windows CI
@REM fixme downstream cmake project

@REM #Finally run CTests:
%PYTHON% %CD%\src2\devel\bin\ncdevtool cmake
