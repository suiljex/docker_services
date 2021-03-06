# Openvpn

[GitHub Sources](https://github.com/dockovpn/docker-openvpn)

``` bash
./init.sh
```

## Quick Start with docker-compose

* Initialize the configuration files and certificates

``` bash
docker-compose run --rm openvpn ovpn_genconfig -u udp://VPN.SERVERNAME.COM
docker-compose run --rm openvpn ovpn_initpki
# better encryption:
docker-compose run --rm openvpn ovpn_genconfig -u udp://VPN.SERVERNAME.COM -C 'AES-256-GCM' -a 'SHA384'
docker-compose run -e EASYRSA_KEY_SIZE=4096 --rm openvpn ovpn_initpki
```

* Fix ownership (depending on how to handle your backups, this may not be needed)

``` bash
sudo chown -R $(whoami): ./openvpn-data
```

* Start OpenVPN server process

``` bash
docker-compose up --detach openvpn
```

* You can access the container logs with

``` bash
docker-compose logs --follow
```

* Generate a client certificate

``` bash
export CLIENTNAME="your_client_name"
# with a passphrase (recommended)
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME
# without a passphrase (not recommended)
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME nopass
```

* Retrieve the client configuration with embedded certificates

``` bash
docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn
# prevent docker from logging:
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_getclient USER > USER.ovpn
```

* Revoke a client certificate

``` bash
# Keep the corresponding crt, key and req files.
docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME
# Remove the corresponding crt, key and req files.
docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME remove
```

## Debugging Tips

* Create an environment variable with the name DEBUG and value of 1 to enable debug output (using "docker -e").

``` bash
docker-compose run -e DEBUG=1 -p 1194:1194/udp openvpn
```
