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
        return None

    if not os.path.exists(c + "/open.sh"):
        return None

    return name

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

subprocess.run([directory + selected + "/open.sh"]);
