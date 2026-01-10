#!/bin/bash

\. "$HOME/.nvm/nvm.sh"
nvm install 24

apt update
apt upgrade -y
apt install -y tzdata curl wget git nano sudo net-tools xz-utils xzip b3sum xxhash unzip

apt install -y nginx-full
apt install -y php-fpm php-cli php-pgsql php-gd php-curl php-mbstring php-json php-xml php-zip php-date php-readline php-bz2 

apt install -y ca-certificates lsb-release wget
wget https://packages.groonga.org/ubuntu/groonga-apt-source-latest-$(lsb_release --codename --short).deb
apt install -y ./groonga-apt-source-latest-$(lsb_release --codename --short).deb
rm -f groonga-apt-source-latest-$(lsb_release --codename --short).deb
apt update
apt install -y postgresql-16-pgroonga

apt install -y ffmpeg
