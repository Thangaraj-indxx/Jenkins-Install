#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run this script as root"
  exit 1
fi

# Detect the Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
else
    OS=$(uname -s)
    VER=$(uname -r)
fi

# Function to install Jenkins on Ubuntu
install_jenkins_ubuntu() {
    # Add the Jenkins Debian repository key to the system
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

    # Add the Jenkins repository to the system
    echo "deb https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list

    # Update apt package index
    sudo apt update

    # Install Java (required for Jenkins)
    sudo apt install -y openjdk-8-jdk

    # Install Jenkins
    sudo apt install -y jenkins
}

# Function to install Jenkins on Amazon Linux 2
install_jenkins_amazon_linux() {
    # Install Java (required for Jenkins)
    sudo amazon-linux-extras install -y java-openjdk11

    # Add Jenkins repository to the system
    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

    # Import Jenkins RPM key to the system
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

    # Update YUM package index
    sudo yum update -y

    # Install Jenkins
    sudo yum install -y jenkins
}

# Install Jenkins based on the detected Linux distribution
if [ "$OS" = "Ubuntu" ]; then
    install_jenkins_ubuntu
elif [ "$OS" = "Amazon Linux" ]; then
    install_jenkins_amazon_linux
else
    echo "Unsupported OS: $OS"
    exit 1
fi

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins to start on boot
sudo systemctl enable jenkins

# Print initial admin password location and instructions
echo "Jenkins installation completed."
echo "Please retrieve your initial admin password from the following location:"
echo "/var/lib/jenkins/secrets/initialAdminPassword"
echo "Then, access Jenkins using your server's IP or domain name on port 8080."
