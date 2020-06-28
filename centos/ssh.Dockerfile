FROM centos:8
LABEL maintainer="xxy1991"
ENV container=docker

RUN dnf -y -q upgrade && \
    dnf -y -q --setopt=tsflags=nodocs install \
    openssh-server passwd && \
    dnf clean all

RUN mkdir /var/run/sshd
RUN echo 'root:Test123!' | chpasswd
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
