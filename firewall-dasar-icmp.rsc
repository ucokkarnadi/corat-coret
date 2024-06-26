/ip firewall filter
add action=jump chain=forward comment="Accept Important ICMP Types" jump-target=ICMP protocol=icmp
add action=jump chain=input jump-target=ICMP protocol=icmp
add action=accept chain=ICMP comment="Echo Reply" icmp-options=0:0 protocol=icmp
add action=accept chain=ICMP comment="Allow Echo Request" icmp-options=8:0 protocol=icmp
add action=accept chain=ICMP comment="Allow Time Exceeded" icmp-options=11:0 protocol=icmp
add action=accept chain=ICMP comment="Net Unreachable" icmp-options=3:0 protocol=icmp disabled=yes
add action=accept chain=ICMP comment="Port Unreachable" icmp-options=3:3 protocol=icmp disabled=yes
add action=accept chain=ICMP comment="Host Unreachable Fragmentation Required" icmp-options=3:4 protocol=icmp disabled=yes
add action=return chain=ICMP protocol=icmp
add action=drop chain=forward comment="Deny All Other Types" protocol=icmp
add action=drop chain=input comment="Deny All Other Types" protocol=icmp
