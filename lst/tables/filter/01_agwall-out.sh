#!/bin/sh

ipv6=False
#ipv6=True
debug=''
#debug='echo '

ipt=/system/bin/iptables

if [ $ipv6 == True ]; then
  ip6t=/system/bin/ip6tables
fi

for outputMask in 'tun+' 'ppp+' 'tap+' ; do
  $debug $ipt -A agwall-out -o $outputMask -j agwall-out-vpn
done

for outputMark in '0x3c/0xfffc' '0x40/0xfff8' ; do
  $debug $ipt -A agwall-out -m mark --mark $outputMark -g agwall-out-vpn
done

for outputMask in 'eth+' 'wlan+' 'tiwlan+' 'ra+' 'bnep+' ; do
  $debug $ipt -A agwall-out -o $outputMask -j agwall-out-wifi
done

for outputMask in 'rmnet+' 'pdp+' 'uwbr+' 'wimax+'\
                 'vsnet+' 'rmnet_sdio+' 'ccmni+'\
                 'qmi+' 'svnet0+' 'ccemni+' 'wwan+'\
                 'cdma_rmnet+' 'usb+' 'rmnet_usb+'\
                 'clat4+' 'cc2mni+' 'bond1+' 'rmnet_smux+'\
                 'ccinet+' 'v4-rmnet+' 'seth_w+' 'v4-rmnet_data+'\
                 'rmnet_ipa+' 'rmnet_data+' 'r_rmnet_data+' ; do
  $debug $ipt -A agwall-out -o $outputMask -j agwall-out-3g
done

$debug $ipt -A agwall-out -j agwall-out-tor
$debug $ipt -A agwall-out -j agwall-out-reject


if [ $ipv6 == True ]; then

for outputMask in 'tun+' 'ppp+' 'tap+' ; do
  $debug $ip6t -A agwall-out -o $outputMask -j agwall-out-vpn
done

for outputMark in '0x3c/0xfffc' '0x40/0xfff8' ; do
  $debug $ip6t -A agwall-out -m mark --mark $outputMark -g agwall-out-vpn
done

for outputMask in 'eth+' 'wlan+' 'tiwlan+' 'ra+' 'bnep+' ; do
  $debug $ip6t -A agwall-out -o $outputMask -j agwall-out-wifi
done

for outputMask in 'rmnet+' 'pdp+' 'uwbr+' 'wimax+'\
                 'vsnet+' 'rmnet_sdio+' 'ccmni+'\
                 'qmi+' 'svnet0+' 'ccemni+' 'wwan+'\
                 'cdma_rmnet+' 'usb+' 'rmnet_usb+'\
                 'clat4+' 'cc2mni+' 'bond1+' 'rmnet_smux+'\
                 'ccinet+' 'v4-rmnet+' 'seth_w+' 'v4-rmnet_data+'\
                 'rmnet_ipa+' 'rmnet_data+' 'r_rmnet_data+' ; do
  $debug $ip6t -A agwall-out -o $outputMask -j agwall-out-3g
done

$debug $ip6t -A agwall-out -j agwall-out-tor
$debug $ip6t -A agwall-out -j agwall-out-reject

fi

