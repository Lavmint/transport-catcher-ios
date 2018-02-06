#!/bin/bash

INK=/Applications/Inkscape.app/Contents/Resources/bin/inkscape

if [[ -z "$1" ]] 
then
	echo "SVG file needed."
	exit;
fi

BASE="/Users/averkinao/Documents/AppIconTemplate/transport"
SVG="$1"


# $INK -z -D -e "$BASE-20@1x.png" -f 	$SVG -w 20 -h 20
# $INK -z -D -e "$BASE-20@2x.png" -f 	$SVG -w 40 -h 40
# $INK -z -D -e "$BASE-20@3x.png" -f 	$SVG -w 60 -h 60

# $INK -z -D -e "$BASE-76@1x.png" -f 	$SVG -w 76 -h 76
# $INK -z -D -e "$BASE-76@2x.png" -f 	$SVG -w 152 -h 152

# $INK -z -D -e "$BASE-60@2x.png" -f 	$SVG -w 120 -h 120
# $INK -z -D -e "$BASE-60@3x.png" -f 	$SVG -w 180 -h 180

# $INK -z -D -e "$BASE-1024@1x.png" -f 	$SVG -w 1024 -h 1024
$INK -z -D -e "$BASE-83.5@2x.png" -f 	$SVG -w 167 -h 167
