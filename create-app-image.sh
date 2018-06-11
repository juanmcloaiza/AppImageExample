#!/bin/bash

#Modify these vars:
MyExecutable=some-qt-executable
IconNoExt=LadyBug
IconPng=./Icons/${IconNoExt}.png
IconSvg=./Icons/${IconNoExt}.svg

#download linuxdeployqt
LinuxDeployQt=linuxdeployqt-continuous-x86_64.AppImage 
echo "Downloading ${LinuxDeployQt}"
wget https://github.com/probonopd/linuxdeployqt/releases/download/continuous/${LinuxDeployQt} 
chmod a+x ./${LinuxDeployQt}

#Create a temporary AppDir for the executable:
MyExeDir=${MyExecutable}.AppDir
echo "Creating ${MyExeDir}"
mkdir ${MyExeDir}
cp ${MyExecutable} ${MyExeDir}
cp ${IconPng} ${MyExeDir}
cp ${IconSvg} ${MyExeDir}

#Create desktop file:
#There must be a better way of doing this...
echo -e '[Desktop Entry]\n'\
'Type=Application\n'\
'Name='${MyExecutable}'\n'\
'Exec='${MyExecutable}'\n'\
'Icon='${IconNoExt}'\n'\
'Comment=This is an AppImage test\n'\
'Terminal=false' > ${MyExeDir}/${MyExecutable}.desktop

#Create appimage:
echo "Creating App Image..."
LDQTFlags='-appimage'
./${LinuxDeployQt} ${MyExeDir}/${MyExecutable} ${LDQTFlags}

#remove LinuxDeployQt and Temporary AppDirectory:
echo "Removing ${LinuxDeployQt}..."
rm ${LinuxDeployQt}

echo "Removing ${MyExeDir}"
rm -rf ${MyExeDir}

ls -rt | tail -1 
