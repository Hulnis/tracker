#!/bin/bash

export PORT=5103
export MIX_ENV=prod
export GIT_PATH=/home/tracker1/src/tracker

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "tracker1" ]; then
	echo "Error: must run as user 'tracker'"
	echo "  Current user is $USER"
	exit 2
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
# mix ecto.create
mix ecto.migrate
mix phx.digest
mix release --env=prod

# PORT=5103 MIX_ENV=prod elixir --detached -S mix phx.server

mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/tracker1 ]; then
	echo mv ~/www/tracker1 ~/old/$NOW
	mv ~/www/tracker1 ~/old/$NOW
fi

mkdir -p ~/www/tracker1
REL_TAR=~/src/tracker/_build/prod/rel/tracker2/releases/0.0.1/tracker2.tar.gz
(cd ~/www/tracker1 && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/tracker/src/tracker/start.sh
CRONTAB

. start.sh
