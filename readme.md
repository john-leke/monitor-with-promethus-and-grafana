
Prometheus:

Create user and directories.
Download, extract, and move Prometheus binaries and configuration files.
Configure Prometheus.
Set up a systemd service and start Prometheus.
Grafana:

Add the Grafana repository and install Grafana.
Use the pre-configured systemd service to start and enable Grafana.

Both Prometheus and Grafana should now be running on your server, ready to monitor and visualize metrics. If you encounter any issues or need additional help, feel free to ask!

ansible-playbook -i /path/to/inventory install_scripts.yml