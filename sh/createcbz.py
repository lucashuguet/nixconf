#!/usr/bin/env python3

import os
import sys
import shutil
import subprocess

if len(sys.argv) < 3:
    exit(1)

output = sys.argv[1]
files = sys.argv[2:]

if not os.path.splitext(output)[1] == ".cbz":
    exit(1)

for file in files:
    if not os.path.exists(file):
        print(file, "does not exists")
        exit(1)

newfiles = []
for (idx, file) in enumerate(files):
    ext = os.path.splitext(file)[1]
    new = str(idx).zfill(6) + ext

    newfiles.append(new)

    if not os.path.exists(new):
        shutil.copyfile(file, new)

cmd = ["7z", "a", "-tzip", "-m0=Copy", output] + newfiles
subprocess.run(cmd)

for file in newfiles:
    os.remove(file)
