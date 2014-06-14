#!/bin/bash
sudo cp -f /tmp/edithosts/README /opt/edithosts/README
sudo cp -f /tmp/edithosts/autoupdate.sh /opt/edithosts/autoupdate.sh
sudo cp -f /tmp/edithosts/update.sh /opt/edithosts/update.sh
sudo cp -f /tmp/edithosts/install.sh /opt/edithosts/install.sh
sudo cp -f /tmp/edithosts/version /opt/edithosts/version
sudo cp -f /tmp/edithosts/edithosts.sh /opt/edithosts/edithosts.sh && sudo ln -s /opt/edithosts/edithosts.sh /usr/sbin/edithosts
sudo cp -f /tmp/edithosts/gethosts.sh /opt/edithosts/gethosts.sh && sudo ln -s /opt/edithosts/gethosts.sh /usr/sbin/gethosts
sudo cp -f /tmp/edithosts/cron.weekly-edithosts /opt/edithosts/
sudo cp -f /tmp/edithosts/uninstall.sh /opt/edithosts/uninstall.sh
sudo cp -f /tmp/edithosts/licence /opt/edithosts/licence

sudo chmod 755 /opt/edithosts -R

#periodic updates
sudo cp -f /opt/edithosts/autoupdate.sh /etc/cron.monthly/updateprogramuedithosts
sudo cp -f /opt/edithosts/cron.weekly-edithosts /etc/cron.weekly/edithosts

exit 0
