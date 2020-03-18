FROM centos:7

RUN yum -y -q update && \
    yum -y -q --setopt=tsflags=nodocs install \
    openssh-server passwd && \
    yum clean all

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
