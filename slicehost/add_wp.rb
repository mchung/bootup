#!/usr/bin/env ruby

#
# Adds a WordPress instance
#

require 'erb'
require 'optparse'
require 'pp'

help = <<HELP
#{__FILE__} adds a WordPress site
 
Basic Command Line Usage:
  #{__FILE__} --wordpress=foo.com
  Options:
HELP

wordpress_domain = nil
optparse = OptionParser.new do |opts|
  opts.banner = help
  
  opts.on("--wordpress WORDPRESS", "Mandatory domain.tld") do |host|
    wordpress_domain = host
  end
  
  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end.parse!

puts wordpress_domain

# if [ ! -n "$WORDPRESS" ]
# then 
#   echo "Must set domain"
#   echo "WORDPRESS=blog.haikuist.com DB=haikuist DBUSER=haikuist `basename $0`"
#   exit
# fi

puts "mkdir /var/local/wp/#{wordpress_domain}"
puts "copy over the nginx wordpress"
puts "make-ssl-cert /usr/share/ssl-cert/ssleay.cnf /etc/ssl/certs/selfsigned.pem # Use ^h to backspace"
puts "openssl genrsa -des3 -out myssl.key 1024"
puts "mysqladmin create db"
puts "mysqladmin create user"
puts "setup SSL"
puts "restart nginx"

# http://articles.slicehost.com/2007/11/26/ubuntu-gutsy-generating-a-self-signed-ssl-certificate
# http://articles.slicehost.com/2007/12/19/ubuntu-gutsy-self-signed-ssl-certificates-and-nginx
# http://articles.slicehost.com/2007/12/19/ubuntu-gutsy-nginx-ssl-and-vhosts