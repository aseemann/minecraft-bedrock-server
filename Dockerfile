FROM ubuntu:22.04

ARG VERSION

## Replace default mirror server to a german server to speed up the build
RUN sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//http:\/\/ftp.fau.de\/ubuntu\//' /etc/apt/sources.list

## Update packages
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y

## install required packages
RUN apt-get install -y curl wget openssl unzip zip libssl3 libssl-dev

## Cleanup dist
RUN apt-get autoremove -y && apt-get autoclean -y

## create workdir
RUN mkdir -p /mojang/bedrock/server

WORKDIR /mojang/bedrock/server

## COPY Files
COPY rootfs/ /

RUN chmod +x /entrypoint.sh

EXPOSE 19132
EXPOSE 19133

CMD ["/entrypoint.sh"]
