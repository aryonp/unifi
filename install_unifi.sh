#!/usr/bin/env bash
clear

echo "** Starting installation"

echo "** Prepare Software Repositories"
echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
sudo wget -qO - https://www.mongodb.org/static/pgp/server-3.6.asc | sudo apt-key add -
echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg 

echo "** Update all"
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade

echo "** Install supporting software & unifi controller"
sudo apt install -y ca-certificates apt-transport-https logrotate software-properties-common ca-certificates-java binutils jsvc libcommons-daemon-java openjdk-8-jre-headless mongodb-org wget curl ufw speedtest-cli haveged unifi

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

echo "** Restart all services"
sudo systemctl enable unifi
sudo service unifi restart

echo "** Add Log Rotation"
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
