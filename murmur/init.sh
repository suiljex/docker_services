#!/usr/bin/env sh

SCRIPT_NAME=$0
SCRIPT_FULL_PATH=$(dirname "$0")

cd "$SCRIPT_FULL_PATH"
git clone https://github.com/goofball222/murmur

mkdir --parents ./.data/murmur/cert
mkdir --parents ./.data/murmur/config
mkdir --parents ./.data/murmur/data
mkdir --parents ./.data/murmur/log