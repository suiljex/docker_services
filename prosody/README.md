# Ejabberd

Download scripts

``` bash
git clone https://github.com/prosody/prosody-docker
```

## Setup

Start the server/Install the server

``` bash
docker-compose up --detach --build
```

Register User

``` bash
# Interactive mode (will ask for password)
docker-compose exec prosody prosodyctl adduser me@example.com
# For batch registration of accounts consider the ‘prosodyctl register’ command, which allows you to specify everything on one line
docker-compose exec prosody prosodyctl register me example.com mypassword
```

Generate self-signed certificate

``` bash
docker-compose exec prosody prosodyctl cert generate example.com
```
