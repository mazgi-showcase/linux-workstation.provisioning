FROM ghcr.io/mazgi/gentoo

ARG GID=0
ENV GID=${GID:-0}
ARG UID=0
ENV UID=${UID:-0}

# Sync the gentoo repository
RUN :\
  && emaint sync --repo gentoo\
  # Fall back
  || emerge-webrsync --quiet
# Install packages
RUN emerge -uNDvq --buildpkg --usepkg\
  app-admin/sudo\
  && :

RUN :\
  # Create a user for development who has the same UID and GID as you.
  && groupadd --force --gid ${GID} developer || true\
  && useradd --comment '' --create-home --gid users --groups developer --uid ${UID} developer || true\
  && echo '%users ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-users\
  && echo '%developer ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grant-all-without-password-to-developer

COPY rootfs /
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.start-services.zsh" ]
