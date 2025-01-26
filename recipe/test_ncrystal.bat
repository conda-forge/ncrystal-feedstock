@REM NOTICE: Keep synchronized with test_ncrystal.sh

setlocal eneableextensions
if errorlevel 1 echo Unable to enable extensions

ncrystal-config --help

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal-config -s

if %errorlevel% neq 0 exit /b %errorlevel%

pip check

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -c "import NCrystal; NCrystal.test()"

if %errorlevel% neq 0 exit /b %errorlevel%

%PYTHON% -mNCrystal.test cmdline

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

@REM fixme stuff from ncrystal windows CI
@REM fixme downstream cmake project
@REM fixme pip show ncrystal, ncrystal-core, ncrystal-python commands
