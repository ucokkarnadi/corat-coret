#!/bin/bash

# Gunakan perintah "curl -sSL https://raw.githubusercontent.com/ucokkarnadi/corat-coret/master/dnsdist-ubuntu.sh | bash" 

echo "deb [signed-by=/etc/apt/keyrings/dnsdist-18-pub.asc arch=amd64] http://repo.powerdns.com/ubuntu jammy-dnsdist-18 main" > /etc/apt/sources.list.d/pdns.list
apt update

service bind9 stop
systemctl disable bind9
service systemd-resolved stop
systemctl disable systemd-resolved
apt remove -y --purge bind9 dnsdist
apt autoremove -y
rm -rf /var/cache/bind /etc/bind

apt install -y dnsdist net-tools
service dnsdist stop

echo '-- Config untuk DNSDIST Mitra JSN 
addACL("0.0.0.0/0")
addACL("::/0")

setServerPolicy(whashed)

controlSocket("127.0.0.1:5199")
setKey("J7wwKbHRfYpHMBN9i5UqS1ox0UBZ2rldOj/MttwbDdA=")

pc = newPacketCache( 1000000, { maxTTL=86400, minTTL=0, temporaryFailureTTL=10, staleTTL=60, dontAge=false, maxNegativeTTL=10 })
getPool(""):setCache(pc)

webserver("0.0.0.0:8083")
setWebserverConfig({acl="0.0.0.0/0", password="ApaSaja", apiKey="ApaSaja" })

addLocal("0.0.0.0", {reusePort=true})
addLocal("0.0.0.0", {reusePort=true})
addLocal("0.0.0.0", {reusePort=true})
addLocal("0.0.0.0", {reusePort=true})
addLocal("[::0]", {reusePort=true})
addLocal("[::0]", {reusePort=true})
addLocal("[::0]", {reusePort=true})
addLocal("[::0]", {reusePort=true})

newServer({address="103.80.80.243", name="JSN", qps=1000, useClientSubnet=true})
newServer({address="103.80.80.244", name="JSN", qps=1000, useClientSubnet=true})
newServer({address="103.80.80.248", name="JSN", qps=1000, useClientSubnet=true})
newServer({address="103.80.80.249", name="JSN", qps=1000, useClientSubnet=true})
newServer({address="103.80.80.243", name="JSN", qps=1000, useClientSubnet=true})
newServer({address="103.80.80.244", name="JSN", qps=1000, useClientSubnet=true})
newServer({address="103.80.80.248", name="JSN", qps=1000, useClientSubnet=true})
newServer({address="103.80.80.249", name="JSN", qps=1000, useClientSubnet=true})

setECSOverride(true)
setECSSourcePrefixV4(32)
setECSSourcePrefixV6(128)

smnptr = newSuffixMatchNode()
smnptr:add(newDNSName("10.in-addr.arpa."))
smnptr:add(newDNSName("168.192.in-addr.arpa."))
smnptr:add(newDNSName("16.172.in-addr.arpa."))
smnptr:add(newDNSName("17.172.in-addr.arpa."))
smnptr:add(newDNSName("18.172.in-addr.arpa."))
smnptr:add(newDNSName("19.172.in-addr.arpa."))
smnptr:add(newDNSName("20.172.in-addr.arpa."))
smnptr:add(newDNSName("21.172.in-addr.arpa."))
smnptr:add(newDNSName("22.172.in-addr.arpa."))
smnptr:add(newDNSName("23.172.in-addr.arpa."))
smnptr:add(newDNSName("24.172.in-addr.arpa."))
smnptr:add(newDNSName("25.172.in-addr.arpa."))
smnptr:add(newDNSName("26.172.in-addr.arpa."))
smnptr:add(newDNSName("27.172.in-addr.arpa."))
smnptr:add(newDNSName("28.172.in-addr.arpa."))
smnptr:add(newDNSName("29.172.in-addr.arpa."))
smnptr:add(newDNSName("30.172.in-addr.arpa."))
smnptr:add(newDNSName("31.172.in-addr.arpa."))
addAction(AndRule({SuffixMatchNodeRule(smnptr), QTypeRule(DNSQType.PTR)}), SpoofRawAction("\003JSN\010JaringanKU\000"))
' > /etc/dnsdist/dnsdist.conf

service dnsdist start
netstat -tupln
