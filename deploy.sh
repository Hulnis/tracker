#!/bin/bash

export PORT=5102
export MIX_ENV=prod
export GIT_PATH=/home/tracker/src/tracker

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "tracker" ]; then
	echo "Error: must run as user 'tracker'"
	echo "  Current user is $USER"
	exit 2
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
~/src/tracker$ MIX_ENV=prod mix ecto.create
~/src/tracker$ MIX_ENV=prod mix ecto.migrate
mix phx.digest
mix release --env=prod

mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/tracker ]; then
	echo mv ~/www/tracker ~/old/$NOW
	mv ~/www/tracker ~/old/$NOW
fi

mkdir -p ~/www/tracker
REL_TAR=~/src/tracker/_build/prod/rel/tracker/releases/0.0.1/tracker.tar.gz
(cd ~/www/tracker && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/tracker/src/tracker/start.sh
CRONTAB

#. start.sh
