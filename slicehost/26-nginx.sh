#
# Ubuntu 8.0.4
#
# Installs Nginx
#

aptitude update -y

aptitude install -y nginx

service nginx restart
