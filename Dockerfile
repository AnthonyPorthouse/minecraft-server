ARG JAVA_VERSION=21

FROM eclipse-temurin:${JAVA_VERSION}

RUN apt update \
    && apt install -y jq \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --uid 1000 --shell /bin/bash --gecos "" minecraft \
    && addgroup minecraft users

EXPOSE 25565

WORKDIR /minecraft

ENV MINECRAFT_VERSION=

# Fabric Specific Versions
ENV FABRIC_LOADER_VERSION=
ENV FABIRC_INSTALLER_VERSION=

# NeoForge Specific Version
ENV NEO_VERSION=

# Forge Specific Version
ENV FORGE_VERSION=

# Paper Specific Version
ENV PAPER_BUILD=

# Packwiz Pack URL
ENV PACKWIZ_URL=

ENV EULA=

ENV JAVA_OPTS="-Xms1G -Xmx2G"

COPY entrypoint.sh /entrypoint.sh
COPY ./set-up-user.sh /usr/local/bin/set-up-user.sh
COPY ./configure-server-properties.sh /usr/local/bin/configure-server-properties.sh

# Downloaders
COPY ./download-vanilla.sh /usr/local/bin/download-vanilla.sh
COPY ./download-fabric.sh /usr/local/bin/download-fabric.sh
COPY ./download-forge.sh /usr/local/bin/download-forge.sh
COPY ./download-neoforge.sh /usr/local/bin/download-neoforge.sh
COPY ./download-paper.sh /usr/local/bin/download-paper.sh
COPY ./download-packwiz.sh /usr/local/bin/download-packwiz.sh

ENTRYPOINT [ "/entrypoint.sh" ]