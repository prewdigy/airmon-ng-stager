#!/bin/bash

n="$(ifconfig | grep 'inet' | awk '{print $2}' | sed -n p | tee >(wc -l) | tail -1)"
list="$(ifconfig | grep 'flags' | awk '{print $2}' | sed -n p)"

echo "which adapter do you need the local IP address of?: [1-$n]"

ifconfig | grep 'flags' | awk '{print $1}' | sed -n p | awk 'NR==1,NR==$n{print NR" "$0}' | sed 's/://'

read ADPTR

PUB_IP="$(dig +short myip.opendns.com @resolver1.opendns.com)"
LOC_IP="$(ifconfig | grep 'inet' | awk '{print $2}' | sed -n "$ADPTR"p)"

echo -e "Your Public IP:\n $PUB_IP\n"
echo -e "Your Local IP:\n $LOC_IP\n"

exit 0
