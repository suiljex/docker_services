#!/usr/bin/env sh

SCRIPT_NAME=$0
SCRIPT_FULL_PATH=$(dirname "$0")

cd "$SCRIPT_FULL_PATH"
git clone https://github.com/kylemanna/docker-openvpn

mkdir --parents ./.data/openvpn