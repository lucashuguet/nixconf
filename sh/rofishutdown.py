#!/usr/bin/env python3

import os
import subprocess
from glob import glob

base = os.path.expanduser("~") + "/Documents/app/"
name = "compose"

directory = base + name + "/"

ps = subprocess.check_output(["docker", "ps"], text=True).strip()

def process_containers(containers):
    res = []

    for c in containers:
        name = os.path.basename(c).replace("docker-compose.", "").replace(".yaml", "")
        if name in ps:
            res.append(name)

    return res

def notify(text):
    subprocess.run(["notify-send", "rofishutdown.py", text])

compose = process_containers(glob(directory + "docker-compose.*.yaml"))

try:
    option = subprocess.check_output(
        ["rofi", "-dmenu"], text=True, input="\n".join(["yes", "no"])
    ).strip()
except Exception:
    exit(1)

if option == "yes":
    notify("Stopping " + " ,".join(compose) + " then will shutdown")
    print(compose)

    for c in compose:
        subprocess.run(
            [
                "docker", "compose",
                "-f", directory + ("docker-compose." + c + ".yaml"), "stop"
            ]
        )

    subprocess.run(["shutdown", "now", "-h"])
