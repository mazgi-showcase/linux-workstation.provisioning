#!/usr/bin/env -S bash -eu

ansible-playbook site.yml
ansible --module-name shell --args 'touch /tmp/done' all
