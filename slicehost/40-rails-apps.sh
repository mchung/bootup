#
# Ubuntu 8.0.4
#
# Setups Rails directory (Not entirely useful, yet)
#

export USERNAME=app
sh add_user.sh
mkdir -p /var/local
chown app:app /var/local
