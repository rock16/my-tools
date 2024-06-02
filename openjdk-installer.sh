#!/bin/bash

# Prompt for OpenJDK version
read -p "Enter desired OpenJDK version (e.g., 17, 11): " desired_version

# Check if provided version is valid
if [[ ! "$desired_version" =~ ^[0-9]+$ ]]; then
  echo "Invalid version format. Please enter a number (e.g., 17, 11)."
  exit 1
fi

# Update package list
sudo apt update

# Define base package name based on version
base_package="openjdk-$desired_version-jdk"

# Check if package exists
if ! dpkg -l $base_package &> /dev/null; then
  echo "OpenJDK version $desired_version not found in repositories."
  exit 1
fi

# Install OpenJDK
echo "Installing OpenJDK $desired_version..."
sudo apt install -y $base_package

# Set default Java version with update-alternatives
sudo update-alternatives --config java

# Identify the installed OpenJDK path from alternatives
default_java=$(update-alternatives --query java | grep -E "( ścieżka|link target): /" | awk '{print $NF}')

# Set JAVA_HOME environment variable
export JAVA_HOME=$default_java

# Print confirmation message
echo "OpenJDK $desired_version installed and set as default."
echo "JAVA_HOME is now: $JAVA_HOME"

# Test Java installation (optional)
# java -version
javac -version