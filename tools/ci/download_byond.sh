#!/bin/bash
set -e
source dependencies.sh
echo "Downloading BYOND version $BYOND_MAJOR.$BYOND_MINOR"
curl -H "User-Agent: PMC-Unga-Marines/1.0 CI Script" "http://www.byond.com/download/build/515/515.1647_byond.zip" -o C:/byond.zip
