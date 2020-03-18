FROM alpine:latest

RUN apk --no-cache add \
        openjdk11-jre && \
    rm -rf /var/cache/apk/*
