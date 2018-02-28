#!/bin/bash

export PORT=5103

cd ~/www/tracker
./bin/tracker stop || true
./bin/tracker start
