#!/usr/bin/env sh

SCRIPT_NAME=$0
SCRIPT_FULL_PATH=$(dirname "$0")

cd "$SCRIPT_FULL_PATH"
git clone https://github.com/prosody/prosody-docker

mkdir --parents ./.data/prosody/certs
mkdir --parents ./.data/prosody/logs
mkdir --parents ./.data/prosody/modules
mkdir --parents ./.data/prosody/data
mkdir --parents ./.data/letsencrypt