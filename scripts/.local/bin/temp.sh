#!/usr/bin/sh
temp=$(curl -s 'wttr.in/stockholm?format=1' )
echo $temp
