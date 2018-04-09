#!/bin/bash
clear
echo "** Starting installation"
echo "** Add & update needed repositories"
{
	echo "deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti" | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50 
	sudo apt-add-repository -y ppa:webupd8team/java
	sudo apt update 
} &> /dev/null

echo "** Install main software"
sudo apt install -y unifi &> /dev/null

echo "** Install supporting software"
sudo apt install -y logrotate software-properties-common oracle-java8-installer oracle-java8-set-default oracle-java8-unlimited-jce-policy &> /dev/null

echo "** Restart services"
sudo systemctl enable unifi
sudo systemctl start unifi
sudo systemctl disable mongodb
sudo systemctl stop mongodb

echo "** Installation done"
