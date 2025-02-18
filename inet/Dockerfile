#
# Copyright (C) OpenSim Kft.
#
# SPDX-License-Identifier: MIT
#

FROM ghcr.io/omnetpp/omnetpp:u22.04-6.0 as base
LABEL maintainer="Rudolf Hornig <rudi@omnetpp.org>"

# first stage - build inet
FROM base as builder
ARG VERSION=4.4.1
WORKDIR /root
RUN wget https://github.com/inet-framework/inet/releases/download/v$VERSION/inet-$VERSION-src.tgz \
         --referer=https://omnetpp.org/ -O inet-src.tgz --progress=dot:mega && \
         tar xf inet-src.tgz && rm inet-src.tgz
WORKDIR /root/omnetpp
RUN . ./setenv && cd ../inet4.4 && . ./setenv && \
    make makefiles && \
    make -j $(nproc) MODE=release && \
    rm -rf out

# second stage - copy only the final binaries (to get rid of the 'out' folder and reduce the image size)
FROM base
RUN mkdir -p /root/inet4.4
WORKDIR /root/inet4.4
COPY --from=builder /root/inet4.4/ .
ARG VERSION=4.4.1
ENV INET_VER=$VERSION
RUN echo 'PS1="inet-$INET_VER:\w\$ "' >> /root/.bashrc && \
    echo '[ -f "$HOME/omnetpp/setenv" ] && source "$HOME/omnetpp/setenv" -f' >> /root/.bashrc && \
    echo '[ -f "$HOME/inet4.4/setenv" ] && source "$HOME/inet4.4/setenv" -f' >> /root/.bashrc && \
    touch /root/.hushlogin