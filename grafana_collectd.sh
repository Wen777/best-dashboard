# add ppa
curl http://pkg.ci.collectd.org/pubkey.asc | sudo apt-key add -

# echo "deb http://pkg.ci.collectd.org/deb/ trusty collectd-5.5" > /etc/apt/sources.list.d/collectd-ci.list
echo "deb http://pkg.ci.collectd.org/deb/ trusty collectd-5.5" | sudo tee  -a /etc/apt/sources.list.d/collectd-ci.list

sudo apt-get update && sudo apt-get install -y collectd

sudo rm /etc/collectd/collectd.conf

sudo wget -O /etc/collectd/collectd.conf https://gist.githubusercontent.com/Wen777/923178d306b96384c925/raw

sudo service collectd restart
