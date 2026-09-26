#!/bin/bash
# Double-clickable launcher for macOS. Runs the exporter in a Terminal window
# from its own directory, then waits so the output stays visible.
cd "$(dirname "$0")"
./roll20_adv_json_exporter
echo ""
echo "Done. Press any key to close this window..."
read -n 1 -s -r
