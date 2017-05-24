#!/bin/bash

for i in `seq 1 11`;
do
ping -W 1 -c 1 103.80.80.243; A=$?;
ping -W 1 -c 1 103.80.80.244; B=$?;
if [ "$A" -ne 0 ] && [ "$B" -ne 0 ];
then
diff /etc/bind/named.conf.options.open /etc/bind/named.conf.options; C=$?;
if [ "$C" -ne 0 ];
then
cat /etc/bind/named.conf.options.open > /etc/bind/named.conf.options;
/usr/sbin/rndc reload; /usr/sbin/rndc flush;
fi;
else
diff /etc/bind/named.conf.options.sehat /etc/bind/named.conf.options; C=$?;
if [ "$C" -ne 0 ];
then
cat /etc/bind/named.conf.options.sehat > /etc/bind/named.conf.options;
/usr/sbin/rndc reload; /usr/sbin/rndc flush;
fi;
fi;
sleep 5
done
