#!/bin/bash

#Not much to comment here,
#all this is just to obtain an executable whose name is
#"some-qt-executable" to pass to the script that builds
#the AppImage

git clone https://github.com/juanmcloaiza/Steca.git ./Steca
mkdir build-Steca
cd build-Steca
cmake ../Steca
cmake --build ./
ctest
cd ..
cp build-Steca/main/Steca ./some-qt-executable
rm -rf ./Steca build-Steca
