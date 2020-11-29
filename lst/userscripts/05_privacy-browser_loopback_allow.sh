#!/bin/sh

#ipv6=False
ipv6=True
#debug=''
debug='echo '
localIp=$(ip route show | cut -f 9 -d ' ')


ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

for chain in agwall-out agwall-inp; do
  $debug $ipt -A $chain -s $localIp/0 -d 127.0.0.1 -j ACCEPT 
                                                                  
  if [ $ipv6 == True ]; then
    $debug $ip6t -A $chain -s $localIp/0 -d 127.0.0.1 -j ACCEPT
  fi
done



