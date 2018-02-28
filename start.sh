#!/bin/bash

export PORT=5103

cd ~/www/tracker1
./bin/tracker1 stop || true
./bin/tracker1 start
