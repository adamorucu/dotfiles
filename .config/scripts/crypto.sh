symbols=$'BTC\nETH\nADA\nDOT\nXRP'

echo "$symbols" | while read coin
do
    price=$(curl -s "rate.sx/$coin?qFT" | grep "change.*(.*)" | awk -F '[()]' '{print $2}')
    if [ $coin = "BTC" ]; then
        icon=""
    elif [ $coin = "ETH" ]; then
        icon=""
    elif [ $coin = "ADA" ]; then
        icon=""
    elif [ $coin = "XRP" ]; then
        icon=""
    elif [ $coin = "DOT" ]; then
        icon=""
    fi
    echo -n "$icon $price  "
done
