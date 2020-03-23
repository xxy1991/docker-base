FROM ubuntu:bionic

VOLUME ["/var/cache/apt-cacher-ng"]
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive \
    apt-get -yqq install apt-cacher-ng

RUN echo 'PassThroughPattern: ^(.*):443$' \
    >> /etc/apt-cacher-ng/acng.conf

EXPOSE 3142
CMD chmod 777 /var/cache/apt-cacher-ng && \
    /etc/init.d/apt-cacher-ng start && \
    tail -f /var/log/apt-cacher-ng/*
