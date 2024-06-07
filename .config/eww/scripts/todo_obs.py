#!/usr/bin/env python
import obsidiantools.api as otools
from pathlib import Path
from datetime import datetime
import markdown
from bs4 import BeautifulSoup
# Скрипт, возвращающий список сегодняшних задач из Ежедневника в Obsidian

VAULT_DIRECTORY = Path(r"/run/media/tsk/FATAL/Storage")

latest_file_name = max(
    (d.stem for d in VAULT_DIRECTORY.joinpath('Ежедневник').iterdir() if d.is_file()),
    key=lambda x: datetime.strptime(x, '%Y-%m-%d') if x else None,
    default=None
)
vault = otools.Vault(VAULT_DIRECTORY).connect().gather()

md_text = vault.get_source_text(latest_file_name)
f = False
ret = "["
for line in md_text.splitlines():
    if f and line.lstrip().startswith('*'):
        todo = line.lstrip()[2:].replace('\\', '')
        ret += f'"{todo}",'
    if line.startswith('### Планы'):
        f = True
    if line.startswith('### Делал на работе'):
        f = False
ret = ret[:-1]
ret += "]"
print(ret)
