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

#keep this for later #set first_out.app path
    #if [ -d "$(cat /tmp/folder_paths.txt | head -1)" ]
    #then
    #echo "$(cat /tmp/folder_paths.txt | head -1)" > /tmp/path_1b
    #fi
    path_2="$(pwd)/"
    cd "$(cat /tmp/switchmini/path_1)"

    #find "$path_2"Menu.command -exec xattr -d -r com.apple.quarantine {} \;
    #find "$path_2"Switch_mini_drag_drop.command -exec xattr -d -r com.apple.quarantine {} \;
    export PATH="$path_2":$PATH
    
    rm "$(cat /tmp/switchmini/path_1)"/LOG.txt
    exec &> >(tee -a "$(cat /tmp/switchmini/path_1)"/LOG.txt >&2 )

    mkdir -p /tmp/switchmini/
#Call menu selector
    echo > /tmp/switchmini/ignition
    echo "$path_2" > /tmp/switchmini/path_2
    open "$path_2"Menu.command & sleep 1
    while ls /tmp/switchmini/ignition 2>/dev/null
    do sleep 1
    done
    if [ -f /tmp/switchmini/ignition_exit ]
    then 
    exit 0
    fi
#check for new output folder
    if [ -f /tmp/output ]
    then
    mkdir -p "$(cat /tmp/output)"
    O=$(cat /tmp/"output")/
    fi

###############################################################
#Processing MLV files into folders with dng files
#create the mlv time command list
#Will take white space
    OLDIFS=$IFS
    IFS=$'\n'
    ls *.MLV *.mlv > /tmp/switchmini/MLVFILES
#reset IFS
    IFS=$OLDIFS
#specify THREADS if
    if [ -f /tmp/THREADS ]
    then
    THR=$(cat /tmp/THREADS | tr -d Threads)
    else
    half=$(echo $(sysctl -n hw.physicalcpu) / 2 | bc -l | cut -d "." -f1)
    echo "Threads" $(echo $(sysctl -n hw.physicalcpu) + $half | bc -l) > /tmp/THREADS
    fi
#safety check(fools gold)
    if (( $THR > 32 )); then
    THR=$(echo 32)
    fi
#split into max 32 chunks
    split -l $(( $( wc -l < /tmp/switchmini/MLVFILES ) / $THR + 1 )) /tmp/switchmini/MLVFILES /tmp/switchmini/MLVFILES
    rm /tmp/switchmini/MLVFILES 

#remove any old fpm files
     rm *.fpm

#Multiprocessing scripts build here. Up to 32 scripts possible
alpha=abcdefghijklmnopqrstuvqxyz
counter=0
num=0
val=1
n=1

while [ $counter -lt $THR ]
 do 
    bash -c "$path_2/mlv_dump.sh ${alpha:$num:$n} & pid1=$!"

#increment both numbers and alphabet
    num=$(( $num + 1 ))
    counter=$(( $counter + 1 ))
    val=$(( $val + 1 ))

done

#wait for jobs to end
    wait < <(jobs -p)
#rm any created fpm files
    rm *.fpm

#Thanks to Bouncyball(mlv_dump_for_steroids, A1ex,g3gg0(raw2dng, mlv_dump), Dave Coffin(dcraw) Fabrice Bellard(FFmpeg) Phil Harvey(Exiftool) Andreas Huggel(exiv2) BWF MetaEdit(FADGI) #dfort(Focus pixel script).
#Copyright Danne
