#! /usr/bin/env bash
set -e

PUID=${PUID:-1000}
PGID=${PGID:-1000}
USER=${USER:-"minecraft"}

set-up-user.sh "$USER" "$PUID" "$PGID"

if [ -n "$FABRIC_LOADER_VERSION" ] && [ -n "$FABRIC_INSTALLER_VERSION" ]; then
    echo "Installing Fabric"
    JAR_NAME="$(download-fabric.sh)"
elif [ -n "$NEO_VERSION" ]; then
    echo "Installing NeoForge"

    JAR_NAME="$(download-neoforge.sh)"
    # Neoforge uses a custom script to run minecraft
    COMMAND="${*:-"cd /minecraft; PATH=$(which java):$PATH ./run.sh nogui"}"
elif [ -n "$FORGE_VERSION" ]; then
    echo "Installing Forge"

    JAR_NAME="$(download-forge.sh)"
    # Modern versions of forge use a custom script
    if [ -f "run.sh" ]; then
        COMMAND="${*:-"cd /minecraft; PATH=$(which java):$PATH ./run.sh nogui"}"
    fi
elif [ -n "$PAPER_BUILD" ]; then
    echo "Installing Paper"

    JAR_NAME="$(download-paper.sh)"
else
    echo "Installing Vanilla"

    JAR_NAME="$(download-vanilla.sh)"
fi

if [ -z "$COMMAND" ]; then
    # Default command
    COMMAND="${*:-"cd /minecraft; $(which java) ${JAVA_OPTS} -jar $JAR_NAME nogui"}"
fi

if [ "$EULA" == "true" ]; then
    echo "Accepting EULA"
    echo "eula=true" > eula.txt
fi

if [ -n "$PACKWIZ_URL" ]; then
    echo "Installing Pack"

    download-packwiz.sh
fi

configure-server-properties.sh

chown -R "${USER}":"${USER}" /minecraft

su -l "${USER}" -c "$COMMAND"
