#!/usr/bin/env bash

tooltip=""
level=0
total_now=0
total_full=0
n_bat=0
alt=""

info() {
  bat=$1
  name=$(basename "$bat")
  status=$(cat "$bat/status")
  capacity=$(cat "$bat/capacity")

  if [ -f "$bat/charge_full" ] && [ -f "$bat/charge_now" ]; then
    full=$(cat "$bat/charge_full")
    now=$(cat "$bat/charge_now")
  elif [ -f "$bat/energy_full" ] && [ -f "$bat/energy_now" ]; then
    full=$(cat "$bat/energy_full")
    now=$(cat "$bat/energy_now")
  else
    full=100
    now=$capacity
  fi

  tooltip="$tooltip$name: $status, capacity: $capacity\n"
  total_now=$(($total_now+$now))
  total_full=$(($total_full+$full))
  n_bat=$(($n_bat+1))
}

for bat in $(ls -d /sys/class/power_supply/BAT*); do
  info "$bat"
done

text=$(( (total_now * 100) / total_full ))

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
