#!/usr/bin/env bash

amixer -c 1 set Master unmute
amixer -c 1 set Master 100%

amixer -c 1 set Headphone unmute
amixer -c 1 set Headphone 100%

amixer -c 1 set Speaker unmute
amixer -c 1 set Speaker 100%

amixer -c 1 set "Auto-Mute Mode" Enabled

amixer set Capture nocap
