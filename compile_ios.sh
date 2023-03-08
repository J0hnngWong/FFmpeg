#!/bin/bash

# https://github.com/kewlbear/FFmpeg-iOS-build-script/blob/master/build-ffmpeg.sh

CFLAGS="-arch arm64 -fembed-bitcode -mios-version-min=7.0"
PREFIX="productions/arm64"

#xcrun -sdk iphoneos clang \
# ./configure --enable-static --enable-pic \
# --host-cc=$(xcrun -sdk iphoneos clang) \
# --host-os=aarch64-apple-darwin \
# --host=aarch64-apple-darwin \
# --extra-cflags=$CFLAGS \
# --extra-asflags=$CFLAGS \
# --extra-ldflags=$CFLAGS \
# --prefix=$PREFIX

# curl -L https://github.com/libav/gas-preprocessor/raw/master/gas-preprocessor.pl \
			# -o /usr/local/bin/gas-preprocessor.pl \
			# && chmod +x /usr/local/bin/gas-preprocessor.pl \

cp tools/gas-preprocessor.pl /usr/local/bin/
chmod 777 /usr/local/bin/gas-preprocessor.pl

BASE_ARCH="arm"
CPU_ARCH="arm64" #arm64 armv8 armv7
CPU="armv8"
ARCH_INSTRUCTION="aarch64"
XARCH="-arch $ARCH_INSTRUCTION"
TARGET_OS="darwin"
CLANG_COMPILER="clang -arch $CPU_ARCH"
# CLANG_COMPILER="gcc -arch $CPU_ARCH"
SYSROOT="$(xcrun --sdk iphoneos --show-sdk-path)"
AS="/usr/local/bin/gas-preprocessor.pl -arch $ARCH_INSTRUCTION -- $CLANG_COMPILER"

./configure --enable-cross-compile \
--arch=$BASE_ARCH \
--target-os=$TARGET_OS \
--cc="$CLANG_COMPILER" \
--as="$AS" \
--cpu=$CPU \
--enable-pic \
--prefix=$PREFIX \
--sysroot=$SYSROOT \
--disable-ffmpeg \
--disable-ffprobe

cp config.* $PREFIX
