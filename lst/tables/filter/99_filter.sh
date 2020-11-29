#!/bin/sh

ipv6=False
#ipv6=True
debug=''
#debug='echo '

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

$debug $ipt -t filter -D OUTPUT -j agwall-out
$debug $ipt -t filter -I OUTPUT 1 -j agwall-out

$debug $ipt -t filter -D INPUT -j agwall-inp
$debug $ipt -t filter -I INPUT 1 -j agwall-inp


if [ $ipv6 == True ]; then
$debug $ip6t -t filter -D OUTPUT -j agwall-out
$debug $ip6t -t filter -I OUTPUT 1 -j agwall-out

$debug $ip6t -t filter -D INPUT -j agwall-inp
$debug $ip6t -t filter -I INPUT 1 -j agwall-inp

fi

