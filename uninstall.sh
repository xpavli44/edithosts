#!/bin/bash
sudo rm /usr/sbin/edithosts
sudo rm /usr/sbin/gethosts
sudo rm /opt/edithosts/ -rf
sudo mv /etc/hosts.d/hosts.bak /etc/hosts
sudo rm /etc/hosts.d/ -rf
sudo rm /etc/cron.monthly/updateprogramuedithosts
sudo rm /etc/cron.weekly/edithosts
sudo rm /usr/share/man/cs/man1/edithosts.1.gz
echo "edithost: Uninstall OK"
exit 0
