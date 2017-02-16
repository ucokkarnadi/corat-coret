#!/bin/bash

###### Untuk membuat file zone yg berisi SOA
#echo "\$TTL 3600
#@   IN   SOA   trustpositif.kominfo.go.id. aduankonten.mail.kominfo.go.id. ( `date +"%Y%m%d00"` 10800 10800 10800 10800 )
#@   IN   NS   localhost.
#
#\$INCLUDE \"/etc/bind/trust.zone\"" > /etc/bind/trust.block

SOAF="/etc/bind/trust.block"
ZONEF="/etc/bind/trust.zone"
DATE=$(date +%Y%m%d)
curr=$(sed -n '/^@/,/^[^;]*)/H;${;x;s/.*@[^(]*([^0-9]*//;s/[^0-9].*//;p;}' $SOAF)
prefix=${curr::-2}

####  Check situs trust positif hidup nggak
if curl -s --head  --request GET http://trustpositif.kominfo.go.id/ | grep "200 OK" > /dev/null; 
then
curl -q -s "http://trustpositif.kominfo.go.id/files/downloads/index.php?dir=database%2Fblacklist%2Fporn%2F&download=domains" | tr '[:upper:]' '[:lower:]' | sed '/\(\/\|:\|=\|\.\.\|\.$\|[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}$\|^$\)/d' | perl -nle 'print if m{^[[:ascii:]]+$}' > /tmp/domain.txt; 
curl -q -s "http://trustpositif.kominfo.go.id/files/downloads/index.php?dir=database%2Fblacklist%2Fkajian%2F&download=domains" | tr '[:upper:]' '[:lower:]' | sed '/\(\/\|:\|=\|\.\.\|\.$\|[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}$\|^$\)/d' | perl -nle 'print if m{^[[:ascii:]]+$}' >> /tmp/domain.txt; 
curl -q -s "http://trustpositif.kominfo.go.id/files/downloads/index.php?dir=database%2Fblacklist%2Fpengaduan%2F&download=domains" | tr '[:upper:]' '[:lower:]' | sed '/\(\/\|:\|=\|\.\.\|\.$\|[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}$\|^$\)/d' | perl -nle 'print if m{^[[:ascii:]]+$}' >> /tmp/domain.txt; 
dos2unix /tmp/domain.txt;

###  Check jumlah domain harus lebih besar dari 600 ribu
if [ $(cat /tmp/domain.txt | wc -l) > 600000 ]; then # 
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
for i in $(cat /tmp/domain.txt); 
do
echo -e "$i\tIN\tA\t103.80.80.246" >> $ZONEF;
echo -e "*.$i\tIN\tA\t103.80.80.246" >> $ZONEF;
done
rndc reload
rndc zonestatus trust.block
fi
fi
