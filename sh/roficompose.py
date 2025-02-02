#!/usr/bin/env python3

import os
import subprocess
from glob import glob

directory = os.path.expanduser("~") + "/Documents/containers/"

ps = subprocess.check_output(["docker", "ps"], text=True).strip()

def process_container(c):
    name = os.path.basename(c)

    if name in ps:
        name += " (running)"

    return name

def notify(text):
    subprocess.run(["notify-send", "roficompose.py", text])

compose = [
    process_container(c)
    for c in glob(directory + "*")
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
        ["alacritty", "-e", "sh", "-c", "cd " + directory + selected + " && docker compose pull"],
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
    subprocess.Popen(
        cmd, cwd=directory + selected
    ).wait()

notify("Sucessfully set " + selected + " " + action["cmd"][-1][2])
