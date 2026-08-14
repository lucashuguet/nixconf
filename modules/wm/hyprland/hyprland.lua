hl.on("hyprland.start", function ()
  hl.exec_cmd("waybar")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("dunst")
  hl.exec_cmd("sleep 2 && audiosetup")
end)

local home = os.getenv("HOME")
local chunk = loadfile(home .. "/.config/colors/hyprland.lua")
local colors = chunk and chunk() or {}

hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("GSK_RENDERER", "ngl")

hl.config({
    input = {
        kb_layout = "fr",
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
        },
    },

    general = {
        gaps_in = 5,
        gaps_out = 5,
        border_size = 1,
        layout = "dwindle",
        col = {
            active_border = colors.accent,
            inactive_border = colors.lbackground,
        },
    },

    cursor = {
        inactive_timeout = 5,
    },

    decoration = {
        rounding = 5,
        shadow = {
            enabled = true,
            range = 4,
            color = colors.background,
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            new_optimizations = true,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    gestures = {
        workspace_swipe_forever = true,
    },

    misc = {
        enable_swallow = true,
        swallow_regex = "^(Alacritty)$",
        enable_anr_dialog = false,
        disable_hyprland_logo = true,
        disable_autoreload = true,
    },

    xwayland = {
        enabled = true,
        force_zero_scaling = true,
    },
})

hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 5, bezier = "myBezier" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 5, bezier = "myBezier" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "myBezier" })

hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7, bezier = "default", style = "popin 80%" })

hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })

hl.animation({ leaf = "fade",        enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "fadeIn",      enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "fadeOut",     enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "fadeSwitch",  enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "fadeShadow",  enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "fadeDim",     enabled = true, speed = 5, bezier = "default" })

hl.animation({ leaf = "workspaces",        enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "workspacesIn",      enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "workspacesOut",     enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "specialWorkspace",  enabled = true, speed = 5, bezier = "default" })

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.window_rule({ match = { title = "^(rofi)(.*)$" }, float = true })
hl.window_rule({
    match = { class = "^(nmcli)$" },
    size = {"(monitor_w * 0.3)", "(monitor_h * 0.1)"},
    center = true,
    float = true,
})

hl.window_rule({
    match = { class = "^(ueberzug.*)$" },
    decorate = false,
    float = true,
    no_anim = true,
    no_blur = true,
    no_focus = true,
    no_shadow = true,
})

hl.window_rule({ match = { class = ".*" }, opacity = "1 0.9" })

hl.bind("XF86AudioMicMute",    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioMute",       hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioNext",       hl.dsp.exec_cmd("mpc next"))
hl.bind("XF86AudioPlay",       hl.dsp.exec_cmd("mpc toggle"))
hl.bind("XF86AudioPrev",       hl.dsp.exec_cmd("mpc prev"))
hl.bind("XF86AudioLowerVolume",hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"), { repeating = true })
hl.bind("XF86AudioRaiseVolume",hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"), { repeating = true })

hl.bind("XF86Launch1",         hl.dsp.exec_cmd("powerprofilesctl set performance"))
hl.bind("XF86Launch4",         hl.dsp.exec_cmd("powerprofilesctl set balanced"))
hl.bind("SHIFT + XF86Launch4", hl.dsp.exec_cmd("powerprofilesctl set power-saver"))

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 2%-"),  { repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +2%"),  { repeating = true })

hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd("alacritty -e bpytop"))
hl.bind("SUPER + SHIFT + D",     hl.dsp.exec_cmd("rofi -i -show drun"))
hl.bind("SUPER + SHIFT + M",     hl.dsp.exec_cmd("alacritty -e cava"))
hl.bind("SUPER + SHIFT + Return",hl.dsp.exec_cmd("alacritty -e fish --private"))
hl.bind("SUPER + SHIFT + Q",     hl.dsp.exec_cmd("hyprctl kill"))
hl.bind("SUPER + SHIFT + X",     hl.dsp.exit())
hl.bind("SUPER + B",             hl.dsp.exec_cmd("blueman-manager"))
hl.bind("SUPER + D",             hl.dsp.exec_cmd("rofi -i -show run"))
hl.bind("SUPER + E",             hl.dsp.exec_cmd("thunar"))
hl.bind("SUPER + L",             hl.dsp.exec_cmd("hyprlock -q"))
hl.bind("SUPER + M",             hl.dsp.exec_cmd("alacritty -e ncmpcpp"))
hl.bind("SUPER + Q",             hl.dsp.window.close())
hl.bind("SUPER + Return",        hl.dsp.exec_cmd("alacritty"))
hl.bind("SUPER + V",             hl.dsp.exec_cmd("alacritty -e pulsemixer"))
hl.bind("SUPER + X",             hl.dsp.exec_cmd("rofishutdown"))

hl.bind("ALT + SHIFT + A",       hl.dsp.exec_cmd("roficompose alacritty"))
hl.bind("ALT + SHIFT + P",       hl.dsp.exec_cmd("rofipass otp"))
hl.bind("ALT + SHIFT + V",       hl.dsp.exec_cmd("roficombined"))
hl.bind("ALT + A",               hl.dsp.exec_cmd("roficompose alacritty bypass"))
hl.bind("ALT + D",               hl.dsp.exec_cmd("rofidrives"))
hl.bind("ALT + E",               hl.dsp.exec_cmd("emacsclient -c"))
hl.bind("ALT + F",               hl.dsp.exec_cmd("librewolf"))
hl.bind("ALT + M",               hl.dsp.exec_cmd("mpv $(wl-paste)"))
hl.bind("ALT + N",               hl.dsp.exec_cmd("rofinmcli"))
hl.bind("ALT + P",               hl.dsp.exec_cmd("rofipass"))
hl.bind("ALT + Q",               hl.dsp.exec_cmd("qutebrowser"))
hl.bind("ALT + S",               hl.dsp.exec_cmd("hyprshot -o ~/Pictures/screenshots -m region -z"))
hl.bind("ALT + T",               hl.dsp.exec_cmd("rofitheme"))
hl.bind("ALT + V",               hl.dsp.exec_cmd("rofisink"))
hl.bind("ALT + Z",               hl.dsp.exec_cmd("rofisurf"))

hl.bind("SUPER + SHIFT + F",     hl.dsp.window.fullscreen_state({ internal = -1, client = 2 }))
hl.bind("SUPER + SHIFT + G",     hl.dsp.exec_cmd("pkill waybar || waybar"))
hl.bind("SUPER + SHIFT + SPACE", hl.dsp.window.pin())
hl.bind("SUPER + F",             hl.dsp.window.fullscreen())
hl.bind("SUPER + G",             hl.dsp.exec_cmd("gamemode"))
hl.bind("SUPER + R",             hl.dsp.layout("rotatesplit"))
hl.bind("SUPER + S",             hl.dsp.layout("togglesplit"))
hl.bind("SUPER + SPACE",         hl.dsp.window.float({ action = "toggle" }))

local workspaces = {
    { key = "ampersand",  n = 1 },
    { key = "eacute",     n = 2 },
    { key = "quotedbl",   n = 3 },
    { key = "apostrophe", n = 4 },
    { key = "parenleft",  n = 5 },
    { key = "minus",      n = 6 },
    { key = "egrave",     n = 7 },
    { key = "underscore", n = 8 },
    { key = "ccedilla",   n = 9 },
    { key = "agrave",     n = 10 },
}

for _, ws in ipairs(workspaces) do
    hl.bind("SUPER + " .. ws.key,       hl.dsp.focus({ workspace = ws.n }))
    hl.bind("SUPER + SHIFT + " .. ws.key, hl.dsp.window.move({ workspace = ws.n }))
end

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))


hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + C", hl.dsp.submap("off"))
hl.define_submap("off", function()
    hl.bind("escape", hl.dsp.submap("reset"))
end)
