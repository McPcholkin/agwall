#!/bin/sh

ipv6=False
#ipv6=True
debug=''
#debug='echo '

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

for inputMaskVpn in 'tun+' 'ppp+' 'tap+' ; do
  $debug $ipt -A agwall-inp -i $inputMaskVpn -j agwall-inp-vpn
done

for intputMarkVpn in '0x3c/0xfffc' '0x40/0xfff8' ; do
  $debug $ipt -A agwall-inp -m mark --mark $inputMarkVpn -g agwall-inp-vpn
done

for intputMaskWifi in 'eth+' 'wlan+' 'tiwlan+' 'ra+' 'bnep+' ; do
  $debug $ipt -A agwall-inp -i $intputMaskWifi -j agwall-inp-wifi
done

for intputMask3g in 'rmnet+' 'pdp+' 'uwbr+' 'wimax+'\
                 'vsnet+' 'rmnet_sdio+' 'ccmni+'\
                 'qmi+' 'svnet0+' 'ccemni+' 'wwan+'\
                 'cdma_rmnet+' 'usb+' 'rmnet_usb+'\
                 'clat4+' 'cc2mni+' 'bond1+' 'rmnet_smux+'\
                 'ccinet+' 'v4-rmnet+' 'seth_w+' 'v4-rmnet_data+'\
                 'rmnet_ipa+' 'rmnet_data+' 'r_rmnet_data+' ; do
  $debug $ipt -A agwall-inp -i $intputMask3g -j agwall-inp-3g
done

$debug $ipt -A agwall-inp -j agwall-inp-tor
$debug $ipt -A agwall-inp -j agwall-inp-reject



if [ $ipv6 == True ]; then

for inputMaskVpn in 'tun+' 'ppp+' 'tap+' ; do
  $debug $ip6t -A agwall-inp -i $inputMaskVpn -j agwall-inp-vpn
done

for intputMarkVpn in '0x3c/0xfffc' '0x40/0xfff8' ; do
  $debug $ip6t -A agwall-inp -m mark --mark $inputMarkVpn -g agwall-inp-vpn
done

for intputMaskWifi in 'eth+' 'wlan+' 'tiwlan+' 'ra+' 'bnep+' ; do
  $debug $ip6t -A agwall-inp -i $inputMaskWifi -j agwall-inp-wifi
done

for intputMask3g in 'rmnet+' 'pdp+' 'uwbr+' 'wimax+'\
                 'vsnet+' 'rmnet_sdio+' 'ccmni+'\
                 'qmi+' 'svnet0+' 'ccemni+' 'wwan+'\
                 'cdma_rmnet+' 'usb+' 'rmnet_usb+'\
                 'clat4+' 'cc2mni+' 'bond1+' 'rmnet_smux+'\
                 'ccinet+' 'v4-rmnet+' 'seth_w+' 'v4-rmnet_data+'\
                 'rmnet_ipa+' 'rmnet_data+' 'r_rmnet_data+' ; do
  $debug $ip6t -A agwall-inp -i $inputMask3g -j agwall-inp-3g
done

$debug $ip6t -A agwall-inp -j agwall-inp-tor
$debug $ip6t -A agwall-inp -j agwall-inp-reject

fi

