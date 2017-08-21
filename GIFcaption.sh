#!/bin/bash
#export LC_ALL=ja_JP
fontsize=48
bgcolor=black
duration=300

while getopts "g:c:b:s:d:" option; do
  case $option in
    g)
        filename=$OPTARG
    ;;
    c)
        caption=$OPTARG
    ;;
    b)
        bgcolor=$OPTARG
    ;;
    s)
        fontsize=$OPTARG
    ;;
    d)
        captionduration=$((OPTARG*100))
    ;;
  esac
done

size=$(file "$filename"|grep  -Eo '[0-9]+ x .*'|tr -d ' ')
duration=$(magick identify -format "%T\n" "$filename"| awk '{t+=$0};END{print t}')
#[ ${#filename} -gt 28 ] && fontsize=32

fnbase=$(echo "$filename" | sed 's/\.[gG][iI][fF]$//')
if [ -z "$caption" ]; then
    caption=$fnbase
fi

magick convert -size $size -background $bgcolor -font c:/Windows/Fonts/meiryob.ttc \
  -pointsize $fontsize -fill white -gravity center \
  caption:"${caption}\n$(($duration/100))秒" "${fnbase}_fndur.gif"
#  label:"${filename}\n$(($duration/100))秒" "${filename}_fndur.gif"
magick convert "$filename" \( "${fnbase}_fndur.gif" -set delay $captionduration \) "${fnbase}_appended.gif"
