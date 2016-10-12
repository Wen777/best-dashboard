# Install Docker

sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates

sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee  -a /etc/apt/sources.list.d/docker.list

sudo apt-get update && sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual && sudo apt-get install -y docker-engine

sudo service docker start

sudo groupadd docker

sudo usermod -aG docker $USER

# sudo docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name db postgres:9.4
# sudo docker run -d -p 8069:8069 --name odoo --link db:db -t odoo
