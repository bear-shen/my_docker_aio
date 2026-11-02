#!/bin/bash

echo "================================================================="
echo "Starting base setup..."
apt update
apt upgrade -y
apt install -y tzdata curl wget git nano sudo net-tools xz-utils xzip b3sum xxhash unzip zip p7zip-full cron htop iftop fio webp libatomic1
apt install -y supervisor rclone aria2


echo "================================================================="
echo "Installing nginx..."
apt install -y nginx-full
echo "Installing PHP and extensions..."
apt install -y php-fpm php-cli php-pgsql php-gd php-curl php-mbstring php-json php-xml php-zip php-date php-readline php-bz2 php-mysql php-zip php-xml php-yaml php-uuid php-xml  

echo "Installing PHP pie..."
curl -fL --output /tmp/pie.phar https://github.com/php/pie/releases/latest/download/pie.phar
mv /tmp/pie.phar /usr/local/bin/pie
chmod +x /usr/local/bin/pie

echo "Installing Composer..."
EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')" 
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" 
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")" 
if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then 
    echo 'ERROR: Invalid installer checksum' >&2; 
    rm composer-setup.php; exit 1; 
fi 
php composer-setup.php --quiet 
rm composer-setup.php
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

echo "Installing FastChart via PHP pie..."
pie install iliaal/fastchart --quiet

echo "================================================================="
echo "Setting up pgroonga..."
apt install -y ca-certificates lsb-release
wget https://packages.groonga.org/ubuntu/groonga-apt-source-latest-$(lsb_release --codename --short).deb
apt install -y ./groonga-apt-source-latest-$(lsb_release --codename --short).deb
rm -f groonga-apt-source-latest-$(lsb_release --codename --short).deb
apt update
apt install -y postgresql-18-pgroonga


echo "================================================================="
echo "Installing ffmpeg..."
apt install -y ffmpeg


echo "================================================================="
echo "Setting up nvm and node..."
# nvm and node setup
chmod +x ${SRC}/nvm_install.sh
./nvm_install.sh
# source nvm
\. "$HOME/.nvm/nvm.sh"
nvm install 26
npm install -g typescript @types/node @tsconfig/node26


echo "================================================================="
echo "Setting up samba and winbind..."
# samba and winbind setup
apt install -y samba-common-bin winbind
# nano /etc/nsswitch.conf
# hosts:          files dns wins
# OR:
sed -i '/^hosts:/ {/wins/! s/$/ wins/}' /etc/nsswitch.conf


