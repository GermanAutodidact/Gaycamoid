REM Webcamoid, camera capture application.
REM Copyright (C) 2022  Gonzalo Exequiel Pedone
REM
REM Webcamoid is free software: you can redistribute it and/or modify
REM it under the terms of the GNU General Public License as published by
REM the Free Software Foundation, either version 3 of the License, or
REM (at your option) any later version.

@echo off
setlocal

if not "%GITHUB_SHA%" == "" set "GIT_COMMIT_HASH=%GITHUB_SHA%"
if not "%GITHUB_REF_NAME%" == "" set "GIT_BRANCH_NAME=%GITHUB_REF_NAME%"
if "%GIT_BRANCH_NAME%" == "" set "GIT_BRANCH_NAME=master"

git clone --depth 1 "https://github.com/webcamoid/DeployTools.git"
if errorlevel 1 exit /b 1

set "QTDIR=C:\Qt\%QTVER%\msvc2022_64"
set "TOOLSDIR=C:\Qt\Tools\QtCreator"
set "FFMPEG_PATH=%CD%\ffmpeg-%FFMPEG_VERSION%-full_build-shared"
set "PATH=%QTDIR%\bin;%TOOLSDIR%\bin;%FFMPEG_PATH%\bin;%PATH%"
set "INSTALL_PREFIX=%CD%\webcamoid-data"
set "PACKAGES_DIR=%CD%\webcamoid-packages\windows"
set "BUILD_PATH=%CD%\build"
set "PYTHONPATH=%CD%\DeployTools"

python DeployTools/deploy.py -d "%INSTALL_PREFIX%" -c "%BUILD_PATH%\package_info.conf" -o "%PACKAGES_DIR%"
if errorlevel 1 exit /b 1

if not exist "%PACKAGES_DIR%\*.exe" (
    echo NSIS installer was not generated.
    exit /b 1
)
if not exist "%PACKAGES_DIR%\*.zip" (
    echo ZIP package was not generated.
    exit /b 1
)

endlocal
