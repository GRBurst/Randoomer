#!/bin/bash -e
PACK=info.thebleedingedge.randoomer
ACT=.Randoomer
APP=build/outputs/apk/randoomer-debug-unaligned.apk
BUILD=packageDebug
if (( $# ==  1 )); then
    if [[ "$1" == "d" ]]; then
        BUILD=packageDebug;
    elif [[ "$1" == "r" ]]; then
        BUILD=assembleRelease;
        APP=build/outputs/apk/randoomer-release.apk
    else
        BUILD = $1
    fi
fi

echo "Building project $PACK with $BUILD"
./gradlew $BUILD

echo "Installing $APP"
adb install -r $APP

echo "Starting Activity"
adb shell am start -n $PACK/$ACT
