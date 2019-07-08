#!/bin/bash

#-------------------------------------------------#
# Install onlyoffice
#
# enter password "onlyoffice" in setup prompt
#-------------------------------------------------#
sudo apt-get update
sudo apt-get install onlyoffice-documentserver -y


# sudo npm install -g npm -y
# sudo chown -R ncadmin /home/ncadmin/.npm
# sudo chmod -R 777 /home/ncadmin/.npm
#
# sudo supervisorctl stop all
#
# sudo apt-get install build-essential git -y
# cd /var/www/onlyoffice/documentserver/server/SpellChecker/
# sudo mv node_modules/ node_modules_old/
#
# sudo npm install -y
#
# sudo supervisorctl start all

sudo apt-get update
sudo apt-get install certbot python-certbot-nginx -y

sudo service nginx stop
sudo cp -f /tmp/ds.conf /etc/onlyoffice/documentserver/nginx/ds.conf

sudo certbot certonly --nginx

sudo cp -f /tmp/ds.new.conf /etc/onlyoffice/documentserver/nginx/ds.conf
#-------------------------------------------------#
# change domain name in ds.conf !!!
#-------------------------------------------------#
sudo reboot
#-------------------------------------------------#
# Add crontab job for SSL certificate auto-update
#
# >> sudo letsencrypt renew --dry-run --agree-tos
#Then I updated the crontab:
#
# >> sudo crontab -e
#This is the line I added:
#
# >> 12 3 * * *   sudo letsencrypt renew >> /var/log/letsencrypt/renew.log
