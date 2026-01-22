FROM misotolar/backport-builder:latest

LABEL org.opencontainers.image.url="https://github.com/misotolar/docker-unbound-builder"
LABEL org.opencontainers.image.description="Unbound backport build container"
LABEL org.opencontainers.image.authors="Michal Sotolar <michal@sotolar.com>"

ENV BACKPORT_PACKAGE=unbound
ENV BACKPORT_VERSION=1.24.2-1
ENV BACKPORT_RELEASE=msbpo13+1
