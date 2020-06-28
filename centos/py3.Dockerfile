FROM xxy1991/centos:ssh
LABEL maintainer="xxy1991"
ENV container=docker

RUN dnf -y -q upgrade && \
    dnf -y -q --setopt=tsflags=nodocs install \
    epel-release && \
    dnf clean all

RUN dnf -y -q upgrade && \
    dnf -y -q --setopt=tsflags=nodocs install \
    python3 && \
    dnf clean all
