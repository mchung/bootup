#
# Ubuntu 8.0.4
#
# Installs FreeImage. Installs image_science gem if Rubygems is installed
#

aptitude update -y

aptitude install -y libfreeimage-dev libfreeimage3 

if [ -e "`which gem`" ]
then
  gem install image_science xml-simple builder mime-types
fi
