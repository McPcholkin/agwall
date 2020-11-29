#!/bin/sh

ipv6=False
#ipv6=True
debug=''
#debug='echo '

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

$debug $ipt -t nat -A agwall-out-tor-filter -d 127.0.0.1/32 -p tcp -m tcp --dport 9050 -j RETURN
$debug $ipt -t nat -A agwall-out-tor-filter -d 127.0.0.1/32 -p tcp -m tcp --dport 8118 -j RETURN                                                       
$debug $ipt -t nat -A agwall-out-tor-filter -p udp -m udp --dport 53 -j REDIRECT --to-ports 5400
$debug $ipt -t nat -A agwall-out-tor-filter -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j REDIRECT --to-ports 9040
$debug $ipt -t nat -A agwall-out-tor-filter -j MARK --set-xmark 0x500/0xffffffff

if [ $ipv6 == True ]; then
$debug $ip6t -t nat -A agwall-out -j agwall-out-tor-reject
fi

