# PIHOLE-PATCH

untuk patch pihole agar ada option dns sehat

cd /var/www/html/admin/scripts/pi-hole/php;

wget https://raw.githubusercontent.com/ucokkarnadi/corat-coret/master/savesettings.php.patch;

patch -p0 < savesettings.php.patch;
