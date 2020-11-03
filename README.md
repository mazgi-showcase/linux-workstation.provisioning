# workstation.provisioning

[![default](https://github.com/mazgi/workstation.provisioning/workflows/default/badge.svg)](https://github.com/mazgi/workstation.provisioning/actions?query=workflow%3Adefault)

## How to set up

You need create the `.env` file as follows.

```shellsession
rm -f .env
test $(uname -s) = 'Linux' && echo "UID=$(id -u)\nGID=$(id -g)" >> .env
cat<<EOE > .env
CURRENT_ENV_NAME=production
EOE
```

You need create the `config/production/inventory/hosts.yml` file like follows.

```yaml
all:
  children:
    workstations:
      hosts:
        your-host-1.local:
          ansible_user: mazgi
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

## Links

- https://docs.ansible.com/ansible/latest/reference_appendices/config.html#the-configuration-file
