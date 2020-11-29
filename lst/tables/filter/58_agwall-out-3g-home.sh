#!/bin/sh

ipv6=False
#ipv6=True
debug=''
#debug='echo '

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

$debug $ipt -A agwall-out-3g-home -p udp -m udp --dport 53 -j ACCEPT
$debug $ipt -A agwall-out-3g-home -p udp -m udp --dport 53 -m owner --uid-owner 0 -j ACCEPT
$debug $ipt -A agwall-out-3g-home -j agwall-out-reject

if [ $ipv6 == True ]; then
$debug $ipt -A agwall-out-3g-home -p udp -m udp --dport 53 -j ACCEPT
$debug $ipt -A agwall-out-3g-home -p udp -m udp --dport 53 -m owner --uid-owner 0 -j ACCEPT
$debug $ip6t -A agwall-out-3g-home -j agwall-out-reject
fi

