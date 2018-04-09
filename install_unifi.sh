#!/usr/bin/env bash
clear

url = "https://raw.githubusercontent.com/aryonp/unifi/master"
ufv_latest = "${url}/ufv-latest"

echo "** Starting installation"
echo "** Add & update needed repositories"
{
	echo "deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti" | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
	echo "deb http://dl.ubnt.com/unifi-voip/stage/debian beta ubiquiti" | sudo tee /etc/apt/sources.list.d/110-ubnt-unifi-voip.list
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 52F815F3
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50 
	sudo apt-add-repository -y ppa:webupd8team/java
	sudo apt update 
} &> /dev/null

echo "** Install main software"
{
	sudo apt install -y unifi unifi-voip
	sudo wget -O /tmp/unifi-video.deb "https://dl.ubnt.com/firmwares/ufv/${ufv_latest}/unifi-video.Ubuntu16.04_amd64.${ufv_latest}.deb"
	sudo dpkg -i /tmp/unifi-video.deb
	sudo apt install -f
} &> /dev/null

echo "** Install supporting software"
sudo apt install -y logrotate software-properties-common oracle-java8-installer oracle-java8-set-default oracle-java8-unlimited-jce-policy

echo "** Restart all services"
{
	sudo service unifi restart
	sudo service unifi-video restart
	sudo service unifi-voip restart
	sudo systemctl disable mongodb
	sudo systemctl stop mongodb
} &> /dev/null

echo "** Installation done"
