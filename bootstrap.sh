#!/bin/bash

cp /vagrant/sources.list /etc/apt/sources.list

apt-get install python-software-properties
add-apt-repository ppa:ondrej/php
apt-get update

apt-get install php7.2 php-pear php7.2-curl php7.2-dev php7.2-mbstring php7.2-zip php7.2-xml php7.2-fpm -y

pecl install mongodb
echo "extension=mongodb.so" > /etc/php/7.2/mods-available/mongodb.ini
cd /etc/php/7.2/fpm/conf.d && ln -s /etc/php/7.2/mods-available/mongodb.ini 20-mongodb.ini
cd /etc/php/7.2/cli/conf.d && ln -s /etc/php/7.2/mods-available/mongodb.ini 20-mongodb.ini
pecl install swoole
echo "extension=swoole.so" > /etc/php/7.2/mods-available/swoole.ini
cd /etc/php/7.2/fpm/conf.d && ln -s /etc/php/7.2/mods-available/swoole.ini 20-swoole.ini
cd /etc/php/7.2/cli/conf.d && ln -s /etc/php/7.2/mods-available/swoole.ini 20-swoole.ini
pecl install redis
echo "extension=redis.so" > /etc/php/7.2/mods-available/redis.ini
cd /etc/php/7.2/fpm/conf.d && ln -s /etc/php/7.2/mods-available/redis.ini 20-redis.ini
cd /etc/php/7.2/cli/conf.d && ln -s /etc/php/7.2/mods-available/redis.ini 20-redis.ini

curl -s "https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh" | bash
apt-get install php7.2-phalcon -y

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer
composer config -g repo.packagist composer https://packagist.phpcomposer.com

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
apt-get update
apt-get install mongodb-org -y

apt-get install nginx -y
apt-get install redis-server -y
apt-get install git-core -y