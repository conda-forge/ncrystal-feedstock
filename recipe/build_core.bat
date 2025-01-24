@REM NOTICE: Keep synchronized with with build_core.sh

setlocal eneableextensions
if errorlevel 1 echo Unable to enable extensions

mkdir %CD%\build_core

if %errorlevel% neq 0 exit /b %errorlevel%

set BLDDIR=%CD%\build_core

if %errorlevel% neq 0 exit /b %errorlevel%

cmake ^
    -B %BLDDIR% ^
    -S %CD%\src\ncrystal_core ^
    -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
    -DNCRYSTAL_ENABLE_DATA=EMBED ^
    -DNCRYSTAL_NOTOUCH_CMAKE_BUILD_TYPE=ON ^
    -DNCRYSTAL_MODIFY_RPATH=OFF ^
    %CMAKE_ARGS%

if %errorlevel% neq 0 exit /b %errorlevel%

cmake --build %BLDDIR% --config Release

if %errorlevel% neq 0 exit /b %errorlevel%

cmake --build %BLDDIR% --target install --config Release

if %errorlevel% neq 0 exit /b %errorlevel%
