FROM alpine:latest

RUN apk --no-cache add \
        openjdk11-jdk && \
    rm -rf /var/cache/apk/*
