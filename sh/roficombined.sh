#!/usr/bin/env bash

COMBINED_MONITOR="combined-sink:monitor"

pw-link -lI | grep -A2 "^  [0-9]* ${COMBINED_MONITOR}" | awk '/\|->/ { print $1 }' | while read -r id; do
    pw-link -d "$id"
done

SINKS=$(pw-dump | jq -r '.[] | select(
  .info.props["media.class"] == "Audio/Sink" and
  .info.props["node.name"] != "combined-sink"
) | "\(.info.props["node.name"])\t\(.info.props["node.description"])"')

SELECTED_INDICES=$(echo "$SINKS" | awk -F'\t' '{ print $2 }' \
                       | rofi -dmenu -multi-select -format i -p "Select sinks")

if [[ -n "$SELECTED_INDICES" ]]; then
    while IFS= read -r idx; do
        NODE_NAME=$(echo "$SINKS" | awk -F'\t' "NR==$((idx+1)) { print \$1 }")
        echo "Linking combined-sink monitor → ${NODE_NAME}"
        pw-link "${COMBINED_MONITOR}_FL"   "${NODE_NAME}:playback_FL"
        pw-link "${COMBINED_MONITOR}_FR" "${NODE_NAME}:playback_FR"
    done <<< "$SELECTED_INDICES"
fi
