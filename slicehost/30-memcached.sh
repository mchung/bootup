#
# Ubuntu 8.0.4
#
# Installs memcached. Installs memcache-client gem if Rubygems is installed
#

aptitude update -y

aptitude install -y memcached

if [ -e "`which gem`" ]
then
  gem install memcache-client
fi