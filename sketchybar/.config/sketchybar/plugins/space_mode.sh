#!/bin/sh

MODE=$(yabai -m query --spaces --space | jq -r 'if .type == "bsp" then "tile" else .type end')

if [ $MODE = "stack" ]; then
	COUNT=$(yabai -m query --windows --space mouse | jq 'map(select(."stack-index" != 0)) | length')
	INDEX=$(yabai -m query --windows --window | jq '."stack-index"')

	if [ $INDEX = 0 ]; then
		INDEX="-"
	fi

	STACK=" ($INDEX/$COUNT)"
	if [ $COUNT = 0 ]; then
		STACK=" (1/1)"
		COUNT=$(yabai -m query --windows --space mouse | jq 'length')
		if [ $COUNT = 0 ]; then
			unset STACK
		fi
	fi
fi

sketchybar --set space_mode label="$MODE$STACK"
