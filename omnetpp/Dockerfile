#
# Copyright (C) OpenSim Kft.
#
# SPDX-License-Identifier: MIT
#

FROM ubuntu:24.04 as base
LABEL maintainer="Rudolf Hornig <rudi@omnetpp.org>"

# first stage - build omnet
FROM base as builder
ARG VERSION
SHELL ["/bin/bash", "-c"]

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends git wget curl ca-certificates \
    && apt-get clean

WORKDIR /root
RUN wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-$VERSION/omnetpp-$VERSION-core.tgz \
         --referer=https://omnetpp.org/ -O omnetpp-core.tgz --progress=dot:giga && \
         tar xf omnetpp-core.tgz && rm omnetpp-core.tgz
RUN mv omnetpp-$VERSION omnetpp
WORKDIR /root/omnetpp
# remove unused files and build
RUN ./install.sh -y --no-gui && \
    rm -r doc out test samples misc config.log config.status

# second stage - copy only the final binaries (to get rid of the 'out' folder and reduce the image size)
FROM base
ARG VERSION
ENV OPP_VER=$VERSION
RUN mkdir -p /root/omnetpp
WORKDIR /root/omnetpp
COPY --from=builder /root/omnetpp/ .
RUN chmod 775 /root/ && \
    mkdir -p /root/models && \
    chmod 775 /root/models
WORKDIR /root/models
ENV HOME=/root/
RUN echo 'PS1="omnetpp-$VERSION:\w\$ "' >> /root/.bashrc && \
    echo '[ -f "$HOME/omnetpp/setenv" ] && source "$HOME/omnetpp/setenv" -f' >> /root/.bashrc && \
    touch /root/.hushlogin
CMD ["/bin/bash", "--init-file", "/root/.bashrc"]
