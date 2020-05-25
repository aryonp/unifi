#!/bin/bash
clear
v_unifi=5.12.72

echo "** Starting installation"
echo ""
echo "** Add & update needed repositories"
#repo mongodb
#on fix
	
echo "** Install supporting software"
sudo apt install -y apt-transport-https logrotate software-properties-common ca-certificates-java binutils jsvc libcommons-daemon-java openjdk-8-jre-headless debsums gdebi

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
