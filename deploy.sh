export PORT=5114
export MIX_ENV=prod
export GIT_PATH=/home/crypto/src/crypto
PWD = `pwd`
mix deps.get
(cd assets && npm install --unsafe-perm)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
MIX_ENV=prod mix ecto.create
MIX_ENV=prod mix ecto.migrate
MIX_ENV=prod mix run priv/repo/seeds.exs
mix release.init
MIX_ENV=prod mix release 
mkdir -p ~/wwww
mkdir -p ~/oldd

NOW=`date +%s`
if [ -d ~/www/crypto ]; then
	echo mv ~/wwww/crypto ~/oldd/$NOW
	mv ~/wwww/crypto ~/oldd/$NOW
fi

mkdir -p ~/wwww/crypto
REL_TAR=~/src/crypto/_build/prod/rel/crypto/releases/0.0.1/crypto.tar.gz
(cd ~/wwww/crypto && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/crypto/src/crypto/start.sh
CRONTAB
