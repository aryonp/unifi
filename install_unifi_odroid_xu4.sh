#!/bin/bash
clear
v_unifi=5.12.72

echo "** Starting installation"
echo ""
echo "** Download MongoDB 3.2 armhf -- Thx Dominic Chen!"
wget https://github.com/ddcc/mongodb/releases/download/v3.2.22-2/mongodb-clients_3.2.22-2_armhf.deb
wget https://github.com/ddcc/mongodb/releases/download/v3.2.22-2/mongodb-server-core_3.2.22-2_armhf.deb
wget https://github.com/ddcc/mongodb/releases/download/v3.2.22-2/mongodb-server_3.2.22-2_all.deb
wget https://github.com/ddcc/mongodb/releases/download/v3.2.22-2/mongodb_3.2.22-2_armhf.deb
	
echo "** Install supporting software"
sudo apt install -y apt-transport-https logrotate software-properties-common ca-certificates-java binutils jsvc libcommons-daemon-java openjdk-8-jre-headless debsums gdebi
sudo gdebi mongodb-clients_3.2.22-2_armhf.deb
sudo gdebi mongodb-server-core_3.2.22-2_armhf.deb
sudo gdebi mongodb-server_3.2.22-2_all.deb
sudo gdebi mongodb_3.2.22-2_armhf.deb

echo "** Install main software"
wget https://dl.ubnt.com/unifi/${v_unifi}/unifi_sysvinit_all.deb
sudo gdebi unifi_sysvinit_all.deb

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
