#!/bin/bash

read -p $'\e[1;44m Type in folder name under /var/www/: \e[0m' folderName

sudo apt install unzip -y
wget https://jaist.dl.sourceforge.net/project/yetiforce/YetiForce%20CRM%205.x.x/5.3.0/YetiForceCRM-5.3.0-complete.zip
unzip YetiForce*.zip -d /var/www/$folderName

sudo chown -R www-data:www-data /var/www/killdevils.xyz/
sudo chmod -R 775 /var/www/killdevils.xyz/

ENTER_MARIADB=$(expect -c "
set timeout 2
spawn sudo mysql -u root -p
expect \"Enter password:\"
send \"\r\"
expect eof
")

echo "$SECURE_MYSQL"

CREATE DATABASE yetiforce;
CREATE USER 'yetiforceuser'@'localhost' IDENTIFIED BY 'new_password_here';
GRANT ALL ON yetiforce.* TO 'yetiforceuser'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT;

sudo a2ensite $folderName.conf
sudo a2enmod rewrite
sudo systemctl restart apache2.service

