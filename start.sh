#!/bin/bash

export PORT=5103

cd ~/www/tracker1
./bin/tracker stop || true
./bin/tracker start
