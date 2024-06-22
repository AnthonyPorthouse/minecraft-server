#!/usr/bin/env bash

if [ ! -f "packwiz-installer-bootstrap.jar" ]; then
    curl -LsO "https://github.com/packwiz/packwiz-installer-bootstrap/releases/download/v0.0.3/packwiz-installer-bootstrap.jar"
fi

java -jar packwiz-installer-bootstrap.jar -g -s server "$PACKWIZ_URL"
