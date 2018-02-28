#!/bin/bash

export PORT=5103

cd ~/www/tracker1
./bin/tracker2 stop || true
./bin/tracker2 start
