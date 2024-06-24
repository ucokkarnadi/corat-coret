echo "deb [signed-by=/etc/apt/keyrings/dnsdist-19-pub.asc] http://repo.powerdns.com/ubuntu noble-dnsdist-19 main" > /etc/apt/sources.list.d/pdns.list
echo "Package: dnsdist*
Pin: origin repo.powerdns.com
Pin-Priority: 600
" > /etc/apt/preferences.d/dnsdist-19
install -d /etc/apt/keyrings; curl https://repo.powerdns.com/FD380FBB-pub.asc | tee /etc/apt/keyrings/dnsdist-19-pub.asc
apt update
apt -y install dnsdist
