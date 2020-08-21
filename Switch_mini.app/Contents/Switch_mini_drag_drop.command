
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

#set first_out.app path
    if [ -d "$(cat /tmp/folder_paths.txt | head -1)" ]
    then
    echo "$(cat /tmp/folder_paths.txt | head -1)" > /tmp/path_1b
    fi

    cd "$1"
    path_2=$(echo "$1"Contents/)
    #find "$path_2"Menu.command -exec xattr -d -r com.apple.quarantine {} \;
    #find "$path_2"Switch_mini_drag_drop.command -exec xattr -d -r com.apple.quarantine {} \;
    #find "$path_2"Switch_mini_app.command -exec xattr -d -r com.apple.quarantine {} \;
    export PATH="$path_2":$PATH
    cd "$(cat /tmp/switchmini/path_1)"
    rm "$(cat /tmp/switchmini/path_1)"/LOG.txt
    exec &> >(tee -a "$(cat /tmp/switchmini/path_1)"/LOG.txt >&2 )

    mkdir -p /tmp/switchmini/
#Call menu selector
    echo > /tmp/switchmini/ignition
    echo "$1" > /tmp/switchmini/path_2
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

#Multiprocessing scripts build here. Up to 32 scripts possible
counter=0
num=0
val=1
alpha=abcdefghijklmnopqrstuvqxyz
n=1
while [ $counter -lt $THR ]
 do
   cat <<EOF > /tmp/switchmini/mlv_dump_0$val.command
#output paths

#mlv folder path
    path_1="\$(cat /tmp/switchmini/path_1)"/
#output location
    if [ -f /tmp/output ]; then
    outputlocation="\$(cat /tmp/output)"
    fi

#Processing MLV files into folders with dng files
    while ! [ x"\$(cat /tmp/switchmini/MLVFILESa${alpha:$num:$n})" = x ]
    do 
    FILE$val=\$(cat /tmp/switchmini/"MLVFILESa${alpha:$num:$n}" | head -1) 
    date=\$(mlv_dump -v "\$FILE$val" | grep 'Date' | head -1 | awk 'FNR == 1 {print \$2; exit}')
    date_01=\$(echo "\$date" | head -c2)
    date_02=\$(echo "\$date" | cut -c4-5)
    date_03=\$(echo "\$date" | cut -c7-10)
    date=\$(echo "\$date_03"-"\$date_02"-"\$date_01""_0001_C0000")
    BASE=\$(echo "\$FILE$val" | cut -d "." -f1)
    mkdir "\$O""\${BASE}"
    mv "\$O""\${BASE}" "\$O""\${BASE}_1_\$date" 

#changed output location?
    if [ -d "\$outputlocation" ]
    then
    mkdir -p "\$(cat /tmp/output)"
    output="\$O\${BASE}_1_\$date"/ 
    fi

#reworked fpm routines to meet the latest pixelmaps. Only for eosm for now 
    if grep 'EOS M' <<< \$(mlv_dump -v "\$FILE$val" | awk '/Camera Name/ { print \$4,\$5; exit}')
    then 
	he=\$(mlv_dump -v "\$FILE$val" | awk '/height/ { print \$2; exit }')
	wi=\$(mlv_dump -v "\$FILE$val" | awk '/width/ { print \$2; exit }')
	if ! [ -f "\$path_2"maps/80000331_"\$wi"x"\$he".fpm ]; then  
	ln -s "\$path_2"maps/80000331_"\$wi"x* 80000331_"\$wi"x"\$he".fpm
	else
	ln -s "\$path_2"maps/80000331_"\$wi"x"\$he".fpm 80000331_"\$wi"x"\$he".fpm
	fi
    fi

#mlv_dump settings
    mlv="\$(cat /tmp/"mlv_dump_settings" | perl -p -e 's/^[ \t]*//')"
    
#extract dng frames
    if ! [ -d "\$outputlocation" ]; then
    mlv_dump --dng \$mlv -o "\${BASE}_1_\$date"/"\${BASE}_1_\$date"_ "\$FILE$val" 
    else
#enter an alternate location
    mlv_dump --dng \$mlv -o "\$output""\${BASE}_1_\$date"_ "\$path_1""\$FILE$val"
    fi

#check if cam was set to auto white balance. Non dualiso
    if [ "\$(mlv_dump -v "\$(cat /tmp/switchmini/path_1)"/"\$FILE$val" | grep -A6 'Block: WBAL' | awk 'FNR == 6 {print \$2; exit}')" = "0" ] || [ -f /tmp/switchminiawb ]
    then
    cd "\$O""\${BASE}_1_\$date"
    . "\$path_2"awb.command
    wi=\$(exiv2 -pt "\${BASE}"_1_"\$date"_000000.dng | awk '/Exif.Image.AsShotNeutral/ { print \$4,\$5,\$6; exit}')
    find . -maxdepth 1 -mindepth 1 -name '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.AsShotNeutral Rational \$wi"
    cd ..
    fi

    echo "\$(tail -n +2 /tmp/switchmini/MLVFILESa${alpha:$num:$n})" > /tmp/switchmini/MLVFILESa${alpha:$num:$n}
    done
#keep EOF all the way to the left or script breaks
EOF

#increment both numbers and alphabet
    num=$(( $num + 1 ))
    counter=$(( $counter + 1 ))
    val=$(( $val + 1 ))
done

#remove any old fpm files
    rm *.fpm

counter=0
val=1
while [ $counter -lt $THR ]
 do

    . /tmp/switchmini/mlv_dump_0$val.command & pid1=$!
    chmod u=rwx /tmp/switchmini/mlv_dump_0$val.command

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
