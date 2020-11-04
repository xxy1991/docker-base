FROM xxy1991/alpine:glibc

COPY jre-6u45-linux-x64.bin /usr/local/jre1.6.0_45.bin
WORKDIR /usr/local
ENV JAVA_VERSION="1.6.0_45" \
    JAVA_HOME="/usr/local/jre1.6.0_45" \
    JRE_HOME="/usr/local/jre1.6.0_45" \
    PATH="${PATH}:/usr/local/jre1.6.0_45/bin"
RUN chmod u+x jre1.6.0_45.bin && \
    yes | ./jre1.6.0_45.bin && \
    rm -rf /usr/local/jre1.6.0_45.bin