#!/bin/bash

# Exit on any error
set -e

# Install Package Manager
sudo apt update
sudo apt upgrade -y

#grant script execution permit
chmod +x ./install_prometheus.sh

#Installing Grafana
sudo apt install -y apt-transport-https
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

#Install Grafana
sudo apt-get update
sudo apt-get install grafana

#Enable and start the Grafana service:
sudo systemctl start grafana-server
sudo systemctl enable grafana-server

#Open your web browser and go to http://your-server-ip:3000.   and Username: admin  Password: admin

# Print completion message
echo "Prometheus, Grafana, and Node Exporter have been installed and started successfully."
echo "Prometheus: http://localhost:9090"
echo "Grafana: http://localhost:3000"
echo "Node Exporter: http://localhost:9100"
echo "Default Grafana credentials: Username: admin, Password: admin"