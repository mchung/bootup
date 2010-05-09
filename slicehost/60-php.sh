#
# Ubuntu 8.0.4
#
# Installs PHP
#

aptitude update -y

aptitude install -y php5-common php5-cgi php5-mysql php5-cli php5-gd

cp ~/bootstrap/config/etc/init.d/php-fastcgi /etc/init.d/php-fastcgi
chmod 755 /etc/init.d/php-fastcgi

cp ~/bootstrap/config/etc/default/php-fastcgi /etc/default/php-fastcgi

cp ~/bootstrap/config/etc/nginx/fastcgi_params /etc/nginx/fastcgi_params

/etc/init.d/php-fastcgi start
update-rc.d php-fastcgi defaults

# /etc/init.d/nginx restart
# /etc/init.d/apache restart