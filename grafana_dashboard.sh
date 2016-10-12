# Install InfluxDB

# Install Grafana

echo "deb https://packagecloud.io/grafana/stable/debian/ wheezy main" | sudo tee  -a /etc/apt/sources.list

curl https://packagecloud.io/gpg.key | sudo apt-key add -

sudo apt-get update && sudo apt install -y grafana

sudo service grafana-server start
