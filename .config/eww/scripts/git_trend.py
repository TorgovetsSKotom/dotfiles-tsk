#!/usr/bin/env python
import sys
from bs4 import BeautifulSoup
import requests

type_ret = sys.argv[1] if len(sys.argv) > 1 else 0

response = requests.get('https://github.com/trending')
if response.status_code == 200:
    soup = BeautifulSoup(response.text, "html.parser")
    feedbacks = soup.find_all("article", class_="Box-row")
    ret = "["
    for feedback in feedbacks:
        name = feedback.find('a', class_="Link").attrs['href'][1:]
        if type_ret == 'name':
            ret += f'"{name}",'
        elif type_ret == 'url':
            url = f'https://github.com/{name}'
            ret += f'"{url}",'
        else:
            url = f'https://github.com/{name}'
            ret += "{"
            ret += f'"name":"{name}","url":"{url}"'
            ret += "},"
    if type_ret == 0:
        ret = ret[:-2]
        ret += "}]"
    else:
        ret = ret[:-1]
        ret += "]"
    print(ret)
else:
    print(f"Failed to fetch GitHub trending, status code: {response.status_code}")
