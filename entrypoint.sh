#!/bin/bash

set -e

if [[ -z "${BW_HOST}" || -z "${BW_CLIENTID}" || -z "${BW_CLIENTSECRET}" ]]; then
  echo "Please set 'BW_HOST', 'BW_CLIENTID', and 'BW_CLIENTSECRET' environment variable"
  exit 1
fi

bw config server ${BW_HOST}

bw login --apikey --raw

export BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw)

bw unlock --check

echo 'Running `bw server` on port 8087'
bw serve --hostname 0.0.0.0 #--disable-origin-protection
