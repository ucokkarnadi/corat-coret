#!/bin/bash

# Gunakan perintah berikut dibawah ini di terminal ubuntu 22.04 anda tanpa tanda kutip
# "curl -sSL https://raw.githubusercontent.com/ucokkarnadi/corat-coret/master/dnsdist-ubuntu.sh | bash" 

echo "deb [signed-by=/etc/apt/keyrings/dnsdist-18-pub.asc arch=amd64] http://repo.powerdns.com/ubuntu jammy-dnsdist-18 main" > /etc/apt/sources.list.d/pdns.list
echo "Package: dnsdist*
Pin: origin repo.powerdns.com
Pin-Priority: 600" > /etc/apt/preferences.d/dnsdist-18
install -d /etc/apt/keyrings; curl https://repo.powerdns.com/FD380FBB-pub.asc | sudo tee /etc/apt/keyrings/dnsdist-18-pub.asc

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
addAction(AndRule({SuffixMatchNodeRule(smnptr, true), QTypeRule(DNSQType.PTR)}), SpoofRawAction("\003JSN\010JaringanKU\000"))

smndom = newSuffixMatchNode()
smndom:add(newDNSName("iover4u.net"))
smndom:add(newDNSName("wifi.tjkom.com"))
smndom:add(newDNSName("wifi.ptnat.net"))
smndom:add(newDNSName("forum.fancykeyapp.com"))
smndom:add(newDNSName("maribacaberita.com"))
smndom:add(newDNSName("yukbacaberita.com"))
smndom:add(newDNSName("itotolink.net"))
smndom:add(newDNSName("www.tendawifi.com"))
smndom:add(newDNSName("totolink"))
smndom:add(newDNSName("gerbangakses.net.id"))
smndom:add(newDNSName("rndlabbankmandiri.co.id"))
smndom:add(newDNSName("aptilon.com"))
smndom:add(newDNSName("gemscool.com"))
smndom:add(newDNSName("iemnet.xyz"))
smndom:add(newDNSName("ap.login"))
smndom:add(newDNSName("mytele.com.ua"))
smndom:add(newDNSName("adsco.re"))
smndom:add(newDNSName("lan"))
smndom:add(newDNSName("local"))
smndom:add(newDNSName("home"))
smndom:add(newDNSName("ucweb.com"))
smndom:add(newDNSName("speedone.maduroo.com"))
smndom:add(newDNSName("speedtest-bali.smartconnect.id"))
smndom:add(newDNSName("speedtest.smartconnect.id"))
smndom:add(newDNSName("match.bnmla.com"))
smndom:add(newDNSName("thirdplat.189cube.com"))
smndom:add(newDNSName("ad.mail.ru"))
smndom:add(newDNSName("ads.adfox.ru"))
smndom:add(newDNSName("donu1.speedtest.rt.ru"))
smndom:add(newDNSName("mar.speedtest.rt.ru"))
smndom:add(newDNSName("net.ru"))
smndom:add(newDNSName("nt.ru"))
smndom:add(newDNSName("teleos.ru"))
smndom:add(newDNSName("speedtest.mmsn.ru"))
smndom:add(newDNSName("speedtest.tuapse.ru"))
smndom:add(newDNSName("tech.rtb.mts.ru"))
smndom:add(newDNSName("tel.ru"))
smndom:add(newDNSName("v1.fyjadco.ru"))
smndom:add(newDNSName("yandex.ru"))
smndom:add(newDNSName("01.tubaron.net.br"))
smndom:add(newDNSName("coroas.giga.com.br"))
smndom:add(newDNSName("dns2.litoralnetserrambi.com.br"))
smndom:add(newDNSName("dvl.mastercabo.com.br"))
smndom:add(newDNSName("jachin.htnet.com.br"))
smndom:add(newDNSName("lnptelecom.com.br"))
smndom:add(newDNSName("ns1.qweb.com.br"))
smndom:add(newDNSName("ns3.nethomeinternet.com.br"))
smndom:add(newDNSName("ookla.camoninternet.net.br"))
smndom:add(newDNSName("planety.com.br"))
smndom:add(newDNSName("prtg.rg3telecom.com.br"))
smndom:add(newDNSName("siarecert.fazenda.mg.gov.br"))
smndom:add(newDNSName("sp1.bandalargaconnect.com.br"))
smndom:add(newDNSName("sp2.broadcastinternet.com.br"))
smndom:add(newDNSName("speed.digitelnet.com.br"))
smndom:add(newDNSName("speed1.linkwebtelecom.com.br"))
smndom:add(newDNSName("speedtest.a2telecomjp.com.br"))
smndom:add(newDNSName("speedtest.forestnet.net.br"))
smndom:add(newDNSName("speedtest.giganetbandalarga.com.br"))
smndom:add(newDNSName("speedtest.infraconect.com.br"))
smndom:add(newDNSName("speedtest.mrtelecom2.com.br"))
smndom:add(newDNSName("speedtest.netsulfibra.com.br"))
smndom:add(newDNSName("speedtest.nossaredetelecom.com.br"))
smndom:add(newDNSName("speedtest.skorpionet.com.br"))
smndom:add(newDNSName("speedtest.soumaisweblink.com.br"))
smndom:add(newDNSName("speedtest.tvctupa.com.br"))
smndom:add(newDNSName("speedtest.unikanet.net.br"))
smndom:add(newDNSName("speedtest.vianovatelecom.com.br"))
smndom:add(newDNSName("speedtest.webbytelecom.com.br"))
smndom:add(newDNSName("speedtest1.wginfor.com.br"))
smndom:add(newDNSName("speedtest7.opcaonet.com.br"))
smndom:add(newDNSName("stn1.pronet.net.br"))
smndom:add(newDNSName("stst1.connecti.net.br"))
smndom:add(newDNSName("v.vitalnetprovedor.com.br"))
smndom:add(newDNSName("vel1.neolink.com.br"))
smndom:add(newDNSName("www.vibenettelecom.com.br"))

addAction( SuffixMatchNodeRule(smndom, true), SpoofAction({"127.0.0.1", "::1"}))


' > /etc/dnsdist/dnsdist.conf

service dnsdist start
netstat -tupln
