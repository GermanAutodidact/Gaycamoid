# Webcamoid, camera capture application.
# Copyright (C) 2021  Gonzalo Exequiel Pedone
#
# Webcamoid is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Webcamoid is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Webcamoid. If not, see <http://www.gnu.org/licenses/>.
#
# Web-Site: http://webcamoid.github.io/

# Prevent Windows headers from defining the min and max macros.
if (WIN32)
    add_definitions(-DNOMINMAX)
endif ()

set(QT_VERSION_MAJOR 6 CACHE STRING "Qt version to compile with")
set(QT_MINIMUM_VERSION 6.2 CACHE INTERNAL "")

if (APPLE)
    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_OSX_DEPLOYMENT_TARGET 12.3)
else ()
    set(CMAKE_CXX_STANDARD 11)
endif ()

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(VER_MAJ 9)
set(VER_MIN 4)
set(VER_PAT 0)
set(VERSION ${VER_MAJ}.${VER_MIN}.${VER_PAT})

set(DAILY_BUILD OFF CACHE BOOL "Mark this as a daily build")
set(STATIC_BUILD OFF CACHE BOOL "Build Webcamoid statically")
set(STATIC_LIBGCC OFF CACHE BOOL "Build with static GCC libraries")
set(ORGANIZATION_IDENTIFIER "io.github.webcamoid" CACHE STRING "Organization identifier")
set(APP_IDENTIFIER "${ORGANIZATION_IDENTIFIER}.Webcamoid" CACHE STRING "Application identifier")
set(WITH_FLATPAK_VCAM ON CACHE BOOL "Enable support for the virtual camera in Flatpak")
set(ANDROID_OPENSSL_SUFFIX "_3" CACHE STRING "Set OpenSSL libraries suffix")
set(ENABLE_ANDROID_DEBUGGING OFF CACHE BOOL "Enable debugging logs in Android")
set(ENABLE_ANDROID_LOG_FILE OFF CACHE BOOL "Enable debugging logs in Android")
set(ENABLE_IPO OFF CACHE BOOL "Enable interprocedural optimization")
set(NOCHECKUPDATES OFF CACHE BOOL "Disable updates check")
set(NOOPENMP OFF CACHE BOOL "Disable OpenMP support")
set(NOALSA OFF CACHE BOOL "Disable ALSA support")
set(NODSHOW OFF CACHE BOOL "Disable DirectShow support")
set(NOFFMPEG OFF CACHE BOOL "Disable FFmpeg support")
set(NOFFMPEGSCREENCAP OFF CACHE BOOL "Disable FFmpeg screen capture support")
set(NOLIBAVDEVICE OFF CACHE BOOL "Disable libavdevice support in FFmpeg")
set(NOLIBUSB OFF CACHE BOOL "Disable libusb  support")
set(NOMEDIAFOUNDATION OFF CACHE BOOL "Disable Microsoft Media Foundation support")
set(NONDKAUDIO OFF CACHE BOOL "Disable Android NDK audio support")
set(NONDKCAMERA OFF CACHE BOOL "Disable Android NDK camera capture support")
set(NOPIPEWIRE OFF CACHE BOOL "Disable Pipewire support")
set(NOPORTAUDIO OFF CACHE BOOL "Disable PortAudio support")
set(NOPULSEAUDIO OFF CACHE BOOL "Disable PulseAudio support")
set(NOQTCAMERA OFF CACHE BOOL "Disable video capture using QCamera support")
set(NOQTSCREENCAPTURE OFF CACHE BOOL "Disable screen capture using QScreenCapture")
set(NOSCREENCAPTURE OFF CACHE BOOL "Disable screen capture")
set(NOV4L2 OFF CACHE BOOL "Disable V4L2 support")
set(NOV4LUTILS OFF CACHE BOOL "Disable V4l-utils support")
set(NOVIDEOEFFECTS OFF CACHE BOOL "No build video effects")
set(NOWASAPI OFF CACHE BOOL "Disable WASAPI support")
set(NOWLROOTS OFF CACHE BOOL "Disable Wayland capture support using wlroots protocol")
set(NOXLIBSCREENCAP OFF CACHE BOOL "Disable screen capture using Xlib")
set(SHOWCASE_MODE OFF CACHE BOOL "Enable this option when you want to take good screenshots of the program")

# SIMD optimizations
set(NOSIMDMMX OFF CACHE BOOL "Disable MMX SIMD optimizations")
set(NOSIMDSSE OFF CACHE BOOL "Disable SSE SIMD optimizations")
set(NOSIMDSSE2 OFF CACHE BOOL "Disable SSE2 SIMD optimizations")
set(NOSIMDSSE4_1 OFF CACHE BOOL "Disable SSE4.1 SIMD optimizations")
set(NOSIMDAVX OFF CACHE BOOL "Disable AVX SIMD optimizations")
set(NOSIMDAVX2 OFF CACHE BOOL "Disable AVX2 SIMD optimizations")
set(NOSIMDNEON OFF CACHE BOOL "Disable NEON SIMD optimizations")
set(NOSIMDSVE OFF CACHE BOOL "Disable SVE SIMD optimizations")
set(NOSIMDRVV OFF CACHE BOOL "Disable RVV SIMD optimizations")

# Dynamic libraries load
set(PIPEWIRE_DYNLOAD OFF CACHE BOOL "Load PipeWire libraries on runtime instead of linking")
set(PULSEAUDIO_DYNLOAD OFF CACHE BOOL "Load PulseAudio libraries on runtime instead of linking")

# Ads configurations
set(ENABLE_ANDROID_ADS OFF CACHE BOOL "Enable Android AdMob")
set(ANDROID_AD_APPID "ca-app-pub-3940256099942544~3347511713" CACHE STRING "Android application ID")
set(ANDROID_AD_UNIT_ID_APP_OPEN "ca-app-pub-3940256099942544/9257395921" CACHE STRING "Android app open unit ID")
set(ANDROID_AD_UNIT_ID_BANNER "ca-app-pub-3940256099942544/6300978111" CACHE STRING "Android banner unit ID")
set(ANDROID_AD_UNIT_ID_ADAPTIVE_BANNER "ca-app-pub-3940256099942544/9214589741" CACHE STRING "Android adaptive banner unit ID")
set(ANDROID_AD_UNIT_ID_ADAPTIVE_INTERSTITIAL "ca-app-pub-3940256099942544/1033173712" CACHE STRING "Android adaptive interstitial unit ID")
set(ANDROID_AD_UNIT_ID_ADAPTIVE_REWARDED "ca-app-pub-3940256099942544/5224354917" CACHE STRING "Android adaptive rewarded unit ID")
set(ANDROID_AD_UNIT_ID_ADAPTIVE_REWARDED_INTERSTITIAL "ca-app-pub-3940256099942544/5354046379" CACHE STRING "Android adaptive rewarded interstitial unit ID")

set(ANDROIDX_CORE_VERSION "1.16.0" CACHE STRING "androidx.core:core version")
set(ANDROIDX_ANNOTATION_VERSION "1.9.1" CACHE STRING "androidx.annotation:annotation version")
set(GOOGLE_PLAY_SERVICES_ADS_VERSION "24.0.0" CACHE STRING "com.google.android.gms:play-services-ads-lite version")

# Allow to build Webcamoid in Linux and other POSIX systems as if you were
# building it for APPLE
set(FAKE_APPLE OFF CACHE BOOL "Build the virtual camera plugin for MacOs in Linux and other POSIX systems as if you were building it for MacOS")

if (FAKE_APPLE)
    add_definitions(-DFAKE_APPLE)
endif ()

if (APPLE OR FAKE_APPLE)
    set(BUILDDIR build)
    set(EXECPREFIX Webcamoid.app/Contents)
    set(BINDIR ${EXECPREFIX}/MacOS)
    set(LIBDIR ${EXECPREFIX}/Frameworks)
    set(PLUGINSDIR ${EXECPREFIX}/Plugins)
    set(AKPLUGINSDIR ${PLUGINSDIR}/avkys)
    set(DATAROOTDIR ${EXECPREFIX}/Resources)
    set(QMLDIR ${DATAROOTDIR}/qt/qml)
    set(LICENSEDIR ${DATAROOTDIR})
    set(TRANSLATIONSDIR ${DATAROOTDIR}/translations)
    set(JARDIR ${DATAROOTDIR}/java)
elseif (ANDROID)
    set(BUILDDIR android-build)
    set(EXECPREFIX "")
    set(BINDIR libs/${CMAKE_ANDROID_ARCH_ABI})
    set(LIBDIR ${BINDIR})
    set(PLUGINSDIR ${BINDIR})
    set(AKPLUGINSDIR ${PLUGINSDIR})
    set(DATAROOTDIR assets)
    set(QMLDIR ${DATAROOTDIR}/qt/qml)
    set(LICENSEDIR ${DATAROOTDIR})
    set(TRANSLATIONSDIR ${DATAROOTDIR}/translations)
    set(JARDIR libs)
else ()
    include(GNUInstallDirs)
    set(BUILDDIR build)
    set(EXECPREFIX "")
    set(BINDIR ${CMAKE_INSTALL_BINDIR})
    set(LIBDIR ${CMAKE_INSTALL_LIBDIR})
    set(PLUGINSDIR ${CMAKE_INSTALL_LIBDIR}/qt/plugins CACHE FILEPATH "Plugins install directory")
    set(AKPLUGINSDIR ${PLUGINSDIR}/avkys)
    set(QMLDIR ${CMAKE_INSTALL_LIBDIR}/qt/qml CACHE FILEPATH "Qml install directory")
    set(DATAROOTDIR ${CMAKE_INSTALL_DATAROOTDIR})
    set(LICENSEDIR ${DATAROOTDIR}/licenses/webcamoid)
    set(TRANSLATIONSDIR ${DATAROOTDIR}/webcamoid/translations)
    set(OUTPUT_PULSEAUDIO_MODULES_DIR ${LIBDIR}/pulseaudio)
    set(OUTPUT_PIPEWIRE_MODULES_DIR ${LIBDIR}/pipewire)
    set(OUTPUT_PIPEWIRE_SPA_PLUGINS_DIR ${LIBDIR}/pipewire-spa)
    set(JARDIR ${DATAROOTDIR}/java)
endif ()

if (NOT NOLIBWEBM)
    find_file(WEBMIDS_H webm/common/webmids.h)
    if (WEBMIDS_H)
        string(REPLACE /common/webmids.h "" LIBWEBM_INCLUDE_DIRS_DEFAULT "${WEBMIDS_H}")
    endif ()
endif ()

set(LIBWEBM_INCLUDE_DIRS "${LIBWEBM_INCLUDE_DIRS_DEFAULT}" CACHE PATH "libwebm headers files search directory")
set(LIBWEBM_LIBRARY_DIRS "" CACHE PATH "libwebm library files search directory")

add_definitions(-DQT_DEPRECATED_WARNINGS)

if (DAILY_BUILD)
    add_definitions(-DDAILY_BUILD)
endif ()

if (WITH_FLATPAK_VCAM)
    add_definitions(-DWITH_FLATPAK_VCAM)
endif ()

set(GIT_COMMIT_HASH "" CACHE STRING "Set the alternative commit hash if not detected by git")
find_program(GIT_BIN git)
if (GIT_BIN)
    execute_process(COMMAND ${GIT_BIN} rev-parse HEAD WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}" OUTPUT_VARIABLE GIT_COMMIT_HASH_RESULT OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_QUIET)
endif ()
if ("${GIT_COMMIT_HASH_RESULT}" STREQUAL "")
    set(GIT_COMMIT_HASH_RESULT "${GIT_COMMIT_HASH}")
endif ()
if (NOT "${GIT_COMMIT_HASH_RESULT}" STREQUAL "")
    add_definitions(-DGIT_COMMIT_HASH="${GIT_COMMIT_HASH_RESULT}")
endif ()

# Force prefix and suffix. This fixes broken MinGW builds in CI environments.
if (WIN32 AND NOT MSVC)
    set(CMAKE_STATIC_LIBRARY_PREFIX "lib")
    set(CMAKE_STATIC_LIBRARY_SUFFIX ".a")
    set(CMAKE_SHARED_LIBRARY_PREFIX "lib")
    set(CMAKE_IMPORT_LIBRARY_PREFIX "lib")
    set(CMAKE_IMPORT_LIBRARY_SUFFIX ".dll.a")
    set(CMAKE_LINK_LIBRARY_SUFFIX "")
endif ()

set(PULSEAUDIO_MODULES_PATH "${OUTPUT_PULSEAUDIO_MODULES_DIR}" CACHE PATH "PulseAudio modules search path")
set(PIPEWIRE_MODULES_PATH "${OUTPUT_PIPEWIRE_MODULES_DIR}" CACHE PATH "PipeWire modules search path")
set(PIPEWIRE_SPA_PLUGINS_PATH "${OUTPUT_PIPEWIRE_SPA_PLUGINS_DIR}" CACHE PATH "PipeWire SPA plugins search path")

find_package(PkgConfig)

set(EXTRA_SUDOER_TOOL_DIR "" CACHE PATH "Additional sudoer tool search directory")
set(EXTRA_KERNEL_MODULES_DIR "" CACHE PATH "Additional kernel modules search directory")
set(QML_IMPORT_PATH "${CMAKE_SOURCE_DIR}/libAvKys/Lib/share/qml" CACHE STRING "additional libraries" FORCE)

# Helper function for enabling OpenMP support for a target.
function(enable_openmp TARGET)
    if (NOT DEFINED TARGET OR NOOPENMP)
        return ()
    endif ()

    find_package(OpenMP)
    if (NOT OpenMP_CXX_FOUND)
        return ()
    endif()

    message(STATUS "Enabling OpenMP support for ${TARGET}")
    target_link_libraries(${TARGET} PRIVATE OpenMP::OpenMP_CXX)
    target_compile_definitions(${TARGET} PRIVATE OPENMP_ENABLED)

    if (MSVC)
        target_compile_options(${TARGET} PRIVATE /openmp:experimental)
    endif ()
endfunction()

set(QT_QMAKE_EXECUTABLE qmake CACHE FILEPATH "Qt qmake path")
find_program(QT_QMAKE_EXECUTABLE_BIN NAMES "${QT_QMAKE_EXECUTABLE}" CACHE FILEPATH "Detected qmake executable")

set(QT_INSTALL_SRC "${QT_INSTALL_PREFIX}/src" CACHE PATH "Qt sources templates directory")
