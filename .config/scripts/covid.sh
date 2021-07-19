#!/usr/bin/sh
countries=$'turkey\npoland\nsweden'
echo -n " "
echo "$countries" | while read country
do
    deaths=$(curl -s https://corona-stats.online/$country | grep -i $country | awk -F '│' '{print $5}' | xargs | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g")
    if [ $country = 'poland' ]; then
        flag="pl"
    elif [ $country = 'turkey' ]; then
        flag="tr"
    elif [ $country = 'sweden' ]; then
        flag="sw"
    fi
    echo -n "$flag $deaths "
done
