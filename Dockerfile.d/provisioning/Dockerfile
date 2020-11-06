FROM ghcr.io/mazgi/provisioning

# Set in non-interactive mode.
ENV DEBIAN_FRONTEND=noninteractive

RUN :\
  && apt-get install --assume-yes avahi-utils libnss-mdns

ARG DOCKER_GID
ENV DOCKER_GID=${DOCKER_GID}
ARG GID=0
ENV GID=${GID:-0}
ARG UID=0
ENV UID=${UID:-0}

RUN :\
  # Create a user for development who has the same UID and GID as you.
  && groupadd --force --gid ${GID} developer || true\
  && useradd --comment '' --create-home --gid users --groups developer --uid ${UID} developer\
  # Append docker group
  && bash -c "test -n \"${DOCKER_GID}\" && groupadd --gid ${DOCKER_GID} docker" || true\
  && usermod --append --groups docker developer 2> /dev/null || true\
  # Set sudo: (ALL) NOPASSWD: ALL
  && echo '%users ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-users\
  && echo '%developer ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-developer

# Reset DEBIAN_FRONTEND to default(`dialog`).
# If you no need `dialog`, you can set `DEBIAN_FRONTEND=readline`.
# see also: man 7 debconf
ENV DEBIAN_FRONTEND=

COPY rootfs /
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.start-services.zsh" ]
