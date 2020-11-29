#!/bin/sh

# IPv6 uses ICMP a lot more than IPv4, and not letting ICMP packets ingoing can severely cripple your traffic because you won't receive error messages related to that traffic.
# https://gist.github.com/CHEF-KOCH/e43246690da6906fa516

#debug=''
debug='echo '
# NOT WORKING


# There are some guys out there which want really block ping6 (for unknown reasons)
ipv6=False
#ipv6=True


ip6t=/system/bin/ip6tables
for chain in agwall-out-wifi agwall-out-3g ; do
  if [ $ipv6 == True ]; then
    $debug $ip6t -I $chain 2 -p icmpv6 -j ACCEPT
  else
    $debug $ip6t -I $chain 2 -p icmpv6 --icmpv6-type 128 -j agwall-out-reject
  fi
done
