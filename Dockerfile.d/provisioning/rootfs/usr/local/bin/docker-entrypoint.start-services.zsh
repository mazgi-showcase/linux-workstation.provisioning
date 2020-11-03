#!/usr/bin/env -S zsh -eu
sudo service dbus start
sudo service avahi-daemon start
exec "$@"
