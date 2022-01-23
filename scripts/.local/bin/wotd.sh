#!/usr/bin/sh
url='https://www.merriam-webster.com/wotd/feed/rss2'
echo $(curl $url)
