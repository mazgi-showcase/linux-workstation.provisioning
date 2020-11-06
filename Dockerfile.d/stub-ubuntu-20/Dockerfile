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
  # Install packages
  && apt-get install --assume-yes ca-certificates curl openssh-server python3 sudo\
  # 
  # Create a user for development who has the same UID and GID as you.
  && groupadd --force --gid ${GID} developer || true\
  && useradd --comment '' --create-home --gid users --groups developer --uid ${UID} developer\
  && echo '%users ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-users\
  && echo '%developer ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-developer

# Reset DEBIAN_FRONTEND to default(`dialog`).
# If you no need `dialog`, you can set `DEBIAN_FRONTEND=readline`.
# see also: man 7 debconf
ENV DEBIAN_FRONTEND=

COPY rootfs /
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.start-services.zsh" ]
