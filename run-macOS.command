#!/bin/bash
# Double-clickable launcher for macOS. Runs the exporter in a Terminal window
# from its own directory, then waits so the output stays visible.
# Works either in a published output folder (executable already present) or
# in the source repo (builds it automatically via dotnet publish first).
cd "$(dirname "$0")"

EXE="./roll20_adv_json_exporter"
if [ ! -x "$EXE" ] && [ -x "./dist/roll20_adv_json_exporter" ]; then
  EXE="./dist/roll20_adv_json_exporter"
fi

if [ ! -x "$EXE" ]; then
  if [ -f "./roll20_adv_json_exporter.csproj" ]; then
    if ! command -v dotnet >/dev/null 2>&1; then
      echo "The .NET SDK is required to build this tool but was not found."
      echo "Install it from https://dotnet.microsoft.com/download and run this script again."
      echo ""
      echo "Press any key to close this window..."
      read -n 1 -s -r
      exit 1
    fi
    echo "roll20_adv_json_exporter not found - building it now, this may take a minute..."
    dotnet publish -c Release --property:PublishDir=./dist -p:PublishProfile=Release
    if [ $? -ne 0 ]; then
      echo ""
      echo "Build failed. See errors above."
      echo "Press any key to close this window..."
      read -n 1 -s -r
      exit 1
    fi
    EXE="./dist/roll20_adv_json_exporter"
  else
    echo "roll20_adv_json_exporter not found next to this script, and no project file was found to build it."
    echo ""
    echo "Press any key to close this window..."
    read -n 1 -s -r
    exit 1
  fi
fi

"$EXE"
echo ""
echo "Done. Press any key to close this window..."
read -n 1 -s -r
