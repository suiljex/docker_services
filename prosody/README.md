# Ejabberd

Download scripts

``` bash
git clone https://github.com/prosody/prosody-docker
```

## Setup

### Edit DNS records for your XMPP server

### Issue valid certificates

Use Let's encrypt to get certificates for domains:

- `chat.example.com`
- `room.example.com`

Certbot is loaded automatically. To get certificates run

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
    -d chat.example.com \
    -d room.example.com
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
docker-compose exec prosody prosodyctl cert generate chat.example.com
docker-compose exec prosody prosodyctl cert generate room.example.com
```

### Edit `prosody.cfg.lua` and `docker-compose.yml`

- Add users to `admins = { }` in `prosody.cfg.lua` (line 24)
- Add hosts to `prosody.cfg.lua` (lines 202, 204)

``` lua
VirtualHost "chat.example.com"

Component "room.example.com" "muc"
    modules_enabled = { "mam_muc"; }
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

If you have been using Let's Encrypt to obtain certificates, now is the time to run

``` bash
docker-compose exec prosody /usr/bin/prosodyctl --root cert import /etc/letsencrypt/live
```
