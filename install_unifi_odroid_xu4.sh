#!/bin/bash
clear

MONGO_V=3.2.22-2
UNIFI_V=7.0.25

echo "** Starting installation"
echo ""
echo "** Download MongoDB 3.2.22-2 armhf -- Thx Dominic Chen!"
wget -c https://github.com/ddcc/mongodb/releases/download/v3.2.22-2/mongodb-clients_3.2.22-2_armhf.deb
wget -c https://github.com/ddcc/mongodb/releases/download/v3.2.22-2/mongodb-server-core_3.2.22-2_armhf.deb
wget -c https://github.com/ddcc/mongodb/releases/download/v3.2.22-2/mongodb-server_3.2.22-2_all.deb
wget -c https://github.com/ddcc/mongodb/releases/download/v3.2.22-2/mongodb_3.2.22-2_armhf.deb
wget -c https://dl.ubnt.com/unifi/$UNIFI_V/unifi_sysvinit_all.deb 
	
echo "** Install supporting software"
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade 
sudo apt install -y apt-transport-https logrotate software-properties-common ca-certificates-java binutils jsvc libcommons-daemon-java openjdk-8-jdk debsums net-tools nmap tmux gdebi curl wget speedtest-cli ufw haveged
sudo dpkg -i  mongodb-clients_$MONGO_V_armhf.deb
sudo apt-get install --fix-broken
sudo dpkg -i mongodb-server-core_$MONGO_V_armhf.deb
sudo dpkg -i mongodb-server_$MONGO_V_all.deb
sudo dpkg -i mongodb_$MONGO_V_armhf.deb

echo "** Install main software"
sudo dpkg -i unifi_sysvinit_all.deb

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

echo "** Restart services"
sudo systemctl enable unifi
sudo systemctl start unifi

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
