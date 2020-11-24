#!/usr/bin/env bash
clear
v_video=v3.10.13
v_voip=1.0.6-vfy6nm

echo "** Starting installation"

echo "** Prepare Software Repositories"
echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
sudo wget -qO - https://www.mongodb.org/static/pgp/server-3.4.asc | sudo apt-key add -
echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg 

echo "** Update all"
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade

echo "** Install supporting software & unifi controller"
sudo apt install -y ca-certificates apt-transport-https logrotate software-properties-common ca-certificates-java binutils jsvc libcommons-daemon-java openjdk-8-jre-headless mongodb-org wget curl ufw speedtest-cli haveged unifi

echo "** Install unifi video and voip"
sudo wget -O /tmp/unifi-video.deb "https://dl.ubnt.com/firmwares/ufv/${v_video}/unifi-video.Ubuntu18.04_amd64.${v_video}.deb"
sudo wget -O /tmp/unifi-voip.deb "https://dl.ubnt.com/unifi-voip/${v_voip}/unifi_voip_sysvinit_all.deb"
sudo dpkg -i /tmp/unifi-video.deb
sudo apt-get install --fix-broken
sudo dpkg -i /tmp/unifi_voip.deb
sudo apt-get install --fix-broken

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
