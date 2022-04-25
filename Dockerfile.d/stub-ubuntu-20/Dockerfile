FROM ubuntu:20.04

# Set in non-interactive mode.
ENV DEBIAN_FRONTEND=noninteractive

ARG GID=0
ENV GID=${GID:-0}
ARG UID=0
ENV UID=${UID:-0}

RUN echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends\
  && apt-get update\
  # 
  # Set up locales
  && apt-get install --assume-yes locales procps dialog\
  && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen\
  && locale-gen\
  # 
  # Install basic packages
  && apt-get install --assume-yes\
  apt-utils curl dnsutils git jq openssh-client sudo tmux unzip vim zsh\
  build-essential\
  iputils-ping netcat\
  apt-transport-https ca-certificates curl gnupg gnupg2 rsync software-properties-common\
  avahi-utils libnss-mdns\
  openssh-server\
  libffi-dev\
  python3-pip python3-setuptools\
  python3-dev libssl-dev\
  && :
RUN : APT Repository [Docker]\
  # See https://docs.docker.com/engine/install/ubuntu/
  && curl --fail --silent --show-error --location https://download.docker.com/linux/ubuntu/gpg\
  | gpg --no-default-keyring --keyring /usr/share/keyrings/docker-archive-keyring.gpg --import -\
  && echo\
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"\
  | tee /etc/apt/sources.list.d/docker.list > /dev/null\
  && :
RUN : Install Packages from Added Repositories\
  && apt-get update\
  # Docker
  && apt-get install --assume-yes docker-ce docker-ce-cli containerd.io\
  && :
RUN :\
  # Create a user for development who has the same UID and GID as you.
  && groupadd --force --gid ${GID} developer || true\
  && useradd --comment '' --create-home --gid users --groups developer --uid ${UID} developer || true\
  && echo '%users ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-users\
  && echo '%developer ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-developer

# Reset DEBIAN_FRONTEND to default(`dialog`).
# If you no need `dialog`, you can set `DEBIAN_FRONTEND=readline`.
# see also: man 7 debconf
ENV DEBIAN_FRONTEND=

COPY rootfs /
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.start-services.zsh" ]
