#!/bin/bash

# creates an adhoc wireless network
# and allows other computers in the 
# same subnet to use host's eth0
# you have to run it as a super user

iwconfig wlan0 mode ad-hoc
iwconfig wlan0 essid fahimwifi
ifconfig wlan0 192.254.0.1 netmask 255.255.255.0 broadcast 192.254.0.255 up
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE


