#!/bin/bash

#GNU public license

#This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
 # as published by the Free Software Foundation; either version 2
 # of the License, or (at your option) any later version.
 # 
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 # switchmini/ignition
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, write to the
 # Free Software Foundation, Inc,
 # 51 Franklin Street, Fifth Floor,
 # Boston, MA  02110-1301, USA.

preferenceDir=~/Library/Preferences/Dannephoto/

export PATH="$(cat "$preferenceDir"switchmini/"path_2")":$PATH

if ls "$preferenceDir"switchmini/ignition
then
#!/bin/bash
#new output folder
if ! ls "$preferenceDir"switchmini/O_trap
then
if [ -f "$preferenceDir"output ]
then 
osascript -e 'display notification "Your output folder has changed" with title "Switch mini"'
fi
fi 


THREADS= ;
fi

if [ -f "$preferenceDir"THREADS ]
then
THREADS=$(cat "$preferenceDir"THREADS)
else
half=$(echo $(sysctl -n hw.physicalcpu) / 2 | bc -l | cut -d "." -f1)
echo "Threads" $(echo $(sysctl -n hw.physicalcpu) + $half | bc -l) > "$preferenceDir"THREADS
THREADS=$(cat "$preferenceDir"THREADS)
fi

#set your input folder
in="$(cat "$preferenceDir"switchmini/path_1)"/

#set your output folder
    if ! [ x"$(cat "$preferenceDir""output")" = x ]
    then
out=$(cat "$preferenceDir""output")/
    else
out=$(cat "$preferenceDir"switchmini/"path_1")/
    fi

#erase mlv_dump settings 
if ! [ -f "$preferenceDir"mlv_dump_settings ]
then
echo > "$preferenceDir"mlv_dump_settings
fi

printf '\e[8;43;73t'
printf '\e[3;450;0t'
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

#letÂ´s start normal
"$(tput sgr0)"

nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixfp= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; p= ; ato= ; w= ; fstripes= ; fpn= ; dfl= ; btp= ; fdepth= ; fcpm= ; bpm= ; 
if grep ' \-p' "$preferenceDir"mlv_dump_settings 
then
p=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-cs' "$preferenceDir"mlv_dump_settings 
then
nocs=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs2' "$preferenceDir"mlv_dump_settings 
then
cs2=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs3' "$preferenceDir"mlv_dump_settings 
then
cs3=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs5' "$preferenceDir"mlv_dump_settings 
then
cs5=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-fixfp' "$preferenceDir"mlv_dump_settings 
then
fixfp=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-fixcp' "$preferenceDir"mlv_dump_settings 
then
fixcp=$(echo "$bold""$green"added!"$normal")
fi
if grep ' --fixcp2' "$preferenceDir"mlv_dump_settings 
then
fixcp=
fixcp2=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-stripes' "$preferenceDir"mlv_dump_settings 
then
nostripes=$(echo "$bold""$green"added!"$normal")
fi
if grep 'black-fix' "$preferenceDir"mlv_dump_settings 
then
bll=$(grep -Eo '.{0,0}black-fix.{0,6}' "$preferenceDir"mlv_dump_settings)
fi
if grep 'white-fix' "$preferenceDir"mlv_dump_settings 
then
wll=$(grep -Eo '.{0,0}white-fix.{0,6}' "$preferenceDir"mlv_dump_settings)
fi
if grep ' \-c' "$preferenceDir"mlv_dump_settings 
then
c=$(echo "$bold""$green"added!"$normal")
fi
if grep 'relaxed' "$preferenceDir"mlv_dump_settings 
then
ato=$(echo "$bold""$green"added!"$normal")
else
ato=
fi
if grep 'no-audio' "$preferenceDir"mlv_dump_settings 
then
w=$(echo "$bold""$green"added!"$normal")
fi
if grep 'force-stripes' "$preferenceDir"mlv_dump_settings 
then
fstripes=$(echo "$bold""$green"added!"$normal")
fi
if grep 'fpn' "$preferenceDir"mlv_dump_settings 
then
fpn=$(echo "$bold""$green"added!"$normal")
fi
if grep 'deflicker' "$preferenceDir"mlv_dump_settings 
then
dfl=$(grep -Eo '.{0,0}deflicker.{0,6}' "$preferenceDir"mlv_dump_settings)
fi
if grep ' \-b' "$preferenceDir"mlv_dump_settings 
then
btp=$(grep -Eo '.{0,0}-b.{0,3}' "$preferenceDir"mlv_dump_settings)
fi
if grep 'no-bitpack' "$preferenceDir"mlv_dump_settings 
then
fdepth=$(echo "$bold""$green"added!"$normal")
fi
if grep ' \--fpi' "$preferenceDir"mlv_dump_settings 
then
fcpm=$(grep -Eo '.{0,0}fpi.{0,2}' "$preferenceDir"mlv_dump_settings)
fi
if grep ' \--bpi' "$preferenceDir"mlv_dump_settings 
then
bpm=$(grep -Eo '.{0,0}bpi.{0,2}' "$preferenceDir"mlv_dump_settings)
fi
if [ -f "$preferenceDir"switchminiawb ] 
then
awb=$(echo "$bold""$green"added!"$normal")
fi


#how many physical cpus do your computer have
cpu=$(sysctl -n hw.physicalcpu)

while :
do 

    clear
    cat<<EOF
    -----------
    $(tput bold)Switch mini$(tput sgr0)
    -----------

    $(tput bold)MLV input: $(tput setaf 4)$in$(tput sgr0)
    $(tput bold)dng output: $(tput setaf 4)$out$(tput sgr0)
    $(tput bold)physical cpu: $(tput setaf 4)$cpu$(tput sgr0)
	
-- DNG output --
    $(tput bold)(00) no chroma smoothing$(tput sgr0)   $nocs
    $(tput bold)(01) 2x2 chroma smoothing$(tput sgr0)  $cs2	
    $(tput bold)(02) 3x3 chroma smoothing$(tput sgr0)  $cs3
    $(tput bold)(03) 5x5 chroma smoothing$(tput sgr0)  $cs5
    $(tput bold)(04) do not fix focus pixels$(tput sgr0)  $fixfp
    $(tput bold)(05) do not fix cold pixels$(tput sgr0)  $fixcp 
    $(tput bold)(06) fix non-static$(tput sgr0)(moving) $(tput bold)cold pixels$(tput sgr0)(slow) $fixcp2
    $(tput bold)(07) disable vertical stripes in highlights  $nostripes
    $(tput bold)(08) force vertical stripes$(tput sgr0)(slow, every frame)  $fstripes
    $(tput bold)(09) set black level  $(tput setaf 4)$bll$(tput sgr0)
    $(tput bold)(10) set white level  $(tput setaf 4)$wll$(tput sgr0)
    $(tput bold)(11) compress dng files using LJ92$(tput sgr0) $c
    $(tput bold)(12) pass through original raw data without processing$(tput sgr0) $p
    $(tput bold)(13) no audio$(tput sgr0)(no WAV file nor wav metadata) $w
    $(tput bold)(14) relaxed$(tput sgr0)(skip blocks that are erroneous) $ato
    $(tput bold)(15) fix pattern noise$(tput sgr0) $fpn
    $(tput bold)(16) deflicker$(tput sgr0) 3072(default) $(tput bold)$(tput setaf 4)$dfl$(tput sgr0)
    $(tput bold)(17) convert to bit depth$(tput sgr0)(1-16) $(tput bold)$(tput setaf 4)$btp$(tput sgr0)
    $(tput bold)(18) write DNG to 16 bit$(tput sgr0) $fdepth
    $(tput bold)(19) focus pixel method: $(tput sgr0)(mlvfs=0),(raw2dng=1),default=0$(tput bold)$(tput setaf 4) $fcpm$(tput sgr0)
    $(tput bold)(20) bad pixel method: $(tput sgr0)(mlvfs=0),(raw2dng=1),default=1$(tput bold)$(tput setaf 4) $bpm$(tput sgr0)
    $(tput bold)(21) apply auto white balance to your dng files $(tput sgr0) $awb$(tput sgr0)

    $(tput bold)$(tput setaf 4)(h)  HOWTO$(tput sgr0)
    $(tput bold)$(tput setaf 1)(R)  reset switches$(tput sgr0)
    $(tput bold)$(tput setaf 1)(O)  select new output folder$(tput sgr0)
    $(tput bold)$(tput setaf 1)(TH) set running threads manually$(tput setaf 7)(max 32)$(tput sgr0)$(tput bold)$(tput setaf 4) $THREADS$(tput sgr0) 
    $(tput bold)$(tput setaf 1)(q)  quit Switch mini$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r) ${bold}$(tput setaf 1) run Switch mini$(tput sgr0)
			 
  					        					
Enable your switches. Reselect for reset:
EOF
    read -n2
    case "$REPLY" in

    "00")
p=
if grep 'no-cs' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --no-cs//g' 
nocs=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-cs" >> "$preferenceDir"mlv_dump_settings
nocs=$(echo "$bold""$green"added!"$normal")
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --cs2x2//g'
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --cs3x3//g' 
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --cs5x5//g'
cs2=
cs3=
cs5=
fi
;;

    "01")
p=
if grep 'cs2' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --cs2x2//g' 
cs2=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --cs2x2" >> "$preferenceDir"mlv_dump_settings
cs2=$(echo "$bold""$green"added!"$normal")
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --no-cs//g'
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --cs3x3//g' 
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --cs5x5//g'
nocs=
cs3=
cs5=
fi
;;

    "02")
p=
if grep 'cs3' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --cs3x3//g' 
cs3=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --cs3x3" >> "$preferenceDir"mlv_dump_settings
cs3=$(echo "$bold""$green"added!"$normal")
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --no-cs//g'
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --cs2x2//g' 
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --cs5x5//g'
nocs=
cs2=
cs5=
fi
;;

    "03")
p=
if grep 'cs5' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --cs5x5//g' 
cs5=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --cs5x5" >> "$preferenceDir"mlv_dump_settings
cs5=$(echo "$bold""$green"added!"$normal")
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --no-cs//g'
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --cs2x2//g' 
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --cs3x3//g'
nocs=
cs2=
cs3=
fi
;;

    "04")
p=
if grep 'no-fixfp' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --no-fixfp//g' 
fixfp=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-fixfp" >> "$preferenceDir"mlv_dump_settings
fixfp=$(echo "$bold""$green"added!"$normal")
fixcp2=
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --fixcp2//g'
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --no-fixcp//g' 
fixcp=
fi
;;

    "05")
p=
if grep 'no-fixcp' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --no-fixcp//g' 
fixcp=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-fixcp" >> "$preferenceDir"mlv_dump_settings
fixcp=$(echo "$bold""$green"added!"$normal")
fixcp2=
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --fixcp2//g'
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --no-fixfp//g' 
fixfp=
fi
;;

    "06")
p=
if grep ' --fixcp2' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --fixcp2//g' 
fixcp2=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --no-fixcp//g'
printf "%s\n" " --fixcp2" >> "$preferenceDir"mlv_dump_settings
fixcp2=$(echo "$bold""$green"added!"$normal")
fixcp=
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --no-fixfp//g' 
fixfp=
fi
;;

    "07")
if grep 'no-stripes' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --no-stripes//g' 
nostripes=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-stripes" >> "$preferenceDir"mlv_dump_settings
nostripes=$(echo "$bold""$green"added!"$normal")
fi
;;

    "08")
if grep 'force-stripes' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --force-stripes//g' 
fstripes=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --force-stripes" >> "$preferenceDir"mlv_dump_settings
fstripes=$(echo "$bold""$green"added!"$normal")
fi
;;

    "09")
p=
if grep 'black-fix' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,2}black-fix.{0,6}' "$preferenceDir"mlv_dump_settings)"'//g'
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
black level setting reset"$(tput sgr0) ; 
sleep 1
bll=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify black level:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 2048 and hit enter)"
read input_variable
echo "black level is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
printf "%s\n" " --black-fix"=$input_variable >> "$preferenceDir"mlv_dump_settings
bll=$(grep -Eo '.{0,0}black-fix.{0,6}' "$preferenceDir"mlv_dump_settings)
fi
sleep 1 
printf '\e[8;43;73t'
printf '\e[3;450;0t'
;;

    "10")
p=
if grep 'white-fix' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,2}white-fix.{0,6}' "$preferenceDir"mlv_dump_settings)"'//g'
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
white level setting reset"$(tput sgr0) ; 
sleep 1
wll=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify white level:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 15000 and hit enter)"
read input_variable
echo "white level is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
printf "%s\n" " --white-fix"=$input_variable >> "$preferenceDir"mlv_dump_settings
wll=$(grep -Eo '.{0,0}white-fix.{0,6}' "$preferenceDir"mlv_dump_settings)
fi
sleep 1 
printf '\e[8;43;73t'
printf '\e[3;450;0t'
;;


    "11")
p=
if grep ' \-c' "$preferenceDir"mlv_dump_settings 
then
perl -pi -e 's/ -c//g' "$preferenceDir"mlv_dump_settings
c=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " -c" >> "$preferenceDir"mlv_dump_settings
c=$(echo "$bold""$green"added!"$normal")
fi
;;


    "12")
if grep ' \-p' "$preferenceDir"mlv_dump_settings 
then
perl -pi -e 's/ -p//g' "$preferenceDir"mlv_dump_settings
p=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ;
else 
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixfp= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; ato= ; w= ; fstripes= ; fpn= ; dfl= ; btp= ; fdepth= ; fcpm= ; bpm= ;
printf "%s\n" " -p" > "$preferenceDir"mlv_dump_settings
p=$(echo "$bold""$green"added!"$normal")
fi
;;

    "13")
p=
if grep 'no-audio' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --no-audio//g' 
w=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-audio" >> "$preferenceDir"mlv_dump_settings
w=$(echo "$bold""$green"added!"$normal")
fi
;;


    "14")  
p=
if grep ' \--relaxed' "$preferenceDir"mlv_dump_settings 
then
perl -pi -e 's/ --relaxed//g' "$preferenceDir"mlv_dump_settings
ato=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --relaxed" >> "$preferenceDir"mlv_dump_settings
ato=$(echo "$bold""$green"added!"$normal")
fi
;;

    "15")  
p=
if grep 'fpn' "$preferenceDir"mlv_dump_settings 
then
perl -pi -e 's/ --fpn//g' "$preferenceDir"mlv_dump_settings
fpn=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --fpn" >> "$preferenceDir"mlv_dump_settings
fpn=$(echo "$bold""$green"added!"$normal")
fi
;;


    "16")
p=
if grep 'deflicker' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,2}deflicker.{0,6}' "$preferenceDir"mlv_dump_settings)"'//g'
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
deflicker level setting reset"$(tput sgr0) ; 
sleep 1
dfl=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify deflicker level:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 3072 and hit enter)"
read input_variable
echo "deflicker level is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
printf "%s\n" " --deflicker"=$input_variable >> "$preferenceDir"mlv_dump_settings
dfl=$(grep -Eo '.{0,0}deflicker.{0,6}' "$preferenceDir"mlv_dump_settings)
fi
sleep 1 
printf '\e[8;43;73t'
printf '\e[3;450;0t'
;;

    "17")
p=
if grep ' \-b' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,0}-b.{0,3}' "$preferenceDir"mlv_dump_settings)"'//g'
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
bitdepth reset"$(tput sgr0) ; 
sleep 1
btp=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify bitdepth:$(tput sgr0)(between$(tput sgr0) 1-16 and hit enter)"
read input_variable
echo "bitdepth is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
printf "%s\n" " -b $input_variable" >> "$preferenceDir"mlv_dump_settings
btp=$(grep -Eo '.{0,0}-b.{0,3}' "$preferenceDir"mlv_dump_settings)
fi
sleep 1 
printf '\e[8;43;73t'
printf '\e[3;450;0t'
;;

    "18")
p=
if grep 'no-bitpack' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ --no-bitpack//g' 
fdepth=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-bitpack" >> "$preferenceDir"mlv_dump_settings
fdepth=$(echo "$bold""$green"added!"$normal")
fi
;;

    "19")
p=
if grep ' \--fpi' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,0}--fpi.{0,2}' "$preferenceDir"mlv_dump_settings)"'//g'
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
focus pixel method reset"$(tput sgr0) ; 
sleep 1
fcpm=
else
printf '\e[8;16;65t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify focus pixel method:$(tput sgr0)(between$(tput sgr0) 0 or 1 and hit enter)"
read input_variable
echo "focus pixel method is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
printf "%s\n" " --fpi $input_variable" >> "$preferenceDir"mlv_dump_settings
fcpm=$(grep -Eo '.{0,0}fpi.{0,2}' "$preferenceDir"mlv_dump_settings)
fi
sleep 1 
printf '\e[8;43;73t'
printf '\e[3;450;0t'
;;

    "20")
p=
if grep ' \--bpi' "$preferenceDir"mlv_dump_settings 
then
find "$preferenceDir"mlv_dump_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,0}--bpi.{0,2}' "$preferenceDir"mlv_dump_settings)"'//g'
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
bad pixel method reset"$(tput sgr0) ; 
sleep 1
bpm=
else
printf '\e[8;16;65t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify bad pixel method:$(tput sgr0)(between$(tput sgr0) 0 or 1 and hit enter)"
read input_variable
echo "bad pixel method is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
printf "%s\n" " --bpi $input_variable" >> "$preferenceDir"mlv_dump_settings
bpm=$(grep -Eo '.{0,0}bpi.{0,2}' "$preferenceDir"mlv_dump_settings)
fi
sleep 1 
printf '\e[8;43;73t'
printf '\e[3;450;0t'
;;

    "21")
awb=
if ! [ -f "$preferenceDir"switchminiawb ] 
then
echo > "$preferenceDir"switchminiawb 
awb=$(echo "$bold""$green"added!"$normal")
else
rm "$preferenceDir"switchminiawb
fi 
printf '\e[8;43;73t'
printf '\e[3;450;0t'
;;

   "h")  
clear
echo $(tput bold)"Welcome to Switch mini."
sleep 2
echo ""
echo "Here comes a 6 step tutorial."
sleep 2
echo ""
echo "1 - Double tap Switch mini and select a folder with mlv files or simply"
sleep 2
echo  "    drag the folder on to the app to get into the Switch mini menu."
sleep 3
echo ""
echo "2 - Enable desired switches from the Switch mini menu."
sleep 3
echo ""
echo "3 - It is possible to change output location. 

    $(tput bold)$(tput setaf 1)(O)  select new output folder$(tput sgr0)"
sleep 3
echo ""
echo "4 - You can increase thread amount.

    $(tput bold)$(tput setaf 1)(TH) set running threads manually$(tput setaf 7)(max 20)$(tput sgr0)"
sleep 2
echo ""
echo "5 - Reset and start over at any time. 

    $(tput bold)$(tput setaf 1)(R)  reset switches$(tput sgr0)"
sleep 3
echo ""
echo "6 - when ready. 

    $(tput bold)$(tput setaf 1)(r) ${bold}$(tput setaf 1) run Switch mini$(tput sgr0)
    to start mlv to dng transcoding"
sleep 3
echo ""
echo "feel free to test the other menu options in Switch mini menu and report 
any problems at https://www.magiclantern.fm/forum/"
sleep 3
echo ""


echo "Good luck!"
sleep 2
echo ""
echo $(tput setaf 1)"Enter any key to get back to main menu:"
    read -n1
    case "$REPLY" in
    * )  
. "$(cat "$preferenceDir"content)"/Menu.command
    ;;
    esac
;;



    "R")
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixfp= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; p= ; ato= ; w= ; fstripes= ; fpn= ; dfl= ; btp= ; fdepth= ; fcpm= ; bpm= ;
out= ; THREADS= ; awb=
rm "$preferenceDir"switchminiawb
rm "$preferenceDir"THREADS
half=$(echo $(sysctl -n hw.physicalcpu) / 2 | bc -l | cut -d "." -f1)
echo "Threads" $(echo $(sysctl -n hw.physicalcpu) + $half | bc -l) > "$preferenceDir"THREADS
THREADS=$(cat "$preferenceDir"THREADS)
rm "$preferenceDir"content
rm "$preferenceDir"path_1
rm "$preferenceDir"output 1> /dev/null 2>&1 &
#set your output folder
    if [ x"$out" = x ]
    then
out=$(cat "$preferenceDir"switchmini/"path_1")/$(tput sgr0)
    fi
rm "$preferenceDir"switchmini/O_trap 1> /dev/null 2>&1 &
rm "$preferenceDir"mlv_dump_settings 
;;

    "O")
rm "$preferenceDir"switchmini/OUT_path 1> /dev/null 2>&1 &
rm "$preferenceDir"switchmini/O_trap 1> /dev/null 2>&1 &
if ls "$preferenceDir"output
then
rm "$preferenceDir"output
out=
else
echo > "$preferenceDir"switchmini/OUT_path
open "$(cat "$preferenceDir"content)"new_output.app
clear
echo "


A selection window will now open"
sleep 2"$preferenceDir"THREADS 
osascript -e 'tell application "Terminal" to close first window' & exit
fi
;;

    "TH")
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"set thread amount:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 2 and hit enter)"
read input_variable
    if (( $input_variable > 32 )); then
    input_variable=$(echo 32)
    fi
echo "thread amount is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
echo "Threads" $input_variable > "$preferenceDir"THREADS
THREADS=$(cat "$preferenceDir"THREADS)
sleep 1 
printf '\e[8;43;73t'
printf '\e[3;450;0t'
    ;;

    "r") 
rm "$preferenceDir"switchmini/ignition 
printf '\e[8;7;20t'
printf '\e[3;750;0t'
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

while : 
do 
    clear
cat<<EOF
------------
$(tput setaf 1)$(tput bold)Abort button$(tput sgr0)
------------

$(tput bold)$(tput setaf 1)(K) Abort$(tput sgr0)
EOF
    read -n1
    case "$REPLY" in

    "K") 
rm -r "$preferenceDir"switchmini
killall sleep
killall dcraw
killall exiv2
killall exiftool
killall mlv_dump
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
done 
;;

    "q")   
echo > "$preferenceDir"switchmini/ignition_exit 1> /dev/null 2>&1 &
rm "$preferenceDir"switchmini/ignition 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;

exit 0

#Copyright Danne