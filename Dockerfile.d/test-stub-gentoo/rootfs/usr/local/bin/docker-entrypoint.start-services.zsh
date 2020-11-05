#!/usr/bin/env -S bash -eu
sudo rc-service sshd start
exec "$@"
