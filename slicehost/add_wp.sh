#
# Ubuntu 8.0.4
#
# Adds a WordPress instance
#

if [ ! -n "$WORDPRESS" ]
then 
  echo "Must set domain"
  echo "WORDPRESS=blog.haikuist.com DB=haikuist DBUSER=haikuist `basename $0`"
  exit
fi

# Create the directory in /var/local

mkdir /var/local/wp/$WORDPRESS

# b. make-ssl-cert /usr/share/ssl-cert/ssleay.cnf /etc/ssl/certs/selfsigned.pem # Use ^h to backspace
# c. openssl genrsa -des3 -out myssl.key 1024


# Add the instance to nginx
# Create database user
# Create database 
# Setup the SSL
# Restart nginx

# http://articles.slicehost.com/2007/11/26/ubuntu-gutsy-generating-a-self-signed-ssl-certificate
# http://articles.slicehost.com/2007/12/19/ubuntu-gutsy-self-signed-ssl-certificates-and-nginx
# http://articles.slicehost.com/2007/12/19/ubuntu-gutsy-nginx-ssl-and-vhosts