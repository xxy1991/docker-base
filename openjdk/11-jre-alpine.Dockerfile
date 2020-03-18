FROM alpine:latest

RUN apk update \
    && apk upgrade \
    && apk --no-cache add \
        openjdk11-jre && \
    rm -rf /var/cache/apk/*
