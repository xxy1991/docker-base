FROM ubuntu:focal
LABEL maintainer="xxy1991"
ENV container=docker

ENV pip_packages "ansible"

# Install dependencies.
COPY app/apt-cacher.sh ./
RUN sh apt-cacher.sh && rm apt-cacher.sh

RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive \
    apt-get -yqq --no-install-recommends install \
            apt-utils systemd systemd-cron sudo \
            python3-pip python3-setuptools \
            software-properties-common rsyslog && \
    rm -rf /var/lib/apt/lists/* && \
    rm -Rf /usr/share/doc && rm -Rf /usr/share/man && \
    rm -f /etc/apt/apt.conf

RUN sed -i 's/^\($ModLoad imklog\)/#\1/' /etc/rsyslog.conf

# Install Ansible via Pip.
RUN pip3 install $pip_packages

COPY ansible/initctl_faker .
RUN chmod +x initctl_faker && rm -fr /sbin/initctl && ln -s /initctl_faker /sbin/initctl

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/lib/systemd/systemd"]
