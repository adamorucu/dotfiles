#!/usr/bin/sh
temp=$(curl -s 'wttr.in/izmir?format=1' | xargs | awk -F ' ' '{print $2}')
echo $temp
