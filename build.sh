#!/bin/bash

docker image build -f $HOME/code/profanityfe-docker/Dockerfile -t profanityfe --build-arg HOME_DIR=$HOME $HOME/code
