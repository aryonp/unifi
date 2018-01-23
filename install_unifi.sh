#!/bin/bash
clear
echo "** Starting installation"
echo "** Add & update needed repositories"
{
	echo 'deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
	sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ubnt.com/unifi/unifi-repo.gpg 
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50 
	sudo apt-add-repository -y ppa:webupd8team/java
	sudo apt update 
} &> /dev/null

echo "** Install main software"
{
	sudo apt install -y unifi
	sudo wget -O /tmp/unifi-video.deb https://dl.ubnt.com/firmwares/ufv/v3.9.0/unifi-video.Ubuntu16.04_amd64.v3.9.0.debU
	sudo dpkg -i /tmp/unifi-video.deb
	sudo apt install -f
	sudo wget -O /tmp/unifi-voip.deb https://dl.ubnt.com/unifi-voip/1.0.5-kxe7d9/unifi_voip_sysvinit_all.deb
	sudo dpkg -i /tmp/unifi-voip.deb
	sudo apt install -f
} &> /dev/null

echo "** Install supporting software"
sudo apt install -y software-properties-common oracle-java8-installer oracle-java8-set-default oracle-java8-unlimited-jce-policy &> /dev/null

echo "** Restart all services"
{
	sudo service unifi restart
	sudo service unifi-video restart
	sudo service unifi-voip
} &> /dev/null

echo "** Installation done"
