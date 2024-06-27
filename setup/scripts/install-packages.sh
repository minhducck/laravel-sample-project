#!/usr/bin/env bash
RUNNER_USERNAME=$1
sudo apt update && sudo apt install -y wget gnupg2 lsb-release
LC_ALL=C.UTF-8 sudo add-apt-repository ppa:ondrej/php

# Install PHP
sudo apt update;
sudo apt install --no-install-recommends -y php8.1 php8.1-common php8.1-gearman php8.1-imap php8.1-mbstring php8.1-pspell php8.1-snmp php8.1-xml php8.1-amqp php8.1-curl php8.1-mcrypt php8.1-opcache php8.1-soap php8.1-tidy php8.1-xmlrpc php8.1-apcu php8.1-gmp php8.1-pcov php8.1-xsl php8.1-intl php8.1-sqlite3 php8.1-bcmath php8.1-readline php8.1-ssh2 php8.1-uuid php8.1-yaml php8.1-bz2 php8.1-enchant php8.1-zip php8.1-fpm php8.1-mysql php8.1-xdebug php8.1-cli php8.1-zstd
sudo systemctl enable php8.1-fpm;
sudo systemctl start php8.1-fpm;

# Instal Nginx
sudo apt install -y nginx;
sudo systemctl enable nginx;
sudo systemctl start nginx;

# Install MariaDB
sudo apt update
sudo apt -y install mariadb-server
sudo systemctl enable mariadb.service
sudo systemctl start mariadb.service
mysql -sfu root < "mysql_root_setup.sql"

# Install GIT
sudo apt -y git

# Install Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer;
