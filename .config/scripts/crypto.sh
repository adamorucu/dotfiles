symbols=$'BTC\nETH\nSOL\nDOT\nADA\nXRP'

echo "$symbols" | while read coin
do
    # change=$(curl -s "rate.sx/$coin?qFT" | grep "change.*(.*)" | awk -F '[()]' '{print $2}')
    # price=$(curl -s "rate.sx/$coin?qFT" | grep -P "avg.*?//" | awk '{print $2}'| sed 's/\$//' )
    price=$( python -c "import pandas_datareader as w; print(sum(list(w.DataReader('$coin-USD', 'yahoo').iterrows())[-1][1][:4])/4)" )

    price=$( echo "$price" | sed 's/\./,/' )
    price=$( printf "%.2f" "$price" )
    # rounded=$( printf "%.1f" "$price" )
    if [ $coin = "BTC" ]; then
        icon=""
        price=$( echo "$price" | awk -F',' '{print $1}' )
    elif [ $coin = "ETH" ]; then
        icon=""
        price=$( echo "$price" | awk -F',' '{print $1}' )
    elif [ $coin = "ADA" ]; then
        icon=""
    elif [ $coin = "XRP" ]; then
        icon=""
    elif [ $coin = "DOT" ]; then
        icon=""
    elif [ $coin = "SOL" ]; then
        icon=""
    fi
    echo -n "$icon $price  "
done
