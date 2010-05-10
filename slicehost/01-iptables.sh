#
# Ubuntu 8.0.4
#
# Update iptables
#

iptables-restore < ~/bootstrap/config/etc/iptables.up.rules
iptables-save > /etc/iptables.up.rules

perl -pi.bak -e "s/iface lo inet loopback/iface lo inet loopback\npre-up iptables-restore < \/etc\/iptables.up.rules/gi;" 
                /etc/network/interfaces
