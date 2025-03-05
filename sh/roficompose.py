#!/usr/bin/env python3

import os
import sys
import subprocess
from glob import glob

# roficompose.py [terminal emulator] [disable pull]

if len(sys.argv) < 2:
    exit(1)

directory = os.path.expanduser("~") + "/Documents/containers/"

ps = subprocess.check_output(["docker", "ps", "--format", "{{.Names}}"], text=True).strip()

def process_container(c):
    name = os.path.basename(c)

    if not os.path.exists(c + "/docker-compose.yaml"):
        return None

    if name in ps:
        name += " (running)"

    return name

def notify(text):
    subprocess.run(["notify-send", "roficompose.py", text])

compose = [
    r for c in glob(directory + "*")
    if (r := process_container(c))
]

try:
    selected = subprocess.check_output(
        ["rofi", "-dmenu"], text=True, input="\n".join(compose)
    ).strip()
except Exception:
    exit(1)

action = {
    "name": "Starting",
    "cmd": [
        [sys.argv[1], "-e", "sh", "-c", "cd " + directory + selected + " && docker compose pull"],
        ["docker", "compose", "up", "-d"]
    ]
}

if "(running)" in selected:
    selected = selected.replace(" (running)", "")
    action = {
        "name": "Stopping",
        "cmd": [["docker", "compose", "stop"]]
    }

notify(action["name"] + " " + selected)

for cmd in action["cmd"]:
    if sys.argv[1] in cmd and len(sys.argv) == 3:
        continue
    subprocess.Popen(
        cmd, cwd=directory + selected
    ).wait()

notify("Sucessfully set " + selected + " " + action["cmd"][-1][2])
