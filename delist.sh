#!/bin/bash

if [ ! -f /etc/bind/ho ]; then
echo "\$TTL 3600
@   IN   SOA   h.lan. ads.pi-hole.net. ( `date +"%Y%m%d00"` 10800 10800 10800 10800 )
@   IN   NS   localhost.

\$INCLUDE \"/etc/bind/ho.zone\"" > /etc/bind/ho
fi

SOAF="/etc/bind/ho"
ZONEF="/etc/bind/ho.zone"
DATE=$(date +%Y%m%d)
curr=$(sed -n '/^@/,/^[^;]*)/H;${;x;s/.*@[^(]*([^0-9]*//;s/[^0-9].*//;p;}' $SOAF)
prefix=${curr::-2}

if [ "$DATE" -eq "$prefix" ]; then # same day
    num=${curr: -2} # last two digits from serial number
    num=$((10#$num + 1)) # force decimal representation, increment
    serial="${DATE}$(printf '%02d' $num )" # format for 2 digits
else
    serial="${DATE}00" # just update date
fi
sed -i "s/[0-9]\{10\}/${serial}/g" $SOAF

sed -i "/$1/d" $ZONEF
