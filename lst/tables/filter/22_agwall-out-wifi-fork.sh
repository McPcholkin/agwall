#!/bin/sh

ipv6=False
#ipv6=True
debug=''
#debug='echo '
localNetwork=$(ip route show | cut -d ' ' -f 1)


ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

$debug $ipt -A agwall-out-wifi-fork -d $localNetwork -j agwall-out-wifi-lan
$debug $ipt -A agwall-out-wifi-fork ! -d $localNetwork -j agwall-out-wifi-wan

if [ $ipv6 == True ]; then
$debug $ip6t -A agwall-out-wifi-fork -d $localNetwork -j agwall-out-wifi-lan
$debug $ip6t -A agwall-out-wifi-fork ! -d $localNetwork -j agwall-out-wifi-wan
fi

