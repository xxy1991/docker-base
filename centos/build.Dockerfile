FROM centos:7

RUN yum -y -q update && \
    yum -y -q --setopt=tsflags=nodocs \
    groupinstall 'Development Tools' && \
    yum -y -q --setopt=tsflags=nodocs \
    install git \
            curl && \
    yum clean all
