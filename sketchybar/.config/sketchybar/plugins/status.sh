#!/bin/sh

DATA=$(macmon pipe -s 1) 
TEMP=$(echo $DATA | jq '.temp.cpu_temp_avg' | xargs printf "%0.2f")

ELOAD=$(echo $DATA | jq '.ecpu_usage.[1]' | xargs printf "%0.2f")
ELOAD=$(echo "$ELOAD * 100" | bc | xargs printf "%02d")

PLOAD=$(echo $DATA | jq '.pcpu_usage.[1]' | xargs printf "%0.2f")
PLOAD=$(echo "$PLOAD * 100" | bc | xargs printf "%02d")

sketchybar --set "$NAME" label="$ELOAD% | $PLOAD%   $TEMP ℃"
