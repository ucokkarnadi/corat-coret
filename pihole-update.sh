#!/bin/bash

###### Untuk membuat file zone yg berisi SOA
if [ ! -f /etc/bind/hole.block ]; then
echo "\$TTL 3600
@   IN   SOA   zone.pi-hole.net. ads.pi-hole.net. ( `date +"%Y%m%d00"` 10800 10800 10800 10800 )
@   IN   NS   localhost.

\$INCLUDE \"/etc/bind/hole.zone\"" > /etc/bind/hole.block
fi

SOAF="/etc/bind/hole.block"
ZONEF="/etc/bind/hole.zone"
DATE=$(date +%Y%m%d)
curr=$(sed -n '/^@/,/^[^;]*)/H;${;x;s/.*@[^(]*([^0-9]*//;s/[^0-9].*//;p;}' $SOAF)
prefix=${curr::-2}

curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts | grep ^0.0.0.0 | awk '{print $2}' > /tmp/pi-hole.txt
curl http://mirror1.malwaredomains.com/files/justdomains >> /tmp/pi-hole.txt
curl http://sysctl.org/cameleon/hosts | grep ^127.0.0.1 | awk '{print $2}' >> /tmp/pi-hole.txt
curl "https://zeustracker.abuse.ch/blocklist.php?download=domainblocklist" >> /tmp/pi-hole.txt
curl https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt >> /tmp/pi-hole.txt
curl https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt >> /tmp/pi-hole.txt
curl https://hosts-file.net/ad_servers.txt | grep ^127.0.0.1 | awk '{print $2}' >> /tmp/pi-hole.txt
sed -i '/#/d' /tmp/pi-hole.txt
dos2unix /tmp/pi-hole.txt;

###  Check jumlah domain harus lebih besar dari 600 ribu
if [ $(cat /tmp/pi-hole.txt | wc -l) > 100000 ]; then # 
if [ "$DATE" -eq "$prefix" ]; then # same day
    num=${curr: -2} # last two digits from serial number
    num=$((10#$num + 1)) # force decimal representation, increment
    serial="${DATE}$(printf '%02d' $num )" # format for 2 digits
else
    serial="${DATE}00" # just update date
fi
sed -i "s/[0-9]\{10\}/${serial}/g" $SOAF

###### Untuk membuat file zone yg berisi ZONE tanpa SOA
echo > $ZONEF
for i in $(cat /tmp/pi-hole.txt); 
do
echo -e "$i\tIN\tA\t127.0.0.1" >> $ZONEF;
done
rndc reload
rndc zonestatus hole.block
fi
