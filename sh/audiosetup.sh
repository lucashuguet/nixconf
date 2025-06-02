#!/usr/bin/env bash

amixer set Master unmute
amixer set Master 100%

amixer set Headphone unmute
amixer set Headphone 100%

amixer set Speaker unmute

amixer set "Auto-Mute Mode" Enabled

wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1
