#!/bin/sh

ipv6=False
#ipv6=True
debug='su -c ' 
#debug='echo '
whereiam=$(dirname "$0")
listDir="$whereiam/lst"
tablesDir="$listDir/tables"

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

disableBaseRules () {
  tableList=$(ls $tablesDir)
  for table in $tableList; do
    for chain in INPUT OUTPUT FORWARD; do 

      $debug $ipt -t $table -P $chain ACCEPT
      if [ $ipv6 == True ]; then
        $debug $ip6t -t $table -P $chain ACCEPT
      fi
      
      for rule in agwall-out agwall-inp; do
        $debug $ipt -t $table -D $chain -j $rule
        if [ $ipv6 == True ]; then
          $debug $ip6t -t $table -D $chain -j $rule
        fi
      done
    done
  done
}


disableBaseRules
exit 0

