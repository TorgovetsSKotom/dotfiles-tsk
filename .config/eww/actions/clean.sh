#!/bin/sh
echo "Было занято в кеше ОЗУ"
free
echo 1 | swapoff -a && swapon -a
# Чистим pagecache:
sync
echo 2 | sudo tee -a /proc/sys/vm/drop_caches
echo "Стало свободно в ОЗУ"
free
exit 0