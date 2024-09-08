#!/usr/bin/env python3

import os
import subprocess
from glob import glob

base = os.path.expanduser("~") + "/Documents/app/"
name = "open-webui"

directory = base + name + "/"

ps = subprocess.check_output([
    "docker", "compose", "-f", directory + "docker-compose.yaml", "ps"
], text=True).strip()

def process_container(c):
    name = os.path.basename(c).replace("docker-compose.", "").replace(".yaml", "")
    if name in ps:
        name += " (running)"

    return name

def notify(text):
    subprocess.run(["notify-send", "roficompose.py", text])

compose = [
    process_container(c)
    for c in glob(directory + "docker-compose.*.yaml")
] + [name]

selected = subprocess.check_output(
    ["rofi", "-dmenu"], text=True, input="\n".join(compose)
).strip()

action = {
    "name": "Starting",
    "cmd": ["up", "-d"]
}

if "(running)" in selected:
    selected = selected.replace(" (running)", "")
    action = {
        "name": "Stopping",
        "cmd": ["stop"]
    }

notify(action["name"] + " " + selected)

subprocess.run(
    [
        "docker", "compose",
        "-f", directory + "docker-compose." + selected.replace("." + name, "") + ".yaml"
    ] + action["cmd"]
)

notify("Sucessfully set " + selected + " " + action["cmd"][0])
