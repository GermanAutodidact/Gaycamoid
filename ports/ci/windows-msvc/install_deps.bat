REM Webcamoid, camera capture application.
REM Copyright (C) 2022  Gonzalo Exequiel Pedone
REM
REM Webcamoid is free software: you can redistribute it and/or modify
REM it under the terms of the GNU General Public License as published by
REM the Free Software Foundation, either version 3 of the License, or
REM (at your option) any later version.

setlocal
python -m pip install --upgrade pip
if errorlevel 1 exit /b 1
python -m pip install aqtinstall
if errorlevel 1 exit /b 1

REM Install Qt for the Visual Studio 2022 x64 toolchain, including Qt Multimedia.
aqt install-qt windows desktop "%QTVER%" win64_msvc2022_64 -m qtmultimedia -O "C:\Qt"
if errorlevel 1 exit /b 1

REM Verify that the CMake package required by libAvKys/Lib/CMakeLists.txt is present.
if not exist "C:\Qt\%QTVER%\msvc2022_64\lib\cmake\Qt6Multimedia\Qt6MultimediaConfig.cmake" (
    echo Qt Multimedia was not installed; Qt6MultimediaConfig.cmake is missing.
    exit /b 1
)

REM Install Qt Creator deployment utilities.
aqt install-tool windows desktop tools_qtcreator -O "C:\Qt"
if errorlevel 1 exit /b 1

set "QTDIR=C:\Qt\%QTVER%\msvc2022_64"
set "TOOLSDIR=C:\Qt\Tools\QtCreator"
set "PATH=%QTDIR%\bin;%TOOLSDIR%\bin;%PATH%"

REM Install FFmpeg 8.0.1 MSVC x64 shared GPL binaries and development files.
set "FFMPEG_TAG=ffmpeg-8.0.1-r3"
set "FFMPEG_FILE=%FFMPEG_TAG%_x64-windows-shared-gpl-develop.zip"
set "FFMPEG_URL=https://github.com/System233/ffmpeg-msvc-prebuilt/releases/download/%FFMPEG_TAG%/%FFMPEG_FILE%"
set "FFMPEG_DIR=%CD%\ffmpeg"

if not exist "%FFMPEG_FILE%" curl --fail --location --retry 10 --output "%FFMPEG_FILE%" "%FFMPEG_URL%"
if errorlevel 1 exit /b 1

REM The develop archive contains the headers and MSVC import libraries required to compile.
if exist "%FFMPEG_DIR%" rmdir /s /q "%FFMPEG_DIR%"
mkdir "%FFMPEG_DIR%"
if errorlevel 1 exit /b 1
7z x "%FFMPEG_FILE%" -o"%FFMPEG_DIR%" -aoa -bb
if errorlevel 1 exit /b 1

REM Fail early if the archive did not contain the expected development files.
set "FFMPEG_FOUND="
for /r "%FFMPEG_DIR%" %%F in (avcodec.h) do (
    if exist "%%~dpF..\..\lib\avcodec.lib" set "FFMPEG_FOUND=1"
)
if not defined FFMPEG_FOUND (
    echo FFmpeg development headers or MSVC import libraries were not found in the archive.
    exit /b 1
)

endlocal
