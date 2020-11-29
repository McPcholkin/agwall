#!/bin/sh

ipv6=False
#ipv6=True
debug=''
#debug='echo '

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

$debug $ipt -A agwall-inp-tor -m mark --mark 0x500 -j agwall-inp-tor-reject

if [ $ipv6 == True ]; then
$debug $ip6t -A agwall-inp-tor -m mark --mark 0x500 -j agwall-inp-tor-reject
fi

