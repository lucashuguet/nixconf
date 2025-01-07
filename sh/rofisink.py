#!/usr/bin/env python 

import subprocess

def parse_wpctl_status():
    output = str(subprocess.check_output("wpctl status", shell=True, encoding='utf-8'))
    lines = output.replace("├", "").replace("─", "").replace("│", "").replace("└", "").splitlines()

    sinks_index = None
    for index, line in enumerate(lines):
        if "Sinks:" in line:
            sinks_index = index
            break

    sinks = []
    for line in lines[sinks_index +1:]:
        if not line.strip():
            break
        sinks.append(line.strip())

    sinks_dict = []

    for idx, sink in enumerate(sinks):
        res = {}

        res["master"] = sink.startswith("*")
        res["muted"] = "MUTED" in sink

        sink = sink.replace("*", "").replace("MUTED", "").strip()

        res["volume"] = float(sink.split("[vol:")[1].split("]")[0].strip())

        sink = sink.split("[vol:")[0].strip()

        res["id"] = int(sink.split(".")[0])
        res["name"] = sink.split(".")[1].strip()

        contained = False
        for name in [sink["name"] for sink in sinks_dict]:
            if name in res["name"]:
                contained = True
        if contained:
            continue

        if res["master"]:
            res["current"] = True
        else:
            res["current"] = False

        sinks_dict.append(res)

    return sinks_dict

if __name__ == "__main__":
    sinks = parse_wpctl_status()

    names = []
    for sink in sinks:
        name = sink["name"]
        if sink["current"]:
            name += " - (current)"
        names.append(name)

    inputs = "\n".join(names)

    name = subprocess.check_output(["rofi", "-dmenu"], text=True, input=inputs).strip().replace(" - (current)", "")
    sink = next(iter([sink for sink in sinks if sink["name"] == name]), None)

    if not sink:
        exit(1)

    if not sink["current"]:
        subprocess.run(["mpc", "pause"])
        subprocess.run(["wpctl", "set-default", str(sink["id"])])
        subprocess.run(["notify-send", "rofisink.py", "sink changed"])
