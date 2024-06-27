#!/usr/bin/env bash
echo "CONFIGURE USER $1 DOMAIN $2";

echo "upstream fastcgi_backend {
          server   unix:/var/run/php/php8.1-fpm.sock;
      }
" | sudo tee /etc/nginx/conf.d/fpm.conf

echo "server {
      listen 80;
      server_name $2;
      root /home/runner/www/laravel-sample-project/public/;

      index index.php index.html index.html;

      location / {
          index index.php index.html;
    try_files \$uri \$uri/ /index.php?\$query_string;
      }


      location ~ \.php$ {
          try_files \$uri =404;
          fastcgi_pass   fastcgi_backend;
          fastcgi_index index.php;
          fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
          include fastcgi_params;
      }

      location ~ /\.ht {
    deny all;
      }

      location ~ /.well-known {
          allow all;
      }
  }
" | sudo tee /etc/nginx/sites-enabled/laravel;

echo "user $1;
      worker_processes 4;
      pid /run/nginx.pid;
      error_log /var/log/nginx/error.log;
      include /etc/nginx/modules-enabled/*.conf;

      events {
      	worker_connections 1024;
      }

      http {
      	sendfile on;
      	tcp_nopush on;
      	types_hash_max_size 2048;
      	include /etc/nginx/mime.types;
      	default_type application/octet-stream;
      	ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE
      	ssl_prefer_server_ciphers on;
      	access_log /var/log/nginx/access.log;
      	gzip on;
      	include /etc/nginx/conf.d/*.conf;
      	include /etc/nginx/sites-enabled/*;
      }
" | sudo tee /etc/nginx/nginx.conf;
