#!/bin/bash

#This preps the system and makes sure it is running up to date packages.
sudo apt update
sudo apt upgrade

#This installs version 8 of the Java runtime environment becuase the UniFi Network controller needs it to run.
sudo apt install openjdk-8-jre-headless

#This instals rng-tools to improve startup speed with some random number configurations
sudo apt install rng-tool
cd /etc/default
sudo sed 's_#HRNGDEVICE=/dev/hwrng_HRNGDEVICE=/dev/hwrng_' rng-tools | sudo tee rng-tools
sudo systemctl restart rng-tools

#This downloads, adds to the repository, updates the repository, and installs the UniFi Controller software.
echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg
sudo apt update
sudo apt install unifi
#Directs the user to the setup page
echo 
echo Congratulations! You have completed the UniFi Controller install. To complete configurations, open a browser and visit https://[IPADDRESS]:8443
echo Your IPADDRESS is listed below
hostname -I
