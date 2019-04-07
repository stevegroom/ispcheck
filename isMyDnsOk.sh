#!/bin/bash

# Mac OS version 
# Checks the dns entry for the cable modem against the current IP address
# and sends an pop-up notification.
# Steve Groom
# 06.04.2019

dnsRec='groom.ch'
dnsAddr=`curl -s https://dns.google.com/resolve?name=$dnsRec | tee | jq -r .Answer[0].data`
ipAddr=`curl -s https://api.ipify.org?format=json | tee | jq -r .ip`

if 
[ $ipAddr == $dnsAddr ] 
then 

  message="DNS record for $dnsRec is correct:\n A @ $dnsAddr"
else
  message="DNS record for $dnsRec needs updating to:\n A @ $ipAddr"
fi

osascript -e "display notification \"$message\" with title \"DNS Checker\" "