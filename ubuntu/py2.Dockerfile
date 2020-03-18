FROM xxy1991/ubuntu:ssh

COPY app/apt-cacher.sh ./
RUN sh apt-cacher.sh && rm apt-cacher.sh

RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive \
    apt-get -yqq --no-install-recommends install \
            python-pip && \
    rm -f /etc/apt/apt.conf && \
    rm -Rf /usr/share/doc && rm -Rf /usr/share/man
