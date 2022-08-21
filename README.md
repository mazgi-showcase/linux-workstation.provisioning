# linux-workstation.provisioning

[![default](https://github.com/mazgi/linux-workstation.provisioning/actions/workflows/default.yml/badge.svg)](https://github.com/mazgi/linux-workstation.provisioning/actions/workflows/default.yml)

## Prepare

1. Set the hostname
   - `hostnamectl set-hostname NEW_HOSTNAME`
1. `ssh-keygen`

## How to run

1st, you should get up the provisioning service via docker compose and hold the terminal for the service.
Or, you are able to use the option `-d` or `--detach` with that up.

```console
docker compose up --detach && docker compose logs --follow
^c
```

Now, in another terminal, you are able to access the provisioning container via `docker compose exec` command.

```console
docker compose exec provisioning zsh -l
```

Next, I recommend exporting several environment variables to access your new Mac from the provisioning service easily.

```console
export TARGET_HOSTNAME=YOUR_VALUE
export TARGET_OS_USER=YOUR_VALUE
```

## Create the inventory

You are able to resolve the FQDN as has suffix `.local` via the `dig @224.0.0.251 -p 5353` command if you are using an OS that is enabled mDNS services, such as Bonjour, or Avahi.  
In this case, the DNS server `224.0.0.251` is a unique fixed IP address for mDNS and the correct IP address in all environments.

```console
docker compose exec provisioning ansible -m raw -a hostname -i $(dig +short @224.0.0.251 -p 5353 ${TARGET_HOSTNAME}.local), -u ${TARGET_OS_USER} all
192.168.1.1 | CHANGED | rc=0 >>
YOUR_HOSTNAME.local
Warning: Permanently added '192.168.1.1' (ECDSA) to the list of known hosts.
Connection to 192.168.1.1 closed.
```

```console
docker compose exec provisioning ansible -m gather_facts -i $(dig +short @224.0.0.251 -p 5353 ${TARGET_HOSTNAME}.local), -u ${TARGET_OS_USER} all
docker compose exec provisioning ansible -m gather_facts -a "filter=ansible_machine" -i $(dig +short @224.0.0.251 -p 5353 ${TARGET_HOSTNAME}.local), -u ${TARGET_OS_USER} all
docker compose exec provisioning ansible -m gather_facts -a "filter=ansible_default_ipv4.address" -i $(dig +short @224.0.0.251 -p 5353 ${TARGET_HOSTNAME}.local), -u ${TARGET_OS_USER} all
```

You are able to create the inventory file like follows.

```console
echo "[all]\n$(dig +short @224.0.0.251 -p 5353 ${TARGET_HOSTNAME}.local)\tansible_user=${TARGET_OS_USER}" | tee config/production/inventory/hosts
[all]
192.168.1.1   ansible_user=user
```

Now, you are able to run the command more sinmply.

```console
docker compose exec provisioning ansible -m raw -a hostname all
192.168.1.1 | CHANGED | rc=0 >>
YOUR_HOSTNAME.local
Warning: Permanently added '192.168.1.1' (ECDSA) to the list of known hosts.
Connection to 192.168.1.1 closed.
```

## Prepare role

- Create the user: `user`

```console
docker compose exec provisioning ansible-playbook --ask-become-pass site.linux-prepare.yml
docker compose exec provisioning ansible-playbook --ask-become-pass site.linux-prepare.yml --inventory YOUR_UBUNTU_HOST, --user ubuntu
```

## Site

```console
docker compose exec provisioning ansible-playbook --ask-become-pass site.yml
```
