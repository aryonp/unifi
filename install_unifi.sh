#!/usr/bin/env bash
clear

v_video=v3.10.2
v_voip=1.0.5-kxe7d9

echo "** Starting installation"
echo "** Add & update needed repositories"
echo 'deb http://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo apt update

echo "** Install supporting software"
sudo apt install -y apt-transport-https logrotate software-properties-common openjdk-8-jdk

echo "** Install main software"
sudo apt install -y unifi 
sudo wget -O /tmp/unifi-video.deb "https://dl.ubnt.com/firmwares/ufv/${v_video}/unifi-video.Ubuntu18.04_amd64.${v_video}.deb"
sudo wget -O /tmp/unifi-voip.deb "https://dl.ubnt.com/unifi-voip/${v_voip}/unifi_voip_sysvinit_all.deb"
sudo dpkg -i /tmp/unifi-video.deb
sudo dpkg -i /tmp/unifi_voip.deb
sudo apt install -f

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