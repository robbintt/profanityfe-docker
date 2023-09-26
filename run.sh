#!/bin/bash

LICH_DATA_HOST_PATH="$HOME/.local/share/lich/data"
PROFANITY_DATA_HOST_PATH="$HOME/.local/share/profanity"

mkdir -p $LICH_DATA_HOST_PATH
mkdir -p $PROFANITY_DATA_HOST_PATH

# port order is machine:machine_port:container_port
# 8000 may be internal only, can probably remove
#  -p 127.0.0.1:8000:8000/tcp \
# .x11-unix used for login.sh
docker run \
  --name profanityfe \
  --rm \
  -p 127.0.0.1:11024:11024/tcp \
  -e "NO_AT_BRIDGE=1" \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $LICH_DATA_HOST_PATH:/app/lich-5/data \
  -v $PROFANITY_DATA_HOST_PATH:/root/.profanity \
  profanityfe \
  "./entrypoint.sh"
#  "./lichlauncher.sh"
#  "./login.sh"
