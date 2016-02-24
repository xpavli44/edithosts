#!/bin/bash
echo "edithosts:Checking Internet connectivity..."
	if [ "`ping -c 1 raw.githubusercontent.com`" ]
then

  echo "edithosts:Internet connectivity OK..."

temphosts1a=$(mktemp)
temphosts1b=$(mktemp)
temphosts2a=$(mktemp)
temphosts2b=$(mktemp)
temphosts3=$(mktemp)
whitelist=$(mktemp)


wget -nv -O - "https://raw.githubusercontent.com/jiri001meitner/edithosts/master/edithosts-blocklist.txt" >> "$temphosts1a"
wget -nv -O - "http://winhelp2002.mvps.org/hosts.txt" >> "$temphosts1a"
wget -nv -O - "http://hosts-file.net/ad_servers.asp" >> "$temphosts1b"
wget -nv -O - "http://someonewhocares.org/hosts/hosts" >> "$temphosts1b"
wget -nv -O - "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext" >> "$temphosts1b"
wget -nv -O - "https://raw.githubusercontent.com/Free-Software-for-Android/AdAway/master/hosts/hosts.txt" >> "$temphosts1b"

sed -e 's/\r//' -e '/^0.0.0.0/!d' -e '/localhost/d' -e 's/127\.0\.0\.1/0.0.0.0/' -e 's/ \+/\t/' -e 's/#.*$//' -e 's/[ \t]*$//' < "$temphosts1a" | sort -u > "$temphosts2a"

sed -e 's/\r//' -e '/^127\.0\.0\.1/!d' -e '/localhost/d' -e 's/127\.0\.0\.1/0.0.0.0/' -e 's/ \+/\t/' -e 's/#.*$//' -e 's/[ \t]*$//' < "$temphosts1b" | sort -u > "$temphosts2b"

cat "$temphosts2a" "$temphosts2b" | sort -u > "$temphosts3"

wget -nv -O - https://raw.githubusercontent.com/jiri001meitner/edithosts/master/whitelist.txt >> "$whitelist"

for patern in $(cat "$whitelist"); do sed -i "/\b$patern\b/Id" "$temphosts3"; done

echo -e "\n# Edithost updated this file at $(date)" | sudo cat /etc/hosts.d/hosts.conf - "$temphosts3" > /tmp/edithosts-hosts-block
echo -e "\n# Blocked $(cat /tmp/edithosts-hosts-block | grep 0.0.0.0 | wc -w) domains" >> /tmp/edithosts-hosts-block
rm "$temphosts1a" "$temphosts1b" "$temphosts2a" "$temphosts2b" "$temphosts3" "$whitelist"
sudo cp /tmp/edithosts-hosts-block /etc/hosts

echo "edithosts:Filters are up to date now."

else
  echo "edithosts:Internet connectivity is not OK, exit."
fi

exit 0
