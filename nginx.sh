#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export HOSTNAME=$(curl -s http://169.254.169.254/latest/meta-data/hostname)
export PUBLIC_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

# Install Nginx
apt-get -y update
apt-get -y install nginx

# Write hostname and IP address to index.html
mkdir -p /var/www/html
sed -i -e "s|/usr/share/nginx/html|/var/www/html|g" /etc/nginx/sites-available/default
echo -e "<html><body><strong>Datinode:</strong> $HOSTNAME<br><strong>IP Address:</strong> $PUBLIC_IPV4</html></body>" \
    > /var/www/html/index.html
service nginx restart
