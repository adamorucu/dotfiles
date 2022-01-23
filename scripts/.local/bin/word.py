#!/usr/bin/python
import requests
from bs4 import BeautifulSoup

url = 'https://www.merriam-webster.com/word-of-the-day'
page = requests.get(url)
if page.status_code == 200:
    html = page.content
else:
    print("Can't reach page")
    exit()

soup = BeautifulSoup(html, 'html.parser')
print(soup)
