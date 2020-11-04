FROM xxy1991/alpine:glibc

COPY jdk-6u45-linux-x64.bin /usr/local/jdk1.6.0_45.bin
WORKDIR /usr/local
ENV JAVA_VERSION="1.6.0_45" \
    JAVA_HOME="/usr/local/jdk1.6.0_45" \
    JRE_HOME="/usr/local/jdk1.6.0_45/jre" \
    PATH="${PATH}:/usr/local/jdk1.6.0_45/bin"
RUN chmod u+x jdk1.6.0_45.bin && \
    yes | ./jdk1.6.0_45.bin && \
    rm -rf /usr/local/jdk1.6.0_45.bin