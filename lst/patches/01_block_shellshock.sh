#!/bin/sh

# Block Shellshock
ipv6=False
#ipv6=True
#debug=''
debug='echo '
# NOT WORKING
# Invalid hex char ' '

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

for chain in agwall-wifi agwall-3g ; do
  $debug $ipt -I $chain 1 -m string --algo bm --hex-string '|28 29 0 7B|' -j agwall-reject

  if [ $ipv6 == True ]; then
    $debug $ip6t -I $chain 1 -m string --algo bm --hex-string '|28 29 0 7B|' -j agwall-reject
  fi
done

