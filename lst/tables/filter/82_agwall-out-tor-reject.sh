#!/bin/sh

ipv6=False
#ipv6=True
debug=''
#debug='echo '

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

#$debug $ipt -A agwall-tor-reject -j NFLOG --nflog-prefix  "{AGLTOR}" --nflog-group 50
$debug $ipt -A agwall-out-tor-reject -j LOG --log-prefix  "{AGLoutTor}"
$debug $ipt -A agwall-out-tor-reject -j REJECT --reject-with icmp-port-unreachable

if [ $ipv6 == True ]; then
$debug $ip6t -A agwall-out-tor-reject -j LOG --log-prefix  "{AGLoutTor}"
$debug $ip6t -A agwall-out-tor-reject -j REJECT --reject-with icmp-port-unreachable
fi

