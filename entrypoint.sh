#!/bin/bash

set +e

CHAR="Artiglas"

ruby /app/lich-5/lich.rbw --login $CHAR --without-frontend --dragonrealms --detachable-client=8000 &

$(exit 1)
until /app/profanityfe/profanity.rb --port=8000 --char=$CHAR 2> /dev/null ;do
  printf "."
  sleep 1
done
