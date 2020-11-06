#!/usr/bin/env -S bash -eu

SSH_HOST_RSA_KEY_PATH=/etc/ssh/ssh_host_rsa_key
if [[ ! -f ${SSH_HOST_RSA_KEY_PATH} ]]; then
	sudo ssh-keygen -f ${SSH_HOST_RSA_KEY_PATH} -N '' -q -t rsa
fi
sudo /usr/sbin/sshd

exec "$@"
