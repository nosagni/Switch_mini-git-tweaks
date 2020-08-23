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
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the
# Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor,
# Boston, MA  02110-1301, USA.

preferenceDir=~/Library/Preferences/Dannephoto/
path_2="$(pwd)/"
cd "$(cat "$preferenceDir"switchmini/path_1)"

export PATH="$path_2":$PATH

rm "$(cat "$preferenceDir"switchmini/path_1)"/LOG.txt
exec &> >(tee -a "$(cat "$preferenceDir"switchmini/path_1)"/LOG.txt >&2)

mkdir -p "$preferenceDir"switchmini/
#Call menu selector
echo >"$preferenceDir"switchmini/ignition
echo "$path_2" >"$preferenceDir"switchmini/path_2
open "$path_2"Menu.command &
sleep 1
while ls "$preferenceDir"switchmini/ignition 2>/dev/null; do
    sleep 1
done
if [ -f "$preferenceDir"switchmini/ignition_exit ]; then
    exit 0
fi
#check for new output folder
if [ -f "$preferenceDir"output ]; then
    mkdir -p "$(cat "$preferenceDir"output)"
    O=$(cat "$preferenceDir""output")/
fi

###############################################################
#Processing MLV files into folders with dng files
#create the mlv time command list
#Will take white space
OLDIFS=$IFS
IFS=$'\n'
ls *.MLV *.mlv >"$preferenceDir"switchmini/MLVFILES
#reset IFS
IFS=$OLDIFS
#specify THREADS if
if [ -f "$preferenceDir"THREADS ]; then
    THR=$(cat "$preferenceDir"THREADS | tr -d Threads)
else
    half=$(echo $(sysctl -n hw.physicalcpu) / 2 | bc -l | cut -d "." -f1)
    echo "Threads" $(echo $(sysctl -n hw.physicalcpu) + $half | bc -l) >"$preferenceDir"THREADS
fi
#safety check(fools gold)
if (($THR > 32)); then
    THR=$(echo 32)
fi
#split into max 32 chunks
split -l $(($(wc -l <"$preferenceDir"switchmini/MLVFILES) / $THR + 1)) "$preferenceDir"switchmini/MLVFILES "$preferenceDir"switchmini/MLVFILES
rm "$preferenceDir"switchmini/MLVFILES

#remove any old fpm files
rm *.fpm

#Multiprocessing scripts build here. Up to 32 scripts possible

mlv_dump_thread() {
    #mlv folder path
    path_1="$(cat "$preferenceDir"switchmini/path_1)"/
    #output location
    if [ -f "$preferenceDir"output ]; then
        outputlocation="$(cat "$preferenceDir"output)"
    fi

    # argument $1 is a letter combination

    #Processing MLV files into folders with dng files
    while ! [ x"$(cat "$preferenceDir"switchmini/MLVFILESa$1)" = x ]; do
        FILE1=$(cat "$preferenceDir"switchmini/"MLVFILESa$1" | head -1)
        date=$(mlv_dump -v "$FILE1" | grep 'Date' | head -1 | awk 'FNR == 1 {print $2; exit}')
        date_01=$(echo "$date" | head -c2)
        date_02=$(echo "$date" | cut -c4-5)
        date_03=$(echo "$date" | cut -c7-10)
        date=$(echo "$date_03"-"$date_02"-"$date_01""_0001_C0000")
        BASE=$(echo "$FILE1" | cut -d "." -f1)
        mkdir "$O""${BASE}"
        mv "$O""${BASE}" "$O""${BASE}_1_$date"

        #changed output location?
        if [ -d "$outputlocation" ]; then
            mkdir -p "$(cat "$preferenceDir"output)"
            output="$O${BASE}_1_$date"/
        fi

        #reworked fpm routines to meet the latest pixelmaps. Only for eosm for now
        if grep 'EOS M' <<<$(mlv_dump -v "$FILE1" | awk '/Camera Name/ { print $4,$5; exit}'); then
            he=$(mlv_dump -v "$FILE1" | awk '/height/ { print $2; exit }')
            wi=$(mlv_dump -v "$FILE1" | awk '/width/ { print $2; exit }')
            if ! [ -f "$path_2"maps/80000331_"$wi"x"$he".fpm ]; then
                ln -s "$path_2"maps/80000331_"$wi"x* 80000331_"$wi"x"$he".fpm
            else
                ln -s "$path_2"maps/80000331_"$wi"x"$he".fpm 80000331_"$wi"x"$he".fpm
            fi
        fi

        #mlv_dump settings
        mlv="$(cat "$preferenceDir""mlv_dump_settings" | perl -p -e 's/^[ \t]*//')"

        #extract dng frames
        if ! [ -d "$outputlocation" ]; then
            mlv_dump --dng $mlv -o "${BASE}_1_$date"/"${BASE}_1_$date"_ "$FILE1"
        else
            #enter an alternate location
            mlv_dump --dng $mlv -o "$output""${BASE}_1_$date"_ "$path_1""$FILE1"
        fi

        #check if cam was set to auto white balance. Non dualiso
        if [ "$(mlv_dump -v "$(cat "$preferenceDir"switchmini/path_1)"/"$FILE1" | grep -A6 'Block: WBAL' | awk 'FNR == 6 {print $2; exit}')" = "0" ] || [ -f "$preferenceDir"switchminiawb ]; then
            cd "$O""${BASE}_1_$date"
            . "$path_2"awb.command
            wi=$(exiv2 -pt "${BASE}"_1_"$date"_000000.dng | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; exit}')
            find . -maxdepth 1 -mindepth 1 -name '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.AsShotNeutral Rational $wi"
            cd ..
        fi

        echo "$(tail -n +2 "$preferenceDir"switchmini/MLVFILESa$1)" >"$preferenceDir"switchmini/MLVFILESa$1
    done
}

alpha=abcdefghijklmnopqrstuvqxyz
counter=0
num=0
n=1

while [ $counter -lt $THR ]; do
    # bash -c "$path_2/mlv_dump.sh ${alpha:$num:$n} & pid1=$!"
    mlv_dump_thread ${alpha:$num:$n} &
    pid$num=$!

    #increment both numbers and alphabet
    num=$(($num + 1))
    counter=$(($counter + 1))
done

#wait for jobs to end
wait
#rm any created fpm files
rm *.fpm

clear
echo "DONE!"

#Thanks to Bouncyball(mlv_dump_for_steroids, A1ex,g3gg0(raw2dng, mlv_dump), Dave Coffin(dcraw) Fabrice Bellard(FFmpeg) Phil Harvey(Exiftool) Andreas Huggel(exiv2) BWF MetaEdit(FADGI) #dfort(Focus pixel script).
#Copyright Danne
