#!/bin/sh

ipv6=False
#ipv6=True
debug=''
#debug='echo '

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

$debug $ipt -t nat -D OUTPUT -j agwall-out
$debug $ipt -t nat -I OUTPUT 1 -j agwall-out


$debug $ipt -t nat -D INPUT -j agwall-inp
$debug $ipt -t nat -I INPUT 1 -j agwall-inp


if [ $ipv6 == True ]; then
$debug $ip6t -t nat -D OUTPUT -j agwall-out
$debug $ip6t -t nat -I OUTPUT 1 -j agwall-out

$debug $ip6t -t nat -D INPUT -j agwall-inp
$debug $ip6t -t nat -I INPUT 1 -j agwall-inp
fi

