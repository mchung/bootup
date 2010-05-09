#
# Ubuntu 8.0.4
#
# Installs MySQL packages. Installs MySQL gem if Rubygems is installed
#
# TODO: How to set root password non-interactively?
#

aptitude update -y

MY_VER=5.1

aptitude install -y mysql-server-$MY_VER mysql-client-$MY_VER libmysqlclient15-dev

if [ -e "`which gem`" ]
then
  # install mysql gem
  gem install mysql
fi

# TODO: Create a default cnf file
# sudo cp custom.cnf /etc/mysql/my.cnf

# restart to load changes
service mysql restart
