#!/usr/bin/env bash

/usr/autodesk/maya/bin/mayapy /runner/runner.py &
python3 -m http.server 8000 --bind 0.0.0.0
