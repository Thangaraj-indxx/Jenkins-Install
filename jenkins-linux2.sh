#!/bin/bash

# Update package lists
sudo yum update -y

# Install OpenJDK 11
sudo yum install java-11-openjdk-devel -y

# Add Jenkins repository key to the keyring
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# Add Jenkins repository to yum sources
sudo tee /etc/yum.repos.d/jenkins.repo <<-'EOF'
[jenkins]
name=Jenkins
baseurl=https://pkg.jenkins.io/redhat-stable
gpgcheck=1
EOF

# Update package lists again
sudo yum update -y

# Install Jenkins
sudo yum install jenkins -y

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins to start on boot
sudo systemctl enable jenkins

# Wait for Jenkins to fully start (adjust sleep time as needed)
sleep 60

# Check Jenkins service status
sudo systemctl status jenkins

# Check if the initial admin password file exists
if [ -f /var/lib/jenkins/secrets/initialAdminPassword ]; then
    echo "Initial admin password:"
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
else
    echo "Initial admin password file not found. Jenkins might still be initializing."
fi
