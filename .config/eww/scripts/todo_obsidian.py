#!/usr/bin/env python
import obsidiantools.api as otools
from pathlib import Path
from datetime import datetime
import markdown
from bs4 import BeautifulSoup
# Скрипт, возвращающий список сегодняшних задач из Ежедневника в Obsidian

VAULT_DIRECTORY = Path(r"/home/tsk/Storage")

latest_file_name = max(
    (d.stem for d in VAULT_DIRECTORY.joinpath('Ежедневник').iterdir() if d.is_file()),
    key=lambda x: datetime.strptime(x, '%Y-%m-%d') if x else None,
    default=None
)
vault = otools.Vault(VAULT_DIRECTORY).connect().gather()

md_text = vault.get_source_text(latest_file_name)

html_text = markdown.markdown(md_text)
print(html_text)
soup = BeautifulSoup(html_text, 'html.parser')

# f = False
# planes_list = []
# for tag in soup.find_all():
#     if f and tag.name == 'li':
#         planes_list.append(tag.text)
#     if tag.name == 'h3':
#         f = (True if tag.text == 'Планы' else False)

# print(planes_list)

f = False
ret = "["
for tag in soup.find_all():
    if f and tag.name == 'li':
        todo = tag.text.replace("\n", ". ")
        # print(todo)
        ret += f'"{todo}",'
    if tag.name == 'h3':
        f = (True if tag.text == 'Планы' else False)
ret = ret[:-1]
ret += "]"
print(ret)
