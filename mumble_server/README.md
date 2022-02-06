# Mumble Server

[GitHub Sources](https://github.com/mumble-voip/mumble-docker)

``` bash
./init.sh
```

## Quick Start with docker-compose

Start server

``` bash
docker-compose up --build --detach
```

After starting your container, you can manually set a new SuperUser password with:

``` bash
docker exec -it mumble_server /usr/bin/mumble-server -ini /data/murmur.ini -supw <password>
```

This can be run at any time to update the SuperUser password

Or retrieve the randomly generated SuperUser password with:

```bash
docker logs mumble_server 2>&1 | grep "Password for 'SuperUser'"
```

## SSL Certificates

- SSL certificate should be mounted at `/data/cert.pem`

- SSL key should be mounted at `/data/key.pem`

To reload certificates run:

```bash
docker kill --signal="SIGUSR1" mumble_server
```

After saving changes, restart your container:

``` bash
docker restart mumble_server
```

Find data at `./.data/mumble_server`
