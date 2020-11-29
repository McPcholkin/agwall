#!/bin/sh

# Allow local resources for wifi

ipv6=False
#ipv6=True
#debug=''
debug='echo '

network4List=(
"192.168.0.0/24"
"192.168.1.0/24"
"192.168.137.0/24" 
)
network6List=(
""
)


ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

for chain in agwall-out ; do
  for network in ${network4List[@]}; do
    $debug $ipt -A $chain --destination $network -p udp --dport 67 -j ACCEPT
#    $debug $ipt -A $chain  --destination $network -j ACCEPT
    done
  
  
  if [ $ipv6 == True ]; then
    for network in ${network6List[@]}; do
      $debug $ip6t -A $chain --destination $network -j ACCEPT
    done
  fi
done


for chain in agwall-out ; do
  for network in ${network4List[@]}; do
    $debug $ipt -A $chain --source $network -j ACCEPT
  done
  
  
  if [ $ipv6 == True ]; then
    for network in ${network6List[@]}; do
      $debug $ip6t -A $chain --source $network -j ACCEPT
    done
  fi
done


exit 0

