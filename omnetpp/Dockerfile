#
# Copyright (C) OpenSim Kft.
#
# SPDX-License-Identifier: MIT
#

FROM ubuntu:24.04
LABEL maintainer="Rudolf Hornig <rudi@omnetpp.org>"

ARG VERSION
ENV OPP_VER=$VERSION
ENV HOME=/root/
SHELL ["/bin/bash", "-c"]

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends git wget curl ca-certificates && \
    apt-get clean && \
    cd /root && \
    wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-$VERSION/omnetpp-$VERSION-core.tgz \
         --referer=https://omnetpp.org/ -O omnetpp-core.tgz --progress=dot:giga && \
         tar xf omnetpp-core.tgz && rm omnetpp-core.tgz && mv omnetpp-$VERSION omnetpp && \
    cd /root/omnetpp && \
    ./install.sh -y --no-gui && \
    rm -r doc out test samples misc config.log config.status && \
    chmod 775 /root/ && mkdir -p /root/models && chmod 775 /root/models && \
    echo 'PS1="omnetpp-$VERSION:\w\$ "' >> /root/.bashrc && \
    echo '[ -f "$HOME/omnetpp/setenv" ] && source "$HOME/omnetpp/setenv" -f' >> /root/.bashrc && \
    touch /root/.hushlogin
WORKDIR /root/models
CMD ["/bin/bash", "--init-file", "/root/.bashrc"]
