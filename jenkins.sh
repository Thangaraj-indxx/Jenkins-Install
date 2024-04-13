#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run this script as root"
  exit 1
fi

# Install Java (required for Jenkins)
apt update
apt install -y openjdk-8-jdk

# Add the Jenkins Debian repository key to the system
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -

# Add the Jenkins repository to the system
echo "deb https://pkg.jenkins.io/debian binary/" > /etc/apt/sources.list.d/jenkins.list

# Update apt package index
apt update

# Install Jenkins
apt install -y jenkins

# Start Jenkins service
systemctl start jenkins

# Enable Jenkins to start on boot
systemctl enable jenkins

# Print initial admin password location and instructions
echo "Jenkins installation completed."
echo "Please retrieve your initial admin password from the following location:"
echo "/var/lib/jenkins/secrets/initialAdminPassword"
echo "Then, access Jenkins using your server's IP or domain name on port 8080."
