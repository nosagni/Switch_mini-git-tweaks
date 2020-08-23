#!/bin/bash

#output paths

echo "YES"

#mlv folder path
path_1="$(cat /tmp/switchmini/path_1)"/
#output location
if [ -f /tmp/output ]; then
    outputlocation="$(cat /tmp/output)"
fi

# argument $1 is a letter combination

#Processing MLV files into folders with dng files
while ! [ x"$(cat /tmp/switchmini/MLVFILESa$1)" = x ]; do
    FILE1=$(cat /tmp/switchmini/"MLVFILESa$1" | head -1)
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
        mkdir -p "$(cat /tmp/output)"
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
    mlv="$(cat /tmp/"mlv_dump_settings" | perl -p -e 's/^[ \t]*//')"

    #extract dng frames
    if ! [ -d "$outputlocation" ]; then
        mlv_dump --dng $mlv -o "${BASE}_1_$date"/"${BASE}_1_$date"_ "$FILE1"
    else
        #enter an alternate location
        mlv_dump --dng $mlv -o "$output""${BASE}_1_$date"_ "$path_1""$FILE1"
    fi

    #check if cam was set to auto white balance. Non dualiso
    if [ "$(mlv_dump -v "$(cat /tmp/switchmini/path_1)"/"$FILE1" | grep -A6 'Block: WBAL' | awk 'FNR == 6 {print $2; exit}')" = "0" ] || [ -f /tmp/switchminiawb ]; then
        cd "$O""${BASE}_1_$date"
        . "$path_2"awb.command
        wi=$(exiv2 -pt "${BASE}"_1_"$date"_000000.dng | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; exit}')
        find . -maxdepth 1 -mindepth 1 -name '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.AsShotNeutral Rational $wi"
        cd ..
    fi

    echo "$(tail -n +2 /tmp/switchmini/MLVFILESa$1)" >/tmp/switchmini/MLVFILESa$1
done
