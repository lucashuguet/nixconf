#!/usr/bin/env bash

tooltip=""
level=0
n_bat=0
alt=""

info() {
  bat=$1
  name=$(basename "$1")
  status=$(cat $bat/status)
  capacity=$(cat $bat/capacity)
  tooltip="$tooltip$name: $status, capacity: $capacity\n"
  level=$(($level+$capacity))
  n_bat=$(($n_bat+1))
}

for bat in $(ls -d /sys/class/power_supply/BAT*); do
  info "$bat"
done

text=$(($level/$n_bat))

if [ "$text" -le 10 ]; then
    alt="critical"
elif [ "$text" -le 20 ]; then
    alt="warning"
elif [ "$text" -le 60 ]; then
    alt="normal"
elif [ "$text" -le 80 ]; then
    alt="good"
elif [ "$text" -le 100 ]; then
    alt="full"
fi

tooltip=$(echo "$tooltip" | sed 's/$/\\n/' | tr -d '\n')
tooltip="${tooltip%\\n\\n}"

echo "{\"text\": \"$text\", \"alt\": \"$alt\", \"tooltip\": \"$tooltip\"}"
