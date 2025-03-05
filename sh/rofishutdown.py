#!/usr/bin/env python3

import os
import subprocess
from glob import glob

directory = os.path.expanduser("~") + "/Documents/containers/"

ps = subprocess.check_output(["docker", "ps", "--format", "{{.Names}}"], text=True).strip()

def process_container(c):
    name = os.path.basename(c)

    if not os.path.exists(c + "/docker-compose.yaml"):
        return None

    if name not in ps:
        name = None

    return name

def notify(text):
    subprocess.run(["notify-send", "rofishutdown.py", text])

compose = [
    r for c in glob(directory + "*")
    if (r := process_container(c))
]

try:
    option = subprocess.check_output(
        ["rofi", "-dmenu"], text=True, input="\n".join(["yes", "no"])
    ).strip()
except Exception:
    exit(1)

if option == "yes":
    notify("Stopping " + ", ".join(compose) + " then will shutdown")
    print(compose)

    for c in compose:
        subprocess.run(
            [
                "docker", "compose",
                "-f", directory + ("docker-compose." + c + ".yaml"), "stop"
            ]
        )

    subprocess.run(["shutdown", "now", "-h"])
