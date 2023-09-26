#!/bin/bash

set +e

source /usr/local/rvm/scripts/rvm && rvm use 3.2.2 --default

ruby /app/lich-5/lich.rbw
