#!/bin/bash

export PORT=5102
export MIX_ENV=prod
export GIT_PATH=/home/tracker/src/tracker


mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
# mix ecto.create
mix ecto.migrate
mix phx.digest
# mix release --env=prod

PORT=5104 MIX_ENV=prod elixir --detached -S mix phx.server

# mkdir -p ~/www
# mkdir -p ~/old
#
# NOW=`date +%s`
# if [ -d ~/www/tracker ]; then
# 	echo mv ~/www/tracker ~/old/$NOW
# 	mv ~/www/tracker ~/old/$NOW
# fi
#
# mkdir -p ~/www/tracker
# REL_TAR=~/src/tracker/_build/prod/rel/tracker/releases/0.0.1/tracker.tar.gz
# (cd ~/www/tracker && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/tracker/src/tracker/start.sh
CRONTAB

#. start.sh
