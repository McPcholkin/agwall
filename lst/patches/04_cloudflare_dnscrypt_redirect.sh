#!/bin/sh

ipv6=False
#ipv6=True
debug=''
#debug='echo '
dns4ip1='1.1.1.1'
dns4ip2='1.0.0.1'
dns4port='853'
dns6ip=''
dns6port=''
localNetwork=$(ip route show | cut -d ' ' -f 1)
dnsIPs=(
"1.1.1.1"
"1.0.0.1"
)
dnsPorts=(
"853"
"53"
)

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

for table in filter nat ; do
  for chain in agwall-out ; do
    for protocol in tcp udp ; do
      for dnsIp in ${dnsIPs[@]} ; do
        for dnsPort in ${dnsPorts[@]} ; do
          $debug $ipt -t $table -I $chain 1 -p $protocol -s 0/0 -d $dnsIp --dport $dnsPort -j ACCEPT
        

#    $debug $ipt -t nat -A $chain -p $protocol --dport 53 -j DNAT --to-destination $dns4ip1:$dns4port

  if [ $ipv6 == True ]; then
    for protocol in tcp ; do
      $debug $ip6t -t $table -I $chain 1 -p $protocol -s 0/0 -d $dns6ip1 --dport $dns6port -j ACCEPT
    done
  fi
        done
      done
    done
  done
done

# =============================================================

for chain in agwall-out ; do
  for protocol in tcp udp; do
    for dnsIp in ${dnsIPs[@]} ; do
      for dnsPort in ${dnsPorts[@]} ; do
    $debug $ipt -t $table -I $chain 1 -p $protocol -s 0/0 -d $localNetwork --sport $dnsPort -j ACCEPT
  

  if [ $ipv6 == True ]; then
    for protocol in tcp ; do
      $debug $ip6t -t $table -I $chain 1 -p $protocol -s $dns4ip1 -d $localNetwork --sport $dns6port -j ACCEPT
      $debug $ip6t -t $table -I $chain 1 -p $protocol -s $dns4ip1 -d $localNetwork --sport $dns6port -j ACCEPT
    done
  fi
      done
    done
  done
done

#      $debug $ip6t -t nat -I $chain 3 -p $protocol --dport $ntp6port -j DNAT --to-destination $ntp6ip:$ntp6port

