#!/usr/bin/env bash

HYPRGAMEMODE=$(hyprctl getoption animations:enabled -j | jq -r '.int')

if [ "$HYPRGAMEMODE" = "1" ]; then
    hyprctl eval '
        hl.config({
            animations = { enabled = false },
            decoration = {
                shadow = { enabled = false },
                blur   = { enabled = false },
                rounding = 0
            },
            general = {
                gaps_in = 0,
                gaps_out = 0,
                border_size = 0
            }
        })
    '
    exit
fi

hyprctl reload
