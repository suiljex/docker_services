# Mumble Server

Download scripts

    git clone https://github.com/goofball222/murmur

Start server

    docker-compose up --build --detach

After starting your container, you can manually set a new SuperUser password with:

    docker exec -it murmur /opt/murmur/murmur.x86 -ini /opt/murmur/config/murmur.ini -supw <password>

This can be run at any time to update the SuperUser password

Or retrieve the randomly generated SuperUser password with:

    docker logs murmur 2>&1 | grep "Password for 'SuperUser'"

Alternatively you may provide a SuperUser password during container creation using the `SUPERUSER_PASSWORD` environment variable.

Once you have a running container, you can edit the config with:

    docker exec -it murmur vi /opt/murmur/config.ini

After saving changes, restart your container:

    docker restart murmur

Find data at

    ./.data
