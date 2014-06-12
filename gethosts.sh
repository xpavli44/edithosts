#!/bin/bash
echo "edithosts:Checking Internet connectivity..."
	if [ "`ping -c 1 winhelp2002.mvps.org`" ]
then

  echo "edithosts:Internet connectivity OK..."

temphosts1=$(mktemp)
temphosts2=$(mktemp)

wget -nv -O - "http://winhelp2002.mvps.org/hosts.txt" >> "$temphosts1"
wget -nv -O - "http://hosts-file.net/ad_servers.asp" >> "$temphosts1"
wget -nv -O - "http://someonewhocares.org/hosts/hosts" >> "$temphosts1"
wget -nv -O - "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext" >> "$temphosts1"
sed -e 's/\r//' -e '/^127\.0\.0\.1/!d' -e '/localhost/d' -e 's/127\.0\.0\.1/0.0.0.0/' -e 's/ \+/\t/' -e 's/#.*$//' -e 's/[ \t]*$//' < "$temphosts1" | sort -u > "$temphosts2"

echo -e "\n# Edithost updated this file at $(date)" | cat /etc/hosts.d/hosts.conf - "$temphosts2" > /etc/hosts.d/hosts-block
echo -e "\n# Blocked $(cat /etc/hosts.d/hosts-block | grep 0.0.0.0 | wc -w) domains" >> /etc/hosts.d/hosts-block
rm "$temphosts1" "$temphosts2"
cp /etc/hosts.d/hosts-block /etc/hosts
echo "edithosts:Everything is OK"

else
  echo "edithosts:Internet connectivity is not OK, exit."
fi

exit 0
