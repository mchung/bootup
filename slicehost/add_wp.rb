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

puts "mkdir -p /var/local/wp/#{wordpress_domain}/{public,private,log,backup}"
puts "chown -R app:app /var/local/wp/#{wordpress_domain}"
puts "copy over #{wordpress_domain} the nginx wordpress # need to generate it and dump it into /etc/nginx/sites-available/"
puts "ln -s /etc/nginx/sites-available/#{wordpress_domain} /etc/nginx/sites-enabled/#{wordpress_domain}"

puts "make-ssl-cert /usr/share/ssl-cert/ssleay.cnf /etc/ssl/certs/selfsigned.pem # Use ^h to backspace"
puts "cd /var/local/wp/#{wordpress_domain}/private"
puts "openssl genrsa -des3 -out #{wordpress_domain}.key 1024"
puts "openssl req -new -key #{wordpress_domain}.key -out #{wordpress_domain}.csr"
puts "cp #{wordpress_domain}.key #{wordpress_domain}.key.orig"
puts "openssl rsa -in #{wordpress_domain}.key.orig -out #{wordpress_domain}.key"
puts "openssl x509 -req -days 3650 -in #{wordpress_domain}.csr -signkey #{wordpress_domain}.key -out #{wordpress_domain}.crt"
puts "cp #{wordpress_domain}.crt /etc/ssl/certs/"
puts "cp #{wordpress_domain}.key /etc/ssl/private/"

puts "mysqladmin create db"
puts "mysqladmin create user"
puts "setup SSL"
puts "restart nginx"
