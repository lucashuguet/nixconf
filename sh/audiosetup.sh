#!/usr/bin/env bash

amixer -c 0 set Master unmute
amixer -c 0 set Master 100%

amixer -c 0 set Headphone unmute
amixer -c 0 set Headphone 100%

amixer -c 0 set Speaker unmute

amixer -c 0 set "Auto-Mute Mode" Enabled

wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1
