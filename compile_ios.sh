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

ARCH="arm"
XARCH="-arch aarch64"
TARGET_OS="darwin"
# CLANG_COMPILER="clang -arch arm64"
CLANG_COMPILER="gcc -arch arm64"
SYSROOT="$(xcrun --sdk iphoneos --show-sdk-path)"
CPU="armv8"
AS="/usr/local/bin/gas-preprocessor.pl -arch aarch64 -- $CLANG_COMPILER"

./configure --enable-cross-compile --arch=$ARCH \
--target-os=$TARGET_OS \
--cc="$CLANG_COMPILER" \
--as="$AS" \
--cpu=$CPU \
--enable-pic \
--prefix=$PREFIX \
--sysroot=$SYSROOT

cp config.* $PREFIX
