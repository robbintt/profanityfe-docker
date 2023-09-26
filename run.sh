#!/bin/bash

# order is machine:machine_port:container_port
docker run \
  --name profanityfe \
  --rm \
  -p 127.0.0.1:8000:8000/tcp \
  -p 127.0.0.1:11024:11024/tcp \
  -e "NO_AT_BRIDGE=1" \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix profanityfe \
  "./login.sh"
#  "./entrypoint.sh"
