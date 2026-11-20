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

set "QTDIR=C:\Qt\%QTVER%\msvc2022_64"
set "TOOLSDIR=C:\Qt\Tools\QtCreator"

REM Find the installed Visual Studio 2022 C++ toolchain on the hosted runner.
set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
for /f "usebackq tokens=*" %%i in (`"%VSWHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do set "VSROOT=%%i"
if not defined VSROOT (
    echo Visual Studio 2022 C++ toolchain was not found.
    exit /b 1
)
call "%VSROOT%\VC\Auxiliary\Build\vcvarsall.bat" amd64
if errorlevel 1 exit /b 1

REM Locate FFmpeg's prefix because the release ZIP may include a top-level directory.
set "FFMPEG_DIR=%CD%\ffmpeg"
set "FFMPEG_PATH="
for /r "%FFMPEG_DIR%" %%F in (avcodec.h) do (
    if exist "%%~dpF..\..\lib\avcodec.lib" (
        for %%R in ("%%~dpF..\..") do set "FFMPEG_PATH=%%~fR"
    )
)
if not defined FFMPEG_PATH (
    echo FFmpeg headers or MSVC import libraries were not found. Run install_deps.bat first.
    exit /b 1
)

set "PATH_ORIG=%PATH%"
set "PATH=%QTDIR%\bin;%TOOLSDIR%\bin;%FFMPEG_PATH%\bin;%PATH%"

set "INSTALL_PREFIX=%CD%\webcamoid-data"
set "buildDir=build"
if not exist "%buildDir%" mkdir "%buildDir%"

set "CXXFLAGS=-I%FFMPEG_PATH%\include"
set "LDFLAGS=-L%FFMPEG_PATH%\lib -lavcodec -lavdevice -lavformat -lavutil -lswresample -lswscale"

if not "%DAILY_BUILD%" == "" (
    cmake -LA -S . -B "%buildDir%" -G "%CMAKE_GENERATOR%" -A x64 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="%INSTALL_PREFIX%" -DGIT_COMMIT_HASH="%GIT_COMMIT_HASH%" -DDAILY_BUILD=1
) else (
    cmake -LA -S . -B "%buildDir%" -G "%CMAKE_GENERATOR%" -A x64 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="%INSTALL_PREFIX%" -DGIT_COMMIT_HASH="%GIT_COMMIT_HASH%"
)
if errorlevel 1 exit /b 1

cmake --build "%buildDir%" --config Release
if errorlevel 1 exit /b 1
cmake --build "%buildDir%" --config Release --target install
if errorlevel 1 exit /b 1

endlocal
