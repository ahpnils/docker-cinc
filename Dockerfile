# Dockerfile vastly inspired by https://gitlab.com/cinc-project/upstream/chef/-/blob/c0b96b44f929a73be1555f9055927f460e74ee4f/Dockerfile

FROM busybox
LABEL maintainer="Nils Ratusznik <nils.github@anotherhomepage.org>"

ARG CHANNEL=stable
ARG VERSION=18.8.46
ARG PKG_VERSION=11
ARG TARGETPLATFORM

RUN set -euo pipefail; \
    case "$TARGETPLATFORM" in \
        linux/amd64) arch=amd64 ;; \
        linux/arm64) arch=arm64 ;; \
        *) echo "Unsupported TARGETPLATFORM: $TARGETPLATFORM" >&2; exit 1 ;; \
    esac; \
    mkdir -p /var/lib/dpkg/info && touch /var/lib/dpkg/status && \
    wget -q "http://ftp-osl.osuosl.org/pub/cinc/files/${CHANNEL}/cinc/${VERSION}/debian/${PKG_VERSION}/cinc_${VERSION}-1_${arch}.deb" -O /tmp/cinc-client.deb && \
    dpkg --unpack /tmp/cinc-client.deb

VOLUME [ "/opt/cinc" ]

