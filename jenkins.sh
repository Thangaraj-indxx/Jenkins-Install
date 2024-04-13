#!/bin/bash

# Update package lists
sudo apt update

# Install OpenJDK 11
sudo apt install openjdk-11-jdk -y

# Add Jenkins repository key to the keyring
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo gpg --dearmor -o /usr/share/keyrings/jenkins-keyring.gpg

# Add Jenkins repository to apt sources
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.gpg] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package lists again
sudo apt update

# Install Jenkins
sudo apt install jenkins -y

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins to start on boot
sudo systemctl enable jenkins

# Wait for Jenkins to fully start
sleep 30

# Check Jenkins service status
sudo systemctl status jenkins

# Display initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
