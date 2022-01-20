# Minecraft server

[GitHub Sources](https://github.com/itzg/docker-minecraft-server)

``` bash
./init.sh
```

## Quick Start with docker-compose

Start server

``` bash
docker-compose up --build --detach
```

All data is stored in `./.data/minecraft`

Edit settings in `./.data/minecraft/server.properties` or

``` bash
docker exec -it minecraft-server nano /data/server.properties
```

Restart

``` bash
docker restart minecraft-server
```

## Interacting with the server

[RCON](http://wiki.vg/RCON) is enabled by default, so you can `exec` into the container to
access the Minecraft server console:

``` bash
docker exec -i minecraft-server rcon-cli
```

Note: The `-i` is required for interactive use of rcon-cli.

To run a simple, one-shot command, such as stopping a Minecraft server, pass the command as
arguments to `rcon-cli`, such as:

``` bash
docker exec minecraft-server rcon-cli stop
```

_The `-i` is not needed in this case._
