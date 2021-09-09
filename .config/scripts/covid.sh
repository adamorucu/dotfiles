#!/usr/bin/sh
echo -n " "
countries=$'turkey\npoland\nsweden'
basedir="$HOME/.cache/my/covid"
echo "$countries" | while read country
do
    newcase=$(curl -s https://corona-stats.online/$country | grep -i $country | awk -F '│' '{print $4}' | xargs | awk '{print $2}' | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g")
    newdeath=$(curl -s https://corona-stats.online/$country | grep -i $country | awk -F '│' '{print $6}' | xargs | awk '{print $2}' |  sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g")
    if [ $country = 'poland' ]; then
        case=$'pl'
        death=$'pldth'
    elif [ $country = 'turkey' ]; then
        case=$'tr'
        death=$'trdth'
    elif [ $country = 'sweden' ]; then
        case=$'swe'
        death=$'swedth'
    fi

    if [[ $newcase != '' ]] && [[ $(cat "$basedir/$case") != $newcase ]]; then
        echo $newcase > "$basedir/$case"
    fi
    
    if [[ $newdeath != '' ]] && [[ $(cat "$basedir/$death") != $newdeath ]]; then
        echo $newdeath > "$basedir/$death"
    fi

    # echo -n "$case $(cat "$basedir/$case") $(cat "$basedir/$death") "
done

echo "$countries" | while read country
do
    if [ $country = 'poland' ]; then
        case=$'pl'
        death=$'pldth'
    elif [ $country = 'turkey' ]; then
        case=$'tr'
        death=$'trdth'
    elif [ $country = 'sweden' ]; then
        case=$'swe'
        death=$'swedth'
    fi
    echo -n "$case $(cat "$basedir/$death")/$(cat "$basedir/$case") "
done
