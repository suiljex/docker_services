# Prosody

[GitHub Sources: prosody](https://github.com/prosody/prosody-docker)

[GitHub Sources: coturn](https://github.com/coturn/coturn)

``` bash
./init.sh
```

## Setup

### Issue valid certificates

Use Let's encrypt to get certificates for domains:

- `xmpp.example.com`
- `room.example.com`
- `upload.example.com`
- `proxy.example.com`

To get certificates run

``` bash
# In interactive mode
docker run -it --rm --name certbot \
    -p 80:80 -p 443:443 \
    -v "${PWD}/.data/letsencrypt:/etc/letsencrypt" \
    certbot/certbot certonly

# or in non-interactive mode
docker run -it --rm --name certbot \
    -p 80:80 -p 443:443 \
    -v "${PWD}/.data/letsencrypt:/etc/letsencrypt" \
    certbot/certbot certonly --standalone --noninteractive --agree-tos \
    --email user@email.com \
    -d xmpp.example.com \
    -d room.example.com \
    -d upload.example.com \
    -d proxy.example.com
```

To renew certificates run

``` bash
docker run -it --rm --name certbot \
    -p 80:80 -p 443:443 \
    -v "${PWD}/.data/letsencrypt:/etc/letsencrypt" \
    certbot/certbot renew --noninteractive
```

After creating or renewing certificates run (service should be running)

``` bash
docker-compose exec prosody /usr/bin/prosodyctl --root cert import /etc/letsencrypt/live
```

Alternatively you can generate self-signed certificate (don't do it)

``` bash
docker-compose exec prosody /usr/bin/prosodyctl cert generate xmpp.example.com
docker-compose exec prosody /usr/bin/prosodyctl cert generate room.example.com
docker-compose exec prosody /usr/bin/prosodyctl cert generate upload.example.com
docker-compose exec prosody /usr/bin/prosodyctl cert generate proxy.example.com
```

### Edit `prosody.cfg.lua` and `docker-compose.yml`

- Add users to `admins = { }` in `prosody.cfg.lua` (line 31)

``` lua
admins = { }
```

- Change hosts in `prosody.cfg.lua` (lines 3-7)

``` lua
local host_base = "example.com"
local host_xmpp = "xmpp." .. host_base
local host_room = "room." .. host_base
local host_upload = "upload." .. host_base
local host_proxy = "proxy." .. host_base
```

- Change host in `coturn.conf` (line 358)

``` ini
realm=proxy.example.com
```

- Change passwords in `coturn.conf` (line 244) and in `prosody.cfg.lua` (line 228)

``` ini
## coturn.conf ##
static-auth-secret=passw0rd
```

``` lua
-- prosody.cfg.lua --
-- list of external services
external_services = {
  {
    type = "stun",
    transport = "udp",
    host = host_proxy,
    port = 3478
  }, {
    type = "turn",
    transport = "udp",
    host = host_proxy,
    port = 3478,
    secret = "passw0rd"
  }
}
```

### Start service

Start the server/Install the server

``` bash
docker-compose up --detach --build
```

Register User

``` bash
# Interactive mode (will ask for password)
docker-compose exec prosody /usr/bin/prosodyctl adduser user0@example.com
# For batch registration of accounts consider the ‘prosodyctl register’ command, which allows you to specify everything on one line
docker-compose exec prosody /usr/bin/prosodyctl register user0 example.com passw0rd
```

If you used Let's Encrypt to get certificates in the previous steps, now is the time to run

``` bash
docker-compose exec prosody /usr/bin/prosodyctl --root cert import /etc/letsencrypt/live
```
