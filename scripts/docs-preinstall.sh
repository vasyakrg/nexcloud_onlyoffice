#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install mc htop zip -y

curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
sudo apt-get install postgresql -y

sudo -i -u postgres psql -c "CREATE DATABASE onlyoffice;"
sudo -i -u postgres psql -c "CREATE USER onlyoffice WITH password 'onlyoffice';"
sudo -i -u postgres psql -c "GRANT ALL privileges ON DATABASE onlyoffice TO onlyoffice;"

sudo apt-get install redis-server -y
sudo apt-get install rabbitmq-server -y
sudo apt-get install npm nginx-extras -y

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
sudo echo "deb http://download.onlyoffice.com/repo/debian squeeze main" | sudo tee /etc/apt/sources.list.d/onlyoffice.list

sudo apt-get install software-properties-common -y
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
