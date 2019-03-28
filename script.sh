#!/bin/sh

function error_exit
{
  echo "$1" 1>&2
  exit
}

while read i; do
  if [[ $(curl -v https://"$i" 2>&1 | grep Connected | awk '{print $2}') = "Connected" ]]; then
    printf "$i "; curl -v https://"$i" 2>&1 | grep 'expire date:' | awk '{print $4, $5, $7}'
  else
    printf "Could not connect to https://$i"; printf '\n'
  fi
done <domains.txt

exit 0
