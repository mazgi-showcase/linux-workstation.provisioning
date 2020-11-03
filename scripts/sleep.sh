#!/usr/bin/env -S bash -eu

while true
do
  test -f /project/tmp/done && break
  sleep 5
done
