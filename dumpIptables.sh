#!/bin/sh

spacer='==============================================================='

iptables -n -L -v -t filter

echo $spacer

iptables -n -L -v -t nat

echo $spacer

ip6tables -n -L -v 

echo $spacer

iptables-save

echo $spacer

ip6tables-save

