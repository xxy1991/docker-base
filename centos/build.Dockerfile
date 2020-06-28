FROM centos:8
LABEL maintainer="xxy1991"
ENV container=docker

RUN dnf -y -q upgrade && \
    dnf -y -q --setopt=tsflags=nodocs \
    groupinstall 'Development Tools' && \
    dnf -y -q --setopt=tsflags=nodocs \
    install git \
            curl && \
    dnf clean all
