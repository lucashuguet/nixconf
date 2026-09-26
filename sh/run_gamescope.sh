#!/usr/bin/env bash
set -xeuo pipefail

gamescopeArgs=(
    -r 60
    -W 1920
    -H 1080
    --expose-wayland
    --mangoapp
    # --steam
)
steamArgs=(
    -pipewire-dmabuf
    -tenfoot
)
mangoConfig=(
    fps
    cpu_temp
    gpu_temp
    ram
    vram
)
mangoVars=(
    MANGOHUD=1
    MANGOHUD_CONFIG="$(IFS=,; echo "${mangoConfig[*]}")"
)

export "${mangoVars[@]}"
# exec gamescope "${gamescopeArgs[@]}" -- steam "${steamArgs[@]}"
exec gamescope "${gamescopeArgs[@]}" -- $@
