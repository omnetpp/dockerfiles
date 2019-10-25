FROM ubuntu:18.04
MAINTAINER Rudolf Hornig <rudi@omnetpp.org>

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends git wget curl make ca-certificates bison flex clang perl python3 libxml2-dev && \
    apt-get clean && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1 && \
    rm -rf /var/lib/apt/lists/*
