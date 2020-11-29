#!/bin/sh

# Force a specific NTP in this case  DE ntp0.fau.de (131.188.3.220), Location: University Erlangen-Nuernberg

ipv6=False
#ipv6=True
debug=''
#debug='echo '
ntp4ip='193.106.144.7'
ntp4port='123'
ntp6ip=''
ntp6port=''

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi
for chain in agwall-out-wifi agwall-out-3g ; do
  for protocol in tcp udp ; do
    $debug $ipt -t nat -I $chain 3 -p $protocol --dport $ntp4port -j DNAT --to-destination $ntp4ip:$ntp4port
  done

  if [ $ipv6 == True ]; then
    for protocol in tcp udp ; do
      $debug $ip6t -t nat -I $chain 3 -p $protocol --dport $ntp6port -j DNAT --to-destination $ntp6ip:$ntp6port
    done
  fi
done

