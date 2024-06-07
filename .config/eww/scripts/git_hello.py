#!/usr/bin/env python
# import sys
from bs4 import BeautifulSoup
import requests

url_start = "https://github.com/521xueweihan/HelloGitHub/tree/master"
response = requests.get(url_start)
if response.status_code == 200:
    soup = BeautifulSoup(response.text, "html.parser")
    tds = soup.find_all("td")
    a = []
    for td in tds:
        fd = td.find('a')
        if fd:
            a.append(fd)
    for ao in a:
        if '第' in ao.text:
            new = ao.attrs['href']
            break
    url = f"https://github.com{new}"
    
    response = requests.get(url)
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, "html.parser")
        a = soup.find_all("a")
        
        ret = "["
        for ao in a:
            if 'https://hellogithub.com/periodical/statistics/click' in ao.attrs['href']:
                url_project = "/".join(ao.attrs['href']
                                       .replace('https://hellogithub.com/periodical/statistics/click/?target=', '')
                                       .split("/")[-2:])
                ret += f'"{url_project}",'
        ret = ret[:-1]
        ret += "]"
        print(ret)
    else:
        print(f"Failed to fetch GitHub trending, status code: {response.status_code}")
else:
    print(f"Failed to fetch GitHub trending, status code: {response.status_code}")
