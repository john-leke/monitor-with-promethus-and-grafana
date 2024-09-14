#!/bin/bash

# Exit on any error
set -e

# Install Package Manager
sudo apt update
sudo apt upgrade

# Define versions. Update this to the latest version
NODE_EXPORTER_VERSION="1.6.2"

# Download and install Node Exporter
wget https://github.com/prometheus/node_exporter/releases/download/v$NODE_EXPORTER_VERSION/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz
tar -xvf node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz
sudo mv node_exporter-$NODE_EXPORTER_VERSION.linux-amd64/node_exporter /usr/local/bin/

# Create Node Exporter systemd service file
cat <<EOF | sudo tee /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=nobody
Group=nogroup
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, start Node Exporter, and enable it
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

# Print completion message
echo "Node Exporter have been updated successfully."