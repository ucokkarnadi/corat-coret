#!/bin/bash
#
apt install software-properties-common -y
add-apt-repository ppa:ondrej/php -y

apt-get update && apt-get upgrade -y
# apt-get install lsb-release nscd curl php5 php5-mysql php5-cli php5-curl unzip -y && apt-get install php5-mcrypt &&  php5enmod mcrypt
apt-get install lsb-release nscd curl php5.6 php5.6-mysql php5.6-cli php5.6-curl unzip -y && apt-get install php5.6-mcrypt -y &&  phpenmod mcrypt
service apache2 restart
wget http://downloads.sourceforge.net/project/iptv-md/xtream/www_dir.tar.gz -O /tmp/www_dir.tar.gz
#
if [ -d /var/www/html ];
then
    echo "/var/www/html/ exists."
	tar -zxvf /tmp/www_dir.tar.gz -C /var/www/html/
else
    echo " "
	if [ -d /root/www/ ];
	then
    echo "/var/www/ exist"
    	tar -zxvf /tmp/www_dir.tar.gz -C /var/www/
  else
    echo "No Webserver installed?"
  fi
fi
#
echo 1 > /proc/sys/net/ipv4/ip_forward
#
/usr/sbin/iptables -t nat -I OUTPUT --dest 149.202.206.51/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 123.103.255.80/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 62.210.244.112/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 185.73.239.0/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 149.202.206.51/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 123.103.255.80/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 62.210.244.112/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 185.73.239.0/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 149.202.206.51/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 62.210.244.112/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest xtream-codes.com/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 119.249.54.71/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 38.30.65.218/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 221.194.47.224/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 218.65.30.38/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 116.31.116.34/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 91.197.232.109/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 121.18.238.104/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 221.194.44.195/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 123.103.255.80/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 185.73.239.0/28 -j DNAT --to-destination 127.0.0.1
/usr/sbin/iptables -t nat -I OUTPUT --dest 185.73.239.7/28 -j DNAT --to-destination 127.0.0.1
#
apt-get install iptables-persistent
#
wget http://127.0.0.1/downloads/iptv_panel_pro.zip -O /tmp/iptv_panel_pro.zip
wget http://127.0.0.1/downloads/install_iptv_pro.zip && unzip install_iptv_pro.zip
#
php install_iptv_pro.php
#
echo " "
echo "####################################################################################"
echo " "
echo "Licenza Installata. Fare yes a ogni domanda !!!"
echo " "

echo " "
echo "####################################################################################"
echo " "
echo "Pulizia dei file di installazione"
echo " "
rm /root/install_iptv_pro.php
rm /root/install_iptv_pro.zip
rm /root/xt_1.0.60-inst.sh
echo " "
echo "####################################################################################"
echo " "
echo "Xtream Codes 1.0.60 Italiano by Beppe"
echo " "
echo "Installazione completata!"
echo " "
echo "Riavviare il Server?"
echo " "
      read -p "Reboot now (y/n)?" CONT
      if [ "$CONT" == "y" ] || [ "$CONT" == "Y" ]; then
      reboot
      fi

