#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"

normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"

#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner

printf '\e[8;24;95t'
printf '\e[3;410;100t'

open -a Terminal

clear

#Script originally for MLVFS
#https://bitbucket.org/dmilligan/mlvfs/src/9f8191808407bb49112b9ab14c27053ae5022749/build_installer.sh?at=master&fileviewer=file-view-default
# A lot of this script came from here:
# http://stackoverflow.com/questions/96882/how-do-i-create-a-nice-looking-dmg-for-mac-os-x-using-command-line-tools
source="install_temp"
title="Switch_mini"
finalDMGName="Switch_mini.dmg"
size=$(echo $(du -ks | cut -d '.' -f1 | tr -d ' ')*2 | bc -l)

mkdir "${source}"
cp -R `ls | grep -v 'dmg_builder.command\|README.md\|install_temp'` "${source}"

#remove any previously existing build
rm -f "${finalDMGName}"

hdiutil create -srcfolder "${source}" -volname "${title}" -fs HFS+ -fsargs "-c c=64,a=16,e=16" -format UDRW -size ${size}k pack.temp.dmg
device=$(hdiutil attach -readwrite -noverify -noautoopen "pack.temp.dmg" | egrep '^/dev/' | sed 1q | awk '{print $1}')
sleep 2
chmod -Rf go-w /Volumes/"${title}"
sync
sync
hdiutil detach ${device}
hdiutil convert "pack.temp.dmg" -format UDZO -imagekey zlib-level=9 -o "Switch_mini"
rm -f pack.temp.dmg
rm -R "${source}"

#overwrite Switch_mini.app in Applications
cp -rf Switch_mini.app /Applications

#bitbucket uploading api
repo="$(cat .git/config | grep 'url' | rev | cut -d "/" -f1 | rev | cut -d "." -f1)"
usr="$(cat .git/config | grep 'url' | rev | cut -d "/" -f2 | rev | cut -d "." -f1)"

clear
   echo $(tput bold)"Would you like to upload your dmg to "$repo"/downloads?$(tput sgr0) 
"$red"Y/N"$normal" then push enter"
   read pick
if [ "$pick" = y ] || [ "$pick" = Y ];
then
curl -u "$usr" -X POST https://api.bitbucket.org/2.0/repositories/"$usr"/"$repo"/downloads -F files=@Switch_mini.dmg
rm Switch_mini.dmg
else
osascript -e 'tell application "Terminal" to close first window' & exit
fi