#!/usr/bin/env bash
#export LC_ALL=ja_JP
fontsize=48
bgcolor=black
captionduration=300

usage() {
  echo -e "Usage:\n$0 -g (gif filename) -c (caption string) -b (background color) \\ \n  -s (font size) -d (seconds to show caption image)\n"
}

while getopts "g:c:b:s:d:h" option
do
  case $option in
    g) filename=$OPTARG ;;
    c) caption=$OPTARG ;;
    b) bgcolor=$OPTARG ;;
    s) fontsize=$OPTARG ;;
    d) captionduration=$((OPTARG*100)) ;;
    h) usage; exit 1;;
  esac
done

[ -z "$filename" ] && usage && exit 1

size=$(file "$filename"|grep  -Eo '[0-9]+ x .*'|tr -d ' ')
duration=$(magick identify -format "%T\n" "$filename"| awk '{t+=$0};END{print t}')

fnbase=$(echo "$filename" | sed 's/\.[gG][iI][fF]$//')
if [ -z "$caption" ]; then
    caption=$fnbase
fi

# Create a image file using 2 strings.
magick convert -size $size -background $bgcolor -font c:/Windows/Fonts/meiryob.ttc \
  -pointsize $fontsize -fill white -gravity center \
  caption:"${caption}\n$(($duration/100))秒" "${fnbase}_fndur.gif"
#  label:"${caption}\n$(($duration/100))秒" "${fnbase}_fndur.gif"

magick convert "$filename" \( "${fnbase}_fndur.gif" -set delay $captionduration \) "${fnbase}_appended.gif"
