#!/bin/sh

ipv6=False
#ipv6=True
debug=''
#debug='echo '

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

$debug $ipt -A agwall-inp-wifi-lan -p udp -m udp --sport 53 -j ACCEPT
$debug $ipt -A agwall-inp-wifi-lan -p udp -m udp --sport 53 -m owner --uid-owner 0 -j ACCEPT
$debug $ipt -A agwall-inp-wifi-lan -j agwall-inp-reject 

if [ $ipv6 == True ]; then
$debug $ip6t -A agwall-inp-wifi-lan -p udp -m udp --sport 53 -j ACCEPT
$debug $ip6t -A agwall-inp-wifi-lan -p udp -m udp --sport 53 -m owner --uid-owner 0 -j ACCEPT
$debug $ip6t -A agwall-inp-wifi-lan -j agwall-inp-reject
fi

