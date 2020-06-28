FROM debian:buster
LABEL maintainer="xxy1991"
ENV container=docker

ENV pip_packages "ansible cryptography"

# Install dependencies.
COPY app/apt-cacher.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/apt-cacher.sh && apt-cacher.sh

RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive \
    apt-get -yqq --no-install-recommends install \
            sudo systemd systemd-cron \
            build-essential libffi-dev libssl-dev \
            python3-pip python3-dev python3-setuptools python3-wheel && \
    rm -rf /var/lib/apt/lists/* && \
    rm -Rf /usr/share/doc && rm -Rf /usr/share/man && \
    rm -f /etc/apt/apt.conf

# Install Ansible via pip.
RUN pip3 install $pip_packages

COPY ansible/initctl_faker .
RUN chmod +x initctl_faker && rm -fr /sbin/initctl && ln -s /initctl_faker /sbin/initctl

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
ENTRYPOINT ["/usr/local/bin/apt-cacher.sh"]
CMD ["/lib/systemd/systemd"]
