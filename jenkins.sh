#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run this script as root"
  exit 1
fi

# Install Java (required for Jenkins)
apt update
apt install -y openjdk-8-jdk

# Download and install Jenkins Debian package
wget -q -O /tmp/jenkins.deb https://pkg.jenkins.io/debian-stable/binary/jenkins_2.337_all.deb
dpkg -i /tmp/jenkins.deb

# Start Jenkins service
systemctl start jenkins

# Enable Jenkins to start on boot
systemctl enable jenkins

# Print initial admin password location and instructions
echo "Jenkins installation completed."
echo "Please retrieve your initial admin password from the following location:"
echo "/var/lib/jenkins/secrets/initialAdminPassword"
echo "Then, access Jenkins using your server's IP or domain name on port 8080."
