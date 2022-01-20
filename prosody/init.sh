#!/usr/bin/env sh

SCRIPT_NAME=$0
SCRIPT_FULL_PATH=$(dirname "$0")

cd "$SCRIPT_FULL_PATH"
git clone https://github.com/prosody/prosody-docker

mkdir --parents ./.data/prosody/certs
mkdir --parents ./.data/prosody/logs
mkdir --parents ./.data/prosody/data
mkdir --parents ./.data/letsencrypt
mkdir --parents ./.data/prosody/modules/enabled

enable_module() {
   ln -s "../available/${1}" "${1}"
}

hg clone 'https://hg.prosody.im/prosody-modules/' ./.data/prosody/modules/available

cd "$SCRIPT_FULL_PATH"/.data/prosody/modules/enabled
enable_module mod_http_upload
enable_module mod_smacks
enable_module mod_vcard_muc
enable_module mod_bookmarks2
enable_module mod_cloud_notify