#!/bin/bash
sudo rm /usr/sbin/edithosts
sudo rm /usr/sbin/gethosts
sudo rm /opt/edithosts/ -rf
sudo mv /etc/hosts.d/hosts.bak /etc/hosts
sudo rm /etc/hosts.d/ -rf
sudo rm /etc/cron.monthly/updateprogramuedithosts
sudo rm /etc/cron.weekly/edithosts
echo "edithost: Odinstalace dokončena"
exit 0
