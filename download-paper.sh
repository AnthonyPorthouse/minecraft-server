#!/usr/bin/env bash

JAR_NAME="paper-${MINECRAFT_VERSION}-${PAPER_BUILD}.jar"

if [ ! -f "$JAR_NAME" ]; then
    echo "Downloading Paper";

    server_url=https://api.papermc.io/v2/projects/paper/versions/${MINECRAFT_VERSION}/builds/${PAPER_BUILD}/downloads/${JAR_NAME}

    curl -Lso "$JAR_NAME" -J "$server_url"
fi

echo "$JAR_NAME"