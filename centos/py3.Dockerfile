FROM xxy1991/centos:ssh

RUN yum -y -q update && \
    yum -y -q --setopt=tsflags=nodocs install \
    epel-release && \
    yum clean all

RUN yum -y -q update && \
    yum -y -q --setopt=tsflags=nodocs install \
    python36-pip && \
    yum clean all
