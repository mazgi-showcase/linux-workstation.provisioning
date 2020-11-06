# workstation.provisioning

[![default](https://github.com/mazgi/workstation.provisioning/workflows/default/badge.svg)](https://github.com/mazgi/workstation.provisioning/actions?query=workflow%3Adefault)

## How to set up

You need create the `.env` file as follows.

```shellsession
rm -f .env
test $(uname -s) = 'Linux' && echo "UID=$(id -u)\nGID=$(id -g)" >> .env
cat<<EOE >> .env
CURRENT_ENV_NAME=production
DOCKER_GID=$(getent group docker | cut -d : -f 3)
EOE
```

You need create the `config/production/inventory/hosts.yml` file like follows.

```yaml
all:
  children:
    workstations:
      children:
        managedByAd:
          vars:
            ansible_user: hidenori.matsuki
          hosts:
            your-mac.local:
        unmanaged:
          vars:
            ansible_user: mazgi
          hosts:
            octomore.local:
```

## How to run

Now you can make provisioning as follows.

```shellsession
docker-compose up
```

```shellsession
docker-compose run provisioning ansible --module-name ping all
docker-compose run provisioning ansible-playbook --ask-become-pass site.yml
```

## How to test

```shellsession
docker-compose --env-file .test.env build
```

```shellsession
docker-compose --env-file .test.env up
docker-compose --env-file .test.env run provisioning ansible-playbook site.yml
```

```shellsession
docker-compose --env-file .test.env down -v
```

## Links

- https://docs.ansible.com/ansible/latest/reference_appendices/config.html#the-configuration-file
