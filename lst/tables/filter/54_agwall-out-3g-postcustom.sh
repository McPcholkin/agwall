#!/bin/sh

ipv6=False
#ipv6=True
debug=''
#debug='echo '

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

$debug $ipt -A agwall-out-3g-postcustom -j agwall-out-3g-fork

if [ $ipv6 == True ]; then
$debug $ip6t -A agwall-out-3g-postcustom -j agwall-out-3g-fork
fi

