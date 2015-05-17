#!/bin/sh

eval $(xcodebuild -project platforms/ios/*.xcodeproj/ -showBuildSettings | sed '1d;s/^ *//;s/"/\\"/g;s/ = \(.*\)/="\1"/;s/ = /=/;s/UID.*//' 2> /dev/null)

PLATFORM_NAME="iphonesimulator"
CONFIG="Debug"

if [[ $CORDOVA_CMDLINE == *"--device"* ]]; then
PLATFORM_NAME="iphoneos"
fi

if [[ $CORDOVA_CMDLINE == *"--release"* ]]; then
CONFIG="Release"
fi

pushd ${BUILT_PRODUCTS_DIR%/*} >/dev/null
BUILT_PRODUCT_ROOT_DIR=$(pwd)
popd >/dev/null

BUILT_PRODUCTS_DIR="$BUILT_PRODUCT_ROOT_DIR/$CONFIG-$PLATFORM_NAME"

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
pushd $SCRIPT_DIR/metadataGenerator/bin > /dev/null
source metadata-generation-build-step.sh
popd > /dev/null
