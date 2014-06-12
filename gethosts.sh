#!/bin/bash
echo "edithosts:Kontroluji internetové připojení..."
if [ "`ping -c 1 winhelp2002.mvps.org`" ]
then

  echo "edithosts:Připojení OK, je možno pokračovat..."
echo "edithosts:Vytvářím dočasné soubory"
temphosts1=$(mktemp)
temphosts2=$(mktemp)
echo "edithosts:Stahuji černou listinu"
wget -nv -O - "http://winhelp2002.mvps.org/hosts.txt" >> "$temphosts1"
wget -nv -O - "http://hosts-file.net/ad_servers.asp" >> "$temphosts1"
wget -nv -O - "http://someonewhocares.org/hosts/hosts" >> "$temphosts1"
wget -nv -O - "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext" >> "$temphosts1"
# echo -e "Upravuji černou listinu:\n# 1. Odstranění znaků Carriage Return...\n# 2. Mazání řádků, které nezačínají 127.0.0.1...\n# 3. Odstranění řádků obsahující slovo localhost...\n# 4. Nahrazení ip adresy 127.0.0.1 ip adresou 0.0.0.0 protože pak nemusíme čekat na selhání resolveru...\n# 5. Odstranění nadbytečných mezer a nahrazení tabelátorem...\n# 6. Odstranění komentářů...\n# 7. Vyčištění koncových mezer\n# 8. Třídění a odstranění duplicit..."
sed -e 's/\r//' -e '/^127\.0\.0\.1/!d' -e '/localhost/d' -e 's/127\.0\.0\.1/0.0.0.0/' -e 's/ \+/\t/' -e 's/#.*$//' -e 's/[ \t]*$//' < "$temphosts1" | sort -u > "$temphosts2"
echo "edithosts:Slučuji s původním hosts souborem..."
echo -e "\n# Vygenerováno dne $(date)" | cat /etc/hosts.d/hosts.conf - "$temphosts2" > /etc/hosts.d/hosts-block
echo -e "\n# Blokováno $(cat /etc/hosts.d/hosts-block | grep 0.0.0.0 | wc -w) adres" >> /etc/hosts.d/hosts-block
echo "edithosts:Čistím dočasné soubory..."
rm "$temphosts1" "$temphosts2"
echo "edithosts:Kopíruji zpět vylepšený soubor /etc/hosts"
cp /etc/hosts.d/hosts-block /etc/hosts
echo "edithosts:Hotovo"

else
  echo "edithosts:Nyní jste bez připojení, nelze pokračovat, ukončuji skript..."
fi

exit 0
