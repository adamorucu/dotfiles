#!/usr/bin/sh
echo -n " "
countries=$'turkey\npoland\nsweden'
basedir="$HOME/.cache/my/covid"
echo "$countries" | while read country
do
    new=$(curl -s https://corona-stats.online/$country | grep -i $country | awk -F '│' '{print $4}' | xargs | awk '{print $2}' | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g")
    if [ $country = 'poland' ]; then
        flag=$'pl'
    elif [ $country = 'turkey' ]; then
        flag=$'tr'
    elif [ $country = 'sweden' ]; then
        flag=$'swe'
    fi

    if [[ $new != '' ]] && [[ $(cat "$basedir/$flag") != $new ]]; then
        echo $new > "$basedir/$flag"
    fi

    echo -n "$flag $(cat "$basedir/$flag") "
done
