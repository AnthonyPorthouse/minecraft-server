#!/usr/bin/env bash

JAR_NAME="forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar"

if [ ! -f "$JAR_NAME" ]; then
    echo "Downloading Forge";
    curl -LsOJ "https://maven.minecraftforge.net/net/minecraftforge/forge/${MINECRAFT_VERSION}-${FORGE_VERSION}/${JAR_NAME}"
    java -jar "${JAR_NAME}" --installServer
fi

echo "$JAR_NAME"