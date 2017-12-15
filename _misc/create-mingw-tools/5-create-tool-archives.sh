#!/bin/sh
# create 7z files that can be used when building the docker image
# this script must be copied and executed in the <omnetpproot>/tools directory

ZOPTS=-t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on
7z a $ZOPTS -x!win64/mingw64 opp-tools-win64-msys.7z win64
7z a $ZOPTS opp-tools-win64-mingw64.7z win64/mingw64