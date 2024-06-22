# [anthonyporthouse/minecraft-server](https://github.com/anthonyporthouse/minecraft-server)

## Tags

The major tags determine which version of java you will be using to run minecraft.

- `java8`
- `java11`
- `java16`
- `java17`

## Usage

### docker-compose

Example `docker-compose.yaml` file:

```yaml
---
services:
  minecraft:
    image: ghcr.io/anthonyporthouse/minecraft-server:java17

    restart: unless-stopped

    environment:
      PUID: 1000
      PGID: 1000

      MINECRAFT_VERSION: 1.20.2
      JAVA_OPTS: -Xms1G -Xmx2G

      MC_DIFFICULTY: hard
      MC_MOTD: My Server
    
    ports:
      - "25565:25565"
    
    volumes:
      - ./server:/minecraft

```

For a more in-depth example, check out the `test` directory, which has a compose.yaml with an example of each loader being configured.

### Environment Variables

To make this image more useful several environment variables are available to use.

**`PUID`**

> Default Value: `1000`

This environment variable specifies the ID to use for the minecraft user inside of the container.

This should map to the current users UID which can be found using `id -u` on Linux or Mac.

**`PGID`**

> Default Value: `1000`

This environment variable specifies the ID to use for the minecraft group inside of the container.

This should map to the current users GID which can be found using `id -g` on Linux or Mac.

**`MINECRAFT_VERSION`**

This environment variable specifies which version of Minecraft you wish to run. This can be any version supported, either stable or prerelease.

If this is changed after an initial run the container will pull the new version and use that.

**`FABRIC_LOADER_VERSION`**

This specifies, when paired with the `FABRIC_INSTALLER_VERSION` environment variable, that you want to run fabric and specified the version of the loader you want to install.

A list of all fabric loader versions can be found on the [fabric-loader Github](https://github.com/FabricMC/fabric-loader/releases)

**`FABRIC_INSTALLER_VERSION`**

This specifies the verison of the fabric installer you want to use. At the time of writing, this is most likely `1.0.1`.

**`NEO_VERSION`**

The version of NeoForge to use. Specifying this means the server will run the NeoForge loader.

A full list of NeoForge versions can be seen on their [project listing](https://projects.neoforged.net/neoforged/neoforge)

**`FORGE_VERSION`**

The version of Forge to use. Specifying this means the server will run the Minecraft Forge loader.

A full list of Forge versions can be seen on their [homepage](https://files.minecraftforge.net/net/minecraftforge/forge/)

**`PAPER_BUILD`**

The build of Paper to use. This is paired alongside the `MINECRAFT_VERSION` environment variable to determine which version of Paper will be used.

A full list of Paper builds against Minecraft versions can be seen on the [Paper downloads page](https://papermc.io/downloads/paper)

**`PACKWIZ_URL`**

When set to the URL of a packwiz `pack.toml` packwiz will be used to download the server version of the pack specified.

More information can be found at the [packwiz site](https://packwiz.infra.link/).

**`EULA`**

This must be set to `true` to show acceptance of the Minecraft EULA

**`JAVA_OPTS`**

> Default Value: `-Xms1G -Xmx2G`

This environment variable allows you to specify custom JVM arguments when running minecraft.

**`MC_*`**

Any environment variable that is prefixed with `MC_` will have its prefix removed, be lowercased and have any `_` replaced with `-` then be either replaced, or appended to the `server.properties` file.

Example: `MC_MAX_PLAYERS` with value `10` sets the value of `max-players=10` in the `server.properties` file.
