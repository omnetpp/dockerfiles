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
ENV XDG_RUNTIME_DIR=/tmp/xdg-runtime-root
SHELL ["/bin/bash", "-c"]

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends git wget curl ca-certificates && \
    apt-get clean && \
    cd /root && \
    wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-$VERSION/omnetpp-$VERSION-linux-x86_64.tgz \
         --referer=https://omnetpp.org/ -O omnetpp.tgz --progress=dot:giga && \
         tar xf omnetpp.tgz && rm omnetpp.tgz && mv omnetpp-$VERSION omnetpp && \
    cd /root/omnetpp && \
    ./install.sh -y && \
    rm -r doc out test samples misc config.log config.status && \
    sed -i 's!-Dosgi.instance.area.default=$IDEDIR/../samples!-Duser.home=/root/models -Dosgi.instance.area=@user.home!' bin/opp_ide src/utils/opp_ide && \
    chmod 775 /root/ && mkdir -p /root/models && chmod 775 /root/models && \
    echo 'PS1="omnetpp-$VERSION:\w\$ "' >> /root/.bashrc && \
    echo '[ -f "$HOME/omnetpp/setenv" ] && source "$HOME/omnetpp/setenv" -f' >> /root/.bashrc && \
    touch /root/.hushlogin
WORKDIR /root/models
COPY --chmod=0555 ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash", "--init-file", "/root/.bashrc"]
