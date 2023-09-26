#!/bin/bash

set +e

CHAR="Artiglas"

source /usr/local/rvm/scripts/rvm
rvm use 3.2.2 --default

cp /app/profanityfe/mahtra.xml /root/.profanity.xml
cp /app/profanityfe/mahtra.xml /root/.profanity/artiglas.xml

cd /app && ./lichlauncher.sh &

sleep 5
cd /app/profanityfe/ && ./profanity.rb #--port=8000 --char=$CHAR

while true; do sleep 1; done
