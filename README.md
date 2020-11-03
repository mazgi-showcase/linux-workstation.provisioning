# template.dockerized-provisioning-project

[![default](https://github.com/mazgi/template.dockerized-provisioning-project/workflows/default/badge.svg)](https://github.com/mazgi/template.dockerized-provisioning-project/actions?query=workflow%3Adefault)

## How to set up

You need one AWS account and one GCP project each of you can fully manage.  
And you need to get credentials after you set up system accounts for provisioning as described below.

### How to set up your AWS IAM user

You should create an AWS IAM user under the name `provisioning-admin` that attached follows permissions.

- `AdministratorAccess`

### How to set up your GCP service account

You should create a GCP service account under the name `provisioning-owner` that added follows roles.

- `Project Owner`
- `Storage Admin`

### How to set up your local environment

You need create the `.env` file as follows.

```shellsession
rm -f .env
test $(uname -s) = 'Linux' && echo "UID=$(id -u)\nGID=$(id -g)" >> .env
cat<<EOE > .env
AWS_ACCOUNT_ID=YOUR_AWS_ACCOUNT_ID
CLOUDSDK_CORE_PROJECT=YOUR_GCP_PROJECT_ID
CURRENT_ENV_NAME=production
PROJECT_UNIQUE_ID=YOUR_GCP_PROJECT_UNIZUE_ID
EOE
```

Place your credentials into `config/${CURRENT_ENV_NAME}/credentials/` directory.  
If you are using [1Password command-line tool](https://1password.com/downloads/command-line/), you can get credentials as follows from your 1Password vault.

```shellsession
eval $(op signin my)
source .env
op get document arn:aws:iam::${AWS_ACCOUNT_ID}:user/provisioning-admin > config/${CURRENT_ENV_NAME}/credentials/new_user_credentials.csv
op get document provisioning-owner@${CLOUDSDK_CORE_PROJECT}.iam.gserviceaccount.com > config/${CURRENT_ENV_NAME}/credentials/google-cloud-keyfile.json
```

You need update the `.env` file as follows.

```shellsession
source .env
echo "AWS_ACCESS_KEY_ID=$(tail -1 config/${CURRENT_ENV_NAME}/credentials/new_user_credentials.csv | cut -d, -f3)" >> .env
echo "AWS_SECRET_ACCESS_KEY=$(tail -1 config/${CURRENT_ENV_NAME}/credentials/new_user_credentials.csv | cut -d, -f4)" >> .env
```

## How to run

Now you can make provisioning as follows.

```shellsession
docker-compose up
docker-compose run provisioning terraform plan
```
