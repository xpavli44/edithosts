#!/bin/bash
	if [ -e /usr/sbin/edithosts ] ; then

echo "edithosts:Program edithosts již máte nainstalován"

	else

echo "edithosts:Program edithosts bude nainstalován"

## Příprava a zálohování /etc/hosts
cd edithosts
sudo mkdir /etc/hosts.d/ -m 644
echo "edithosts:Zálohuji původní soubor /etc/hosts do /etc/hosts.d/hosts.bak"
sudo cp /etc/hosts /etc/hosts.d/hosts.bak
sudo sed -i '1i## Needitujte tento soubor přímo, ale prostřednictvím příkazu edithosts' /etc/hosts
sudo cp /etc/hosts /etc/hosts.d/hosts.conf

## instalace do /opt/edithosts
sudo mkdir /opt/edithosts/
sudo cp autoupdate.sh /opt/edithosts/autoupdate.sh
sudo cp update.sh /opt/edithosts/update.sh
sudo cp install.sh /opt/edithosts/install.sh
sudo cp version /opt/edithosts/version
sudo cp edithosts.sh /opt/edithosts/edithosts.sh && sudo ln -s /opt/edithosts/edithosts.sh /usr/sbin/edithosts
sudo cp gethosts.sh /opt/edithosts/gethosts.sh && sudo ln -s /opt/edithosts/gethosts.sh /usr/sbin/gethosts
sudo cp cron.weekly-edithosts /opt/edithosts/
sudo cp uninstall.sh /opt/edithosts/uninstall.sh
sudo chmod 755 /opt/edithosts -R

## periodická aktualizace programu a filtrů
sudo cp /opt/edithosts/autoupdate.sh /etc/cron.monthly/updateprogramuedithosts
sudo cp /opt/edithosts/cron.weekly-edithosts /etc/cron.weekly/edithosts

echo "edithosts:Instalace dokončena, soubor /etc/hosts editujte příkazem: edithosts"
echo -e "edithosts:Budete-li chtít vrátit provedené změny, odinstalujte příkazem:\n/opt/edithosts/uninstall.sh"

sudo /opt/edithosts/gethosts.sh

	fi
exit 0
