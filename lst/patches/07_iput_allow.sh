#!/bin/sh

ipv6=False
#ipv6=True
debug=''
#debug='echo '
localNetwork=$(ip route show | cut -d ' ' -f 1)
inputPortsList=(
443 
80 
8080 
8081
53
853
22
993
)

ipt=/system/bin/iptables


if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

for chain in agwall-inp ; do
  for proto in tcp udp ; do
    for port in ${inputPortsList[@]} ; do 
      $debug $ipt -A $chain -p $proto --sport $port -j ACCEPT 

      if [ $ipv6 == True ]; then
        $debug $ip6t -A $chain -p $proto --sport $port -j ACCEPT
      fi
    done
  done
done


