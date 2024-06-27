#!/usr/bin/env bash
WEB_USER=$1;
echo "TUNING FOR USER $WEB_USER";

echo "net.core.somaxconn = 65536
net.core.netdev_max_backlog = 65535
fs.file-max = 65536" | sudo tee -a /etc/sysctl.conf;

echo "$WEB_USER       soft    nofile   10000
$WEB_USER       hard    nofile  65536
" | sudo tee -a /etc/security/limits.conf;

sudo sysctl -p;

sudo systemctl restart nginx php8.1-fpm;

