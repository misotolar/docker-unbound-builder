FROM misotolar/backport-builder:latest

LABEL org.opencontainers.image.url="https://github.com/misotolar/docker-unbound-builder"
LABEL org.opencontainers.image.description="Unbound backport build container"
LABEL org.opencontainers.image.authors="Michal Sotolar <michal@sotolar.com>"

ENV UNBOUND_VERSION=1.24.1
ARG UNBOUND_RELEASE=2
ARG UNBOUND_SHA256=3cfff6836f4bc26f00091db85eb4af50d79081c41dcd9d5f095cdc88b2acf3a6
ADD https://salsa.debian.org/dns-team/unbound/-/archive/debian/$UNBOUND_VERSION-$UNBOUND_RELEASE/unbound-debian-$UNBOUND_VERSION-$UNBOUND_RELEASE.tar.gz /tmp/unbound.tar.gz

ARG RELEASE=1

WORKDIR /build/unbound

RUN set -ex; \
    apt-get update -y; \
    apt-get build-dep -y \
        unbound \
    ; \
    echo "$UNBOUND_SHA256 */tmp/unbound.tar.gz" | sha256sum -c -; \
    tar xf /tmp/unbound.tar.gz --strip-components=1; \
    dch -v $UNBOUND_VERSION-$UNBOUND_RELEASE+misotolar$RELEASE "Backport $UNBOUND_VERSION-$UNBOUND_RELEASE release"; \
    dch -r "" -D trixie; \
    rm -rf \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /tmp/*
