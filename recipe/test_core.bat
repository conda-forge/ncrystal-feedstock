@REM NOTICE: Keep synchronized with with test_core.sh

setlocal eneableextensions
if errorlevel 1 echo Unable to enable extensions

ncrystal-config --help

if %errorlevel% neq 0 exit /b %errorlevel%

ncrystal-config -s

if %errorlevel% neq 0 exit /b %errorlevel%

cmake --find-package -DNAME=NCrystal -DCOMPILER_ID=GNU -DLANGUAGE=CXX -DMODE=EXIST

if %errorlevel% neq 0 exit /b %errorlevel%

@REM fixme stuff from ncrystal windows CI
