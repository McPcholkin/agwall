#!/bin/sh

ipv6=False
#ipv6=True
debug='su -c '
#debug='echo '
whereiam=$(dirname "$0")
listDir="$whereiam/lst"
tablesDir="$listDir/tables"
patchesDir="$listDir/patches"
userScriptDir="$listDir/userscripts"
appChainsDir="$listDir/apps"
shelterChainsDir="$listDir/shelter"


ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

createTables () {
  tableList=$(ls $tablesDir)
  for table in $tableList; do
    rulesDir="$tablesDir/$table"
    rulesList=$(ls $rulesDir | cut -c 4-)
    
    for chain in $rulesList; do
      # cut .sh
      chainName="${chain%.*}"
      if [ $chainName != $table ]; then
        $debug $ipt -t $table -F $chainName
        $debug $ipt -t $table -X $chainName
        $debug $ipt -t $table -N $chainName
        if [ $ipv6 == True ]; then
          $debug $ip6t -t $table -F $chainName
          $debug $ip6t -t $table -X $chainName
          $debug $ip6t -t $table -N $chainName
        fi

      fi
    done
  done
}

applyBaseRules () {
  tableList=$(ls $tablesDir)
  for table in $tableList; do
    rulesDir="$tablesDir/$table"
    rulesList=$(ls $rulesDir | sort )
    
    for chain in $rulesList; do 
     chainPath="$rulesDir/$chain"
     $debug $chainPath
    done
  done
}

applyPatches () {
  patchesList=$(ls $patchesDir | sort )
  for patch in $patchesList; do
    patchPath="$patchesDir/$patch"
    $debug $patchPath
  done
}

applyUserScripts () {
  userScriptList=$(ls $userScriptDir | sort )
  for userScript in $userScriptList; do
    userScriptPath="$userScriptDir/$userScript"
    $debug $userScriptPath
  done
}

applyAppsRules () {
  appTablesList=$(ls $appChainsDir)
  
  for chain in $appTablesList; do
    local appList=$(cat $appChainsDir/$chain)
    for appName in $appList; do
      local appId=$(su -c dumpsys package $appName | grep 'userId=' | cut -f 2 -d '=' )  
      $debug $ipt -A $chain -m owner --uid-owner $appId -j ACCEPT

      if [ $ipv6 == True ]; then
        $debug $ip6t -A $chain -m owner --uid-owner $appId -j ACCEPT
      fi

    done
  done
}

applyShelterRules () {
  shelterTablesList=$(ls $shelterChainsDir)

  for chain in $shelterTablesList; do
    local shelterList=$(cat $shelterChainsDir/$chain)
    for appName in $shelterList; do
      local appId=$(su -c dumpsys package $appName | grep 'userId=' | cut -f 2 -d '=' )  
      local appIdShelter="10$appId"
        # if app not exist skip
        if [ $appIdShelter != 10 ] ; then
          $debug $ipt -A $chain -m owner --uid-owner $appIdShelter -j ACCEPT

          if [ $ipv6 == True ]; then
            $debug $ip6t -A $chain -m owner --uid-owner $appIdShelter -j ACCEPT
          fi
        fi
    done
  done
}


echo "=== createTables ==="
createTables
echo " ===  done   ===" ; echo "=== applyPatches ==="
applyPatches
echo " ===  done   ===" ; echo "=== applyUserScripts ==="
applyUserScripts
echo " ===  done   ===" ; echo "=== applyAppsRules ==="
applyAppsRules
echo " ===  done   ===" ; echo "=== applyShelterRules ==="
applyShelterRules
echo " ===  done   ===" ; echo "=== applyBaseRules ==="
applyBaseRules
echo " ===  done   ==="
exit 0

