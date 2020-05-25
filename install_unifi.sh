#!/usr/bin/env bash
clear
v_video=v3.10.12
v_voip=1.0.6-vfy6nm

echo "** Starting installation"
echo "** Prepare Software Repositories"
echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
wget -qO - https://www.mongodb.org/static/pgp/server-3.4.asc | sudo apt-key add -
echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg 
sudo apt-get update

echo "** Install supporting software"
sudo apt update && sudo apt install -y ca-certificates apt-transport-https logrotate software-properties-common ca-certificates-java binutils jsvc libcommons-daemon-java openjdk-8-jre-headless mongodb-org

echo "** Install main software"
sudo apt install -y unifi 
sudo wget -O /tmp/unifi-video.deb "https://dl.ubnt.com/firmwares/ufv/${v_video}/unifi-video.Ubuntu18.04_amd64.${v_video}.deb"
sudo wget -O /tmp/unifi-voip.deb "https://dl.ubnt.com/unifi-voip/${v_voip}/unifi_voip_sysvinit_all.deb"
sudo gdebi /tmp/unifi-video.deb
sudo gdebi /tmp/unifi_voip.deb

echo "** Restart all services"
sudo systemctl enable unifi
sudo service unifi restart
sudo systemctl enable unifi-video
sudo service unifi-video restart
sudo systemctl enable unifi-voip
sudo service unifi-voip restart

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
