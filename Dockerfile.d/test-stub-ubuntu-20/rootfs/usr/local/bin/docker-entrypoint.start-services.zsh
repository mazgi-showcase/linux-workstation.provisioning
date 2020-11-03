#!/usr/bin/env -S bash -eu
sudo service ssh start
exec "$@"
