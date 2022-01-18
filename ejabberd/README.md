# Ejabberd

Download scripts

``` bash
git clone https://github.com/processone/docker-ejabberd
```

## Setup

Start the server/Install the server

``` bash
docker-compose up
```

Register User

``` bash
docker-compose exec ejabberd bin/ejabberdctl register admin localhost passw0rd
User admin@localhost successfully registered
```

Similarly register other users as well (Incase when doing pubub/muc implementation )

``` bash
docker-compose exec ejabberd bin/ejabberdctl register user1 localhost passw0rd1
docker-compose exec ejabberd bin/ejabberdctl register user2 localhost passw0rd2
```

Get auth token (Needed when interacting with ejabberd rest api)

``` bash
docker-compose exec ejabberd bin/ejabberdctl oauth_issue_token admin@localhost 33334444 ejabberd:admin
```

## Exploration

Navigate to ejabberd admin panel http://localhost:5443/admin

For REST commands visit https://docs.ejabberd.im/developer/ejabberd-api/admin-api/

Additional Notes:
For configuring ejabberd to control which services are allowed visit https://docs.ejabberd.im/admin/configuration/
