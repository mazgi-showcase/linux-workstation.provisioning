#!/usr/bin/env -S bash -eu

while true
do
  test -f /tmp/done && {
    echo "done."
    break
  }
  sleep 5
done
