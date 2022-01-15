# Minecraft server

Скачиваем скрипты

    git clone https://github.com/itzg/docker-minecraft-server

Запускаем сервера

    docker-compose up --build --detach

Данные будут храниться где-то в `./.data`

Редактировать параметры в `./.data` или

    docker exec -it minecraft-server nano /data/server.properties

Перезапуск

    docker restart minecraft-server

## Interacting with the server

[RCON](http://wiki.vg/RCON) is enabled by default, so you can `exec` into the container to
access the Minecraft server console:

    docker exec -i minecraft-server rcon-cli

Note: The `-i` is required for interactive use of rcon-cli.

To run a simple, one-shot command, such as stopping a Minecraft server, pass the command as
arguments to `rcon-cli`, such as:

    docker exec minecraft-server rcon-cli stop

_The `-i` is not needed in this case._
