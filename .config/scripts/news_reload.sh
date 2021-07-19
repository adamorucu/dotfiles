#!/usr/bin/sh
# Checks how many unread articles are in newsboat reloads it and than checks again
# Notifies if the number has changed, there new articles were published.
prev=$(newsboat -x print-unread | awk '{print $1}')
newsboat -x reload
new=$(newsboat -x print-unread | awk '{print $1}')
diff=$(($new - $prev))

[ $diff != 0 ] && notify-send "Newsboat reloaded" "New articles ($diff) were found."
