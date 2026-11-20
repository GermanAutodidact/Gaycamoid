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

REM Install Qt for the Visual Studio 2022 x64 toolchain.
aqt install-qt windows desktop "%QTVER%" win64_msvc2022_64 -O "C:\Qt"
if errorlevel 1 exit /b 1

REM Install Qt Creator deployment utilities.
aqt install-tool windows desktop tools_qtcreator -O "C:\Qt"
if errorlevel 1 exit /b 1

set "QTDIR=C:\Qt\%QTVER%\msvc2022_64"
set "TOOLSDIR=C:\Qt\Tools\QtCreator"
set "PATH=%QTDIR%\bin;%TOOLSDIR%\bin;%PATH%"

REM Install FFmpeg 8.0.1 MSVC x64 shared GPL binaries and development files.
set "FFMPEG_TAG=ffmpeg-8.0.1-r3"
set "FFMPEG_FILE=%FFMPEG_TAG%_x64-windows-shared-gpl.zip"
set "FFMPEG_URL=https://github.com/System233/ffmpeg-msvc-prebuilt/releases/download/%FFMPEG_TAG%/%FFMPEG_FILE%"
set "FFMPEG_SHA256=3399afab045f6bc64301001d4f5ca1aba3d6df96948cc1799028cf2f24ede433"
set "FFMPEG_DIR=ffmpeg-%FFMPEG_VERSION%-full_build-shared"

if not exist "%FFMPEG_FILE%" curl --fail --location --retry 10 --output "%FFMPEG_FILE%" "%FFMPEG_URL%"
if errorlevel 1 exit /b 1

REM Verify the published SHA-256 checksum before extraction.
powershell -NoProfile -Command "$actual = (Get-FileHash -LiteralPath '%FFMPEG_FILE%' -Algorithm SHA256).Hash; if ($actual -ne '%FFMPEG_SHA256%') { Write-Error 'FFmpeg SHA-256 mismatch'; exit 1 }"
if errorlevel 1 exit /b 1

if not exist "%FFMPEG_DIR%" mkdir "%FFMPEG_DIR%"
7z x "%FFMPEG_FILE%" -o"%FFMPEG_DIR%" -aoa -bb
if errorlevel 1 exit /b 1

endlocal
