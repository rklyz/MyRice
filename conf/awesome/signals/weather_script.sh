#!/bin/sh
# This script is used to find weather
city=$1
weather=$(curl -sf "wttr.in/$city?format='%C:%t'")
if [[ ! -z $weather ]]; then
  echo $weather
else
  echo "'Weather Unavailable:+?°C'"
fi
