@REM NOTICE: Keep synchronized with build_ncrystal.sh

setlocal enableextensions
if errorlevel 1 echo Unable to enable extensions

%PYTHON% -m pip install %CD%\src\ncrystal_metapkg -vv --no-deps --no-build-isolation

if %errorlevel% neq 0 exit /b %errorlevel%
