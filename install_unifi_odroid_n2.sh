#!/bin/bash
clear
v_unifi=5.12.72
echo "** Starting installation"
echo "" 
echo "** Update everything first"
sudo apt update && sudo apt upgrade -y
echo "" 
echo "** Add needed repositories"
wget -qO - https://www.mongodb.org/static/pgp/server-3.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
echo "" 
echo "** Install supporting software"
sudo apt update && sudo apt install -y jsvc logrotate openjdk-8-jre-headless ufw libcap2 ca-certificates apt-transport-https gdebi debsums mongodb-org
echo "" 
echo "** Install main software"
wget https://dl.ubnt.com/unifi/${v_unifi}/unifi_sysvinit_all.deb
sudo gdebi unifi_sysvinit_all.deb
echo "" 
echo "** Restart services"
sudo systemctl enable unifi
sudo systemctl start unifi
echo "" 
echo "** Hold Update for JVSC, Unifi, MongoDB"
sudo apt-mark hold jsvc
sudo apt-mark hold unifi
sudo apt-mark hold mongodb-org
echo "" 
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
echo "" 
echo "** Installation done"
