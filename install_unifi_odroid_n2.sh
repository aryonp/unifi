#!/bin/bash
clear
echo "** Starting installation"

echo "** Add needed repositories"
wget -qO - https://www.mongodb.org/static/pgp/server-3.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list

echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg 

echo "** Update everything first"
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade

echo "** Install supporting software & unifi controller"
sudo apt install -y jsvc logrotate openjdk-8-jre-headless ufw libcap2 ca-certificates apt-transport-https gdebi debsums mongodb-org wget curl ufw speedtest-cli unifi

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
