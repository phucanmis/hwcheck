#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Function to check RAM speed using dmidecode
check_ram_speed() {
  echo "Checking RAM speed..."
  
  # Check if dmidecode is installed
  if ! command -v dmidecode > /dev/null 2>&1; then
    echo "dmidecode is not installed. Installing now..."
    apt update
    apt install -y dmidecode
  fi

  # Fetch RAM speed
  dmidecode -t memory | grep -i 'Speed:' | awk '{print $2, $3}'
}

# Call function to check RAM speed
check_ram_speed
