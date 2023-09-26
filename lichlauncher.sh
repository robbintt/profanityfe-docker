#!/bin/bash

set +e

CHAR="Artiglas"

source /usr/local/rvm/scripts/rvm
rvm use 3.2.2 --default

bundle config set --local path /usr/local/bundle

cd /app/lich-5 && bundle exec ruby lich.rbw --login $CHAR --without-frontend --dragonrealms --detachable-client=8000
