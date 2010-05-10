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

WORDPRESS = {}
optparse = OptionParser.new do |opts|
  opts.banner = help
  
  opts.on("--wordpress WORDPRESS", "Mandatory domain.tld") do |arg|
    WORDPRESS[:wpdom] = arg
  end
  
  opts.on("--dbname DBNAME", "Mandatory dbname") do |arg|
    WORDPRESS[:dbname] = arg
  end
  
  opts.on("--dbuser DBUSER", "Mandatory dbuser") do |arg|
    WORDPRESS[:dbuser] = arg
  end
  
  opts.on("--dbpass DBPASS", "Mandatory dbpass") do |arg|
    WORDPRESS[:dbpass] = arg
  end
  
  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end.parse!

wpdom = WORDPRESS[:wpdom]
dbname = WORDPRESS[:dbname]
dbuser = WORDPRESS[:dbuser]
dbpass = WORDPRESS[:dbpass]

raise "Requires --wordpress, --dbname, --dbuser, --dbpass" unless wpdom && dbname && dbuser && dbpass

puts "mkdir -p /var/local/wp/#{wpdom}/{public,private,log,backup}"
puts ""
puts "Copy nginx-wp to /var/local/wp/#{wpdom}/private/nginx"
puts ""
puts "ln -s /var/local/wp/#{wpdom}/private/nginx /etc/nginx/sites-enabled/#{wpdom}"
puts ""

puts "make-ssl-cert /usr/share/ssl-cert/ssleay.cnf /etc/ssl/certs/selfsigned.pem # Use ^h to backspace"
puts ""

puts "cd /var/local/wp/#{wpdom}/private"
puts "openssl genrsa -des3 -out #{wpdom}.key 1024"
puts "openssl req -new -key #{wpdom}.key -out #{wpdom}.csr"
puts "cp #{wpdom}.key #{wpdom}.key.orig"
puts "openssl rsa -in #{wpdom}.key.orig -out #{wpdom}.key"
puts "openssl x509 -req -days 3650 -in #{wpdom}.csr -signkey #{wpdom}.key -out #{wpdom}.crt"
puts "cp #{wpdom}.crt /etc/ssl/certs/"
puts "cp #{wpdom}.key /etc/ssl/private/"
puts "service nginx restart"
puts ""

cat =<<EOF
CREATE DATABASE #{dbname};
GRANT ALL ON #{dbname}.* TO #{dbuser}@localhost IDENTIFIED BY "#{dbpass}"
EOF
# cat > /tmp/mysql.sql <<EOF
puts "/var/local/wp/#{wpdom}/private/mysql"
puts cat
puts "mysql -u root -p < /tmp/mysql.sql"
puts ""

puts "cd /var/local/wp/#{wpdom}/public"
puts "svn co http://svn.automattic.com/wordpress/tags/2.9.2 ."
puts "chown -R app:app /var/local/wp/#{wpdom}"
puts "chmod -R 755 /var/local/wp/#{wpdom}"
puts "chmod -R -s /var/local/wp/#{wpdom}"
puts ""

puts "Setup wordpress"
puts "Add to wp-config.php"
puts "define('FORCE_SSL_LOGIN', true);"
puts "define('FORCE_SSL_ADMIN', true);"
puts ""