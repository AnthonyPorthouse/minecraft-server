#!/usr/bin/env bash

JAR_NAME="server-${MINECRAFT_VERSION}.jar"

if [ ! -f "$JAR_NAME" ]; then
    # echo "Downloading Minecraft";

    manifest=$(curl -s 'https://launchermeta.mojang.com/mc/game/version_manifest.json')
    version=$(jq -c ".versions[] | select( .id == \"$MINECRAFT_VERSION\" )" <<< "$manifest")
    version_manifest=$(curl -s "$(jq -r ".url" <<< "$version")")

    server_url=$(jq -r '.downloads.server.url' <<< "$version_manifest")

    curl -Lso "$JAR_NAME" -J "$server_url"
fi

echo "$JAR_NAME"