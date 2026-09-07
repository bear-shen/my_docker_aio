#!/bin/bash

# ---------------------------------------
# base
apt update
apt upgrade -y
apt install -y tzdata curl wget git nano sudo net-tools xz-utils xzip b3sum xxhash unzip zip p7zip-full cron htop iftop fio webp
apt install -y supervisor rclone aria2

apt install -y nginx-full
apt install -y php-fpm php-cli php-pgsql php-gd php-curl php-mbstring php-json php-xml php-zip php-date php-readline php-bz2 php-mysql php-zip php-xml php-yaml php-uuid php-xml  

# ---------------------------------------
# pgroonga setup
apt install -y ca-certificates lsb-release
wget https://packages.groonga.org/ubuntu/groonga-apt-source-latest-$(lsb_release --codename --short).deb
apt install -y ./groonga-apt-source-latest-$(lsb_release --codename --short).deb
rm -f groonga-apt-source-latest-$(lsb_release --codename --short).deb
apt update
apt install -y postgresql-16-pgroonga

apt install -y ffmpeg

# ---------------------------------------
# nvm and node setup
chmod +x ${SRC}/nvm_install.sh
./nvm_install.sh
# source nvm
\. "$HOME/.nvm/nvm.sh"
nvm install 24
npm install -g typescript @types/node @tsconfig/node24

# ---------------------------------------
# samba and winbind setup
apt install -y samba-common-bin winbind
# nano /etc/nsswitch.conf
# hosts:          files dns wins
# OR:
sed -i '/^hosts:/ {/wins/! s/$/ wins/}' /etc/nsswitch.conf


