#!/bin/bash
clear

MONGO_v=3.6
UNIFI_V=7.0.25

echo "** Starting installation"

echo "** Add needed repositories"
wget -qO - https://www.mongodb.org/static/pgp/server-$MONGO_V.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/$MONGO_V multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-$MONGO_V.list

echo "** Update everything first"
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade

echo "** Install supporting software & unifi controller"
sudo apt install -y jsvc logrotate openjdk-8-jre-headless ufw libcap2 ca-certificates apt-transport-https gdebi debsums mongodb-org wget curl ufw speedtest-cli haveged

echo "** Install main software"
wget -c https://dl.ubnt.com/unifi/$UNIFI_V/unifi_sysvinit_all.deb 
sudo dpkg -i unifi_sysvinit_all.deb

echo "** Restart services"
sudo systemctl enable unifi
sudo systemctl start unifi

echo "** Open UFW Ports"
sudo ufw allow 3478/udp
sudo ufw allow 5514/tcp	
sudo ufw allow 8080/tcp
sudo ufw allow 8443/tcp
sudo ufw allow 8880/tcp
sudo ufw allow 8843/tcp
sudo ufw allow 6789/tcp
sudo ufw allow 27117/tcp
sudo ufw allow 5656:5699/udp
sudo ufw allow 10001/udp
sudo ufw allow 1900/udp
sudo ufw allow 443
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 8883/tcp

echo "** Install Log Rotation"
sudo bash -c 'cat >> /etc/logrotate.d/unifi << EOF
/var/log/unifi/*.log {
    rotate 5
    daily
    missingok
    notifempty
    compress
    delaycompress
    copytruncate
}
EOF'

echo "** Installation done"
