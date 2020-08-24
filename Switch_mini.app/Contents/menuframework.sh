#!/bin/bash

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

do_nocs() {
    echo "nocs"
}

do_cs2() {
    echo "enable_cs2"
}

do_cs3() {
    echo "enable_cs3"
}

do_cs5() {
    echo "enable_cs5"
}

do_fixfp() {
    echo "fixfp"
}

do_fixcp() {
    echo "fixcp"
}

do_fixcp2() {
    echo "fixcp2"
}

do_nostripes() {
    echo "do_nostripes"
}

do_fstripes() {
    echo "fstripes"
}

do_bll() {
    echo "do_bll"
}

do_wll() {
    echo "wll"
}

do_compress() {
    echo "do_compress"
}

do_pass_through() {
    echo "do_pass_through"
}

do_no_audio() {
    echo "do_no_audio"
}

do_ato() {
    echo "do_ato"
}

do_fpn() {
    echo "do_fpn"
}

do_dfl() {
    echo "do_dfl"
}

do_btp() {
    echo "do_btp"
}

do_fdepth() {
    echo "do_fdepth"
}

do_fcpm() {
    echo "do_fcpm"
}

do_bpm() {
    echo "do_bpm"
}

do_awb() {
    echo "do_awb"
}

do_howto() {
    echo "do_howto"
}

do_reset_switches() {
    echo "do_reset_switches"
}

do_select_output_folder() {
    echo "do_select_output_folder"
}

do_set_thread_count() {
    echo "do_set_thread_count"
}

do_quit() {
    echo "Bye bye!"
    exit
}

while true; do
    clear

    cat <<EOF
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

    case $REPLY in
    "00" | 0) do_nocs ;;
    "01" | 1) do_cs2 ;;
    "02" | 2) do_cs3 ;;
    "03" | 3) do_cs5 ;;
    "04" | 4) do_fixfp ;;
    "05" | 5) do_fixcp ;;
    "06" | 6) do_fixcp2 ;;
    "07" | 7) do_nostripes ;;
    "08" | 8) do_fstripes ;;
    "09" | 9) do_bll ;;
    "10") do_wll ;;
    "11") do_compress ;;
    "12") do_pass_through ;;
    "13") do_no_audio ;;
    "14") do_ato ;;
    "15") do_fpn ;;
    "16") do_dfl ;;
    "17") do_btp ;;
    "18") do_fdepth ;;
    "19") do_fcpm ;;
    "20") do_bpm ;;
    "21") do_awb ;;

    "h") do_howto ;;
    "R") do_reset_switches ;;
    "O") do_select_output_folder ;;
    "TH") do_set_thread_count ;;
    "q") do_quit ;;
    "r") break ;;

    *) echo "Invalid option. Try another one." ;;
    esac

    sleep 1
done

echo "START RUNNING"
