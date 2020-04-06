#!/bin/bash

read -p $'\e[1;44m Type in folder name under /var/www/: \e[0m' folderName

sudo apt install php7.2 libapache2-mod-php7.2 php7.2-common php7.2-mysql php7.2-gmp php7.2-curl php7.2-intl php7.2-mbstring php7.2-xmlrpc php7.2-gd php7.2-bcmath php7.2-soap php7.2-ldap php7.2-imap php7.2-xml php7.2-cli php7.2-zip -y

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

