#!/bin/bash
echo "Welcome to Photoshop installer,wait a few minutes for the installation to complete！"
cameraraw=1

export WINEPREFIX="$HOME/Adobe-Photoshop"
mkdir -v $WINEPREFIX
echo "make dir Adobe-Photoshop complete!"

#mkdir allredist
echo "uncompressing allredist.tar.xz"
tar -xvf allredist.tar.xz
#mkdir AdobePhotoshop2021
echo "uncompressing AdoobePhotoshop2021.tar.xz"
tar -xvf AdobePhotoshop2021.tar.xz

#mkdir winetricks
echo "uncompressing winetricks"
tar -xvf winetricks.tar.xz

echo "Config Wine"
chmod +x allredist/winetricks
wineboot
allredist/winetricks win10

echo "Install Wine Components"
allredist/winetricks fontsmooth=rgb gdiplus msxml3 msxml6 atmlib corefonts dxvk
wine allredist/redist/2010/vcredist_x64.exe /q /norestart
wine allredist/redist/2010/vcredist_x86.exe /q /norestart

wine allredist/redist/2012/vcredist_x86.exe /install /quiet /norestart
wine allredist/redist/2012/vcredist_x64.exe /install /quiet /norestart

wine allredist/redist/2013/vcredist_x86.exe /install /quiet /norestart
wine allredist/redist/2013/vcredist_x64.exe /install /quiet /norestart

wine allredist/redist/2019/VC_redist.x64.exe /install /quiet /norestart
wine allredist/redist/2019/VC_redist.x86.exe /install /quiet /norestart

echo "Install vkd3d proton 3D dll"
allredist/setup_vkd3d_proton.sh install

mkdir -v $WINEPREFIX/drive_c/Program\ Files/Adobe
mv Adobe\ Photoshop\ 2021 $WINEPREFIX/drive_c/Program\ Files/Adobe/Adobe\ Photoshop\ 2021
mv allredist/launcher.sh $WINEPREFIX/drive_c
mv winetricks ~/.cache/
mv allredist/photoshop.png ~/.local/share/icons
mv allredist/photoshop.desktop ~/.local/share/applications
mv allredist/fonts/* $WINEPREFIX/drive_c/windows/Fonts/


#touch $WINEPREFIX/drive_c/launcher.sh
#echo "#\!/bin/bash" >> $WINEPREFIX/drive_c/launcher.sh
#echo "SCR_PATH=\"pspath\"" >> $WINEPREFIX/drive_c/launcher.sh
#echo "CACHE_PATH=\"pscache\"" >> $WINEPREFIX/drive_c/launcher.sh
#echo "RESOURCES_PATH=\"$SCR_PATH/resources\"" >> $WINEPREFIX/drive_c/launcher.sh
#echo "WINE_PREFIX=\"$SCR_PATH/prefix\"" >> $WINEPREFIX/drive_c/launcher.sh
#echo "FILE_PATH=$(winepath -w \"$PWD\")" >> $WINEPREFIX/drive_c/launcher.sh
#echo "export WINEPREFIX=\"$WINEPREFIX\"" >> $WINEPREFIX/drive_c/launcher.sh
#echo 'WINEPREFIX='/home/tom/apps'/Adobe-Photoshop DXVK_LOG_PATH='/home/tom/apps'/Adobe-Photoshop DXVK_STATE_CACHE_PATH='/home/tom/apps'/Adobe-Photoshop wine64 ' /home/tom/apps'/Adobe-Photoshop/drive_c/Program\ Files/Adobe/Adobe\ Photoshop\ 2021/photoshop.exe $FILE_PATH' >> /home/tom/apps/Adobe-Photoshop/drive_c/launcher.sh
#echo "DXVK_LOG_PATH=\"$WINEPREFIX\" DXVK_STATE_CACHE_PATH=\"$WINEPREFIX\" wine64 \"$WINEPREFIX/drive_c/Program\ Files/Adobe/Adobe\ Photoshop\ 2021/photoshop.exe\"" >> $WINEPREFIX/drive_c/launcher.sh

chmod +x $WINEPREFIX/drive_c/launcher.sh
winecfg -v win10
#mv allredist/photoshop.png ~/.local/share/icons/photoshop.png

#echo "[Desktop Entry]
#Name=Photoshop CC
#Exec=bash -c \"$WINEPREFIX/drive_c/launcher.sh %F\"
#Type=Application
#Comment=Photoshop CC 2021
#Categories=Graphics;2DGraphics;RasterGraphics;Production;
#Icon=photoshop
#StartupWMClass=photoshop.exe
#MimeType=image/png;image/psd;" > ~/.local/share/applications/photoshop.desktop

echo "Chinese Setting"
allredist/winetricks gdiplus reched20
wine regedit allredist/simsun.reg
wine regedit allredist/tahoma.reg

if [ $cameraraw = "1" ]
then
echo "Just follow the setup from Camera Raw."
#curl -L "https://download.adobe.com/pub/adobe/photoshop/cameraraw/win/12.x/CameraRaw_12_2_1.exe" > CameraRaw_12_2_1.exe
wine CameraRaw_12_2_1.exe
else
	echo ""
fi
zenity --info --text="Installation finished, Have fun with Photoshop !"
