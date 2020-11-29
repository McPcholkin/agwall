#!/bin/sh

#ipv6=False
ipv6=True
debug=''
#debug='echo '

# set default policies to drop

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

for chain in INPUT OUTPUT FORWARD ; do
    $debug $ipt -P $chain DROP

  if [ $ipv6 == True ]; then
      $debug $ip6t -P $chain DROP
  fi
done


