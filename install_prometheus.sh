#!/bin/bash

# Exit on any error
set -e

# Install Package Manager
sudo apt update
sudo apt upgrade -y

#grant script execution permit
chmod +x ./install_prometheus.sh

#Create a system user for Prometheus
sudo useradd --no-create-home --shell /bin/false prometheus

#Create the directories in which we will be storing our configuration files and libraries:
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

#Set the ownership of the /var/lib/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus
cd /tmp/

#Download the Prometheus setup using wget
wget https://github.com/prometheus/prometheus/releases/download/v3.0.0-beta.0/prometheus-3.0.0-beta.0.linux-amd64.tar.gz

#Extract the files using tar
tar -xvf prometheus-3.0.0-beta.0.linux-amd64.tar.gz

#Move the configuration file and set the owner to the prometheus user
cd prometheus-3.0.0-beta.0.linux-amd64.tar.gz
sudo mv console* /etc/prometheus
sudo mv prometheus.yml /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus

#Move the binaries and set the owner
sudo mv prometheus /usr/local/bin/
sudo chown prometheus:prometheus /usr/local/bin/prometheus

sudo nano /etc/prometheus/prometheus.yml


#Creating Prometheus Systemd file
cat >> 
[Unit]

Description=Prometheus

Wants=network-online.target

After=network-online.target

[Service]

User=prometheus

Group=prometheus

Type=simple

ExecStart=/usr/local/bin/prometheus \

— config.file /etc/prometheus/prometheus.yml \

— storage.tsdb.path /var/lib/prometheus/ \

— web.console.templates=/etc/prometheus/consoles \

— web.console.libraries=/etc/prometheus/console_libraries

[Install]

WantedBy=multi-user.target

Output


#Reload systemd
sudo systemctl daemon-reload

#Start, Enable, Status Prometheus service
sudo systemctl start prometheus
sudo systemctl enable prometheus
sudo systemctl status prometheus

#Launch the Prometheus server by executing the following command:
#./prometheus –config.file=prometheus.yml (or) ./prometheus

#Open your web browser and access http://server-ip-address:9090. If Prometheus is running correctly, you will see the Prometheus web interface.
