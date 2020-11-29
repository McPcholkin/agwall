#!/bin/sh

ipv6=False
#ipv6=True
debug=''
#debug='echo '

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

$debug $ipt -t nat -A agwall-inp -j agwall-inp-tor-check

if [ $ipv6 == True ]; then
$debug $ip6t -t nat -A agwall-inp -j agwall-inp-tor-check
fi

