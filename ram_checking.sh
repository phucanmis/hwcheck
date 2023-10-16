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

  # Print header for the table
  printf "%-10s %-10s %-10s\n" "Position" "Speed(MHz)" "Manufacturer"

  # Fetch and format RAM information
  count=1
  dmidecode -t memory | awk -F: '/Size: [0-9]/ {size=$2} /Speed: [0-9]/ {speed=$2; print size, speed}' | while read -r size speed; do
    printf "%-10d %-10s %-10s\n" $count "$speed" "$size"
    ((count++))
  done
}

# Call function to check RAM speed
check_ram_speed
