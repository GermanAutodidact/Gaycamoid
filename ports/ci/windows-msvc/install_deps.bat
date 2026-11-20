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

REM Install FFmpeg development headers and shared libraries.
set "FFMPEG_FILE=ffmpeg-%FFMPEG_VERSION%-full_build-shared.7z"
if not exist "%FFMPEG_FILE%" curl --retry 10 -kLOC - "https://www.gyan.dev/ffmpeg/builds/packages/%FFMPEG_FILE%"
if errorlevel 1 exit /b 1
if exist "%FFMPEG_FILE%" 7z x "%FFMPEG_FILE%" -aoa -bb
if errorlevel 1 exit /b 1

endlocal
