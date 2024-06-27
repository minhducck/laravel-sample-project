#!/usr/bin/env bash
echo "[www]
user = $1
group = $1

listen = /var/run/php/php8.1-fpm.sock
listen.backlog = 65536
listen.owner = $1
listen.group = $1

pm = static
pm.max_children = 8
pm.max_requests = 65535
" | sudo tee /etc/php/8.1/fpm/pool.d/www.conf
sudo systemctl restart php8.1-fpm;
