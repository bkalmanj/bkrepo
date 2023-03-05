#!/bin/bash
#Install Apache and configure proxy module
apt update && apt install -y apache2 
a2enmod proxy 
a2enmod proxy_http
webapp=$1

#Configure Apache conf
cat <<EOF > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>

        ProxyPreserveHost On
        ProxyPass / http://$webapp/
        ProxyPassReverse / http://$webapp/
        DocumentRoot /var/www/html
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>
EOF

#Restart Apache
systemctl restart apache2