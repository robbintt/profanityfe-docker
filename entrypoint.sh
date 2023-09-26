#!/bin/bash

set +e

CHAR="Artiglas"

cp /app/profanityfe/mahtra.xml /root/.profanity.xml
cp /app/profanityfe/mahtra.xml /root/.profanity/artiglas.xml

/app/lichlauncher.sh &

sleep 3
/app/profanityfe/profanity.rb --port=8000 --char=$CHAR

while true; do sleep 1; done
