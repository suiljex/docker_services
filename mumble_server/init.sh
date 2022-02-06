#!/usr/bin/env sh

SCRIPT_NAME=$0
SCRIPT_FULL_PATH=$(dirname "$0")

cd "$SCRIPT_FULL_PATH"
git clone https://github.com/mumble-voip/mumble-docker

mkdir --parents ./.data/mumble_server/data/db