#!/usr/bin/env bash

JAR_NAME="fabric-server-mc.${MINECRAFT_VERSION}-loader.${FABRIC_LOADER_VERSION}-launcher.${FABRIC_INSTALLER_VERSION}.jar"

if [ ! -f "$JAR_NAME" ]; then
    # echo "Downloading Fabric";

    manifest=$(curl -s 'https://launchermeta.mojang.com/mc/game/version_manifest.json')
    version=$(jq -c ".versions[] | select( .id == \"$MINECRAFT_VERSION\" )" <<< "$manifest")
    version_manifest=$(curl -s "$(jq -r ".url" <<< "$version")")

    server_url=$(jq -r '.downloads.server.url' <<< "$version_manifest")

    curl -Lso "$JAR_NAME" -J "$server_url"
fi

echo "$JAR_NAME"