#!/bin/bash
apt -y -q install dos2unix
rm -rf /tmp/domain.txt
curl -q -s "http://trustpositif.kominfo.go.id/files/downloads/index.php?dir=database%2Fblacklist%2Fkajian%2F&download=domains" | sed 's/\*.//g' | tr '[:upper:]' '[:lower:]' | sed '/\(\/\|:\|=\|\.\.\|\.$\|[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}\($\|\s\)\|^$\|\*\)/d' | perl -nle 'print if m{^[[:ascii:]]+$}' > /tmp/domain.txt;
curl -q -s "http://trustpositif.kominfo.go.id/files/downloads/index.php?dir=database%2Fblacklist%2Fpengaduan%2F&download=domains" | sed 's/\*.//g' | tr '[:upper:]' '[:lower:]' | sed '/\(\/\|:\|=\|\.\.\|\.$\|[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}\($\|\s\)\|^$\|\*\)/d' | perl -nle 'print if m{^[[:ascii:]]+$}' >> /tmp/domain.txt;
dos2unix /tmp/domain.txt;
cat /tmp/domain.txt | sort | uniq > /tmp/domain.txt.tmp
rm -rf /tmp/domain.txt
mv /tmp/domain.txt.tmp /tmp/domain.txt
echo > /etc/dnsmasq.d/03-pihole-wildcard.conf;
IP=$(ifconfig | perl -nle 's/dr:(\S+)/print $1/e' | grep -v 127.0.0.1);
for i in $(cat /tmp/domain.txt);
do
echo -e "address=/$i/$IP" >> /etc/dnsmasq.d/03-pihole-wildcard.conf;
done
service dnsmasq restart
