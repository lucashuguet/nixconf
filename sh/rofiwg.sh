#!/usr/bin/env bash
# rofiwg — rofi selector for the WireGuard configs in ~/Documents/wg
#
# Menu lists every *.conf; the connected one is shown bold with ●.
# Selecting it disconnects it; selecting another connects it (bringing the
# current one down first, single pkexec prompt for the whole switch).
#
# Optional per-VPN hook: ~/Documents/wg/sh/<stem>.sh (0600/0700, owned by you).
# It is *sourced* (as root) by the root body below and may define:
#   hook_pre_up <log>    — runs before wg-quick up; failure aborts the connect
#   hook_post_down <log> — always runs on teardown (also on rollback paths)
#
# Root escalation goes through pkexec; every value is passed as a
# printf %q-quoted assignment prepended to the root body, and the body
# hardcodes a PATH because pkexec clears the environment.
set -u

BIN=/run/current-system/sw/bin
WGD="$HOME/Documents/wg"
HOOKD="$WGD/sh"
STATE="$HOME/.local/state/rofiwg"
mkdir -p "$STATE"

note() { "$BIN/notify-send" -u "${2:-normal}" -a rofiwg "VPN" "$1"; }

# Mirror wg-quick's interface naming: keep [a-zA-Z0-9_=+.-], replace the
# rest with _, truncate to 15 chars.
iface_of() {
  local s=${1%.conf}
  s=${s//[^a-zA-Z0-9_=+.-]/_}
  printf '%s' "${s:0:15}"
}
is_up() { [[ -e "/sys/class/net/$1" ]]; }

# ---------------------------------------------------------------------------
# Root body — executed by: pkexec bash -c "<%q assignments>\n$ROOT_BODY"
# Prints only "OK <msg>" / "ERR <msg>" lines; the orchestrator relays the
# last one to notify-send.
# ---------------------------------------------------------------------------
ROOT_BODY=$(
  cat <<'RSBODY'
PATH=/run/current-system/sw/bin:/run/wrappers/bin
mkdir -p "$WG_RUNDIR"
exec 2>>"$WG_LOGD/root.log"

ok()  { printf 'OK %s\n' "$1"; }
err() { printf 'ERR %s\n' "$1"; }

load_hook() {  # $1 = stem
  local f="$WG_HOOKD/$1.sh"
  [[ -r "$f" ]] && source "$f"
  return 0
}
pid_alive() {  # $1 = stem — is the wstunnel pidfile alive and a wstunnel?
  local p="$WG_RUNDIR/$1.pid" pid
  [[ -r "$p" ]] || return 1
  pid=$(cat "$p" 2>/dev/null)
  if [[ -z "$pid" || ! -d "/proc/$pid" ]] || ! grep -qw wstunnel "/proc/$pid/comm" 2>/dev/null; then
    rm -f "$p"
    return 1
  fi
  return 0
}
stop_wst() {  # $1 = stem
  if pid_alive "$1"; then
    kill "$(cat "$WG_RUNDIR/$1.pid")" 2>/dev/null
    sleep 0.3
    kill -9 "$(cat "$WG_RUNDIR/$1.pid" 2>/dev/null)" 2>/dev/null
  fi
  rm -f "$WG_RUNDIR/$1.pid"
  return 0
}

down_one() {  # $1=stem $2=conf — tear down, always clean up residue
  local stem=$1 conf=$2
  load_hook "$stem"
  if [[ -e "/sys/class/net/$stem" ]]; then
    if ! wg-quick down "$conf" >>"$WG_LOGD/root.log" 2>&1; then
      ip link del "$stem" 2>>"$WG_LOGD/root.log" || true
      declare -F hook_post_down >/dev/null && hook_post_down "$WG_LOGD/$stem.log" >>"$WG_LOGD/$stem.log" 2>&1
      stop_wst "$stem"
      err "wg-quick down failed for $stem; removed interface"
      return 1
    fi
  else
    [[ -n "$conf" && -f "$conf" ]] && wg-quick down "$conf" >/dev/null 2>&1 || true
  fi
  declare -F hook_post_down >/dev/null && hook_post_down "$WG_LOGD/$stem.log" >>"$WG_LOGD/$stem.log" 2>&1
  stop_wst "$stem"
  return 0
}

up_one() {  # $1=stem $2=conf — connect, verify, roll back on failure
  local stem=$1 conf=$2 log="$WG_LOGD/$1.log" rc
  load_hook "$stem"
  if declare -F hook_pre_up >/dev/null; then
    hook_pre_up "$log" >>"$log" 2>&1
    rc=$?
    if (( rc != 0 )); then
      err "pre-up failed for $stem (rc=$rc) — see $log"
      return 1
    fi
  fi
  if ! wg-quick up "$conf" >>"$WG_LOGD/root.log" 2>&1; then
    declare -F hook_post_down >/dev/null && hook_post_down "$log" >>"$log" 2>&1
    stop_wst "$stem"
    err "wg-quick up failed for $stem — see $WG_LOGD/root.log"
    return 1
  fi
  sleep 1
  if ! [[ -e "/sys/class/net/$stem" ]]; then
    down_one "$stem" "$conf"
    err "$stem did not come up (rolled back) — see $WG_LOGD/root.log"
    return 1
  fi
  ok "connected: $stem"
  return 0
}

case "$WG_ACT" in
  up)
    up_one "$WG_STEM" "$WG_CONF" ;;
  down)
    down_one "$WG_STEM" "$WG_CONF" && ok "disconnected: $WG_STEM" ;;
  switch)
    if down_one "$WG_OLD_STEM" "$WG_OLD_CONF"; then
      up_one "$WG_STEM" "$WG_CONF"
    else
      err "teardown of $WG_OLD_STEM failed — not starting $WG_STEM"
    fi ;;
  *)
    err "unknown action: $WG_ACT" ;;
esac
exit 0
RSBODY
)

# ---------------------------------------------------------------------------
# Menu
# ---------------------------------------------------------------------------
exec 9>"$STATE/.lock"
flock -n 9 || { note "another rofiwg operation is running" critical; exit 0; }

shopt -s nullglob
confs=("$WGD"/*.conf)
(( ${#confs[@]} )) || { note "no .conf files in $WGD" critical; exit 0; }

rows=(); up_stems=()
for conf in "${confs[@]}"; do
  stem=$(basename "$conf" .conf)
  if is_up "$(iface_of "$stem")"; then
    up_stems+=("$stem")
    rows+=("<span weight=\"bold\">● $stem</span>")
  else
    rows+=("○ $stem")
  fi
done

sel=$(printf '%s\n' "${rows[@]}" | "$BIN/rofi" -dmenu -p "wg" -i -markup-rows) || exit 0

# strip pango span tag, then the ●/○ marker + space
stem=$(printf '%s' "$sel" | sed -E 's/^<span[^>]*>//; s#</span>$##; s/^[^ ]+ //')
[[ "$stem" =~ ^[A-Za-z0-9_.-]+$ ]] || exit 0
conf="$WGD/$stem.conf"
[[ -r "$conf" ]] || { note "$conf not readable" critical; exit 0; }

# trust pre-check: this file will be sourced as root
hook="$HOOKD/$stem.sh"
if [[ -e "$hook" ]]; then
  owner=$(stat -c '%U' "$hook")
  mode=$(stat -c '%a' "$hook")
  if [[ "$owner" != "$(id -un)" ]]; then
    note "hook must be owned by you: $hook (owned by $owner)" critical
    exit 0
  fi
  if [[ "$mode" != [0-7][04]0 && "$mode" != [0-7]00 ]]; then
    note "hook must be 0600/0700 (is $mode): $hook" critical
    exit 0
  fi
fi

act=up; old_stem=""; old_conf=""
if [[ " ${up_stems[*]:-} " == *" $stem "* ]]; then
  act=down
elif (( ${#up_stems[@]} > 0 )); then
  act=switch
  old_stem="${up_stems[0]}"
  old_conf="$WGD/$old_stem.conf"
  if (( ${#up_stems[@]} > 1 )); then
    note "several tunnels are up (${up_stems[*]}); switching from $old_stem only"
  fi
fi

# NB: "$()" strips trailing newlines, hence the explicit $'\n' separator —
# without it the assignment line and the body's first line would fuse into
# one (still-valid but wrong) assignment.
rootcmd="$(printf 'WG_ACT=%q WG_STEM=%q WG_CONF=%q WG_OLD_STEM=%q WG_OLD_CONF=%q WG_HOOKD=%q WG_LOGD=%q WG_RUNDIR=%q' \
  "$act" "$stem" "$conf" "$old_stem" "$old_conf" "$HOOKD" "$STATE" "/run/rofiwg")"$'\n'"$ROOT_BODY"

# ROFIWG_PRINT=1 skips pkexec and prints the exact root command (for testing)
if [[ -n "${ROFIWG_PRINT:-}" ]]; then
  printf '%s' "$rootcmd"
  exit 0
fi

out=""; rc=0
out=$(pkexec "$BIN/bash" -c -- "$rootcmd" 2>/dev/null) || rc=$?
if (( rc == 125 || rc == 126 || rc == 127 )); then
  note "Authorization denied (polkit)" critical
  exit 0
fi

line=$(printf '%s\n' "$out" | grep -E '^(OK|ERR) ' | tail -n1)
if [[ -z "$line" ]]; then
  note "rofiwg produced no result — see $STATE/root.log" critical
  exit 0
fi
note "${line#* }" "$([[ "$line" == ERR* ]] && echo critical || echo normal)"
