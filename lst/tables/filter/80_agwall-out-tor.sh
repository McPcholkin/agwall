#!/bin/sh

ipv6=False
#ipv6=True
debug=''
#debug='echo '

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

$debug $ipt -A agwall-out-tor -m mark --mark 0x500 -j agwall-out-tor-reject

if [ $ipv6 == True ]; then
$debug $ip6t -A agwall-out-tor -m mark --mark 0x500 -j agwall-out-tor-reject
fi

