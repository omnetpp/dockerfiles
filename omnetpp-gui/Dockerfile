#!/usr/bin/env docker build --build-arg VERSION=5.6.2 -t omnetpp/omnetpp-gui:u18.04-5.6.2 .
#

FROM omnetpp/omnetpp-base:u18.04 as base
LABEL maintainer="Rudolf Hornig <rudi@omnetpp.org>"
RUN apt-get update -y && apt-get install -y --no-install-recommends qt5-default libqt5opengl5-dev \
            libgtk-3-0 libwebkitgtk-3.0-0 default-jre gcc g++ gdb

# first stage - build OMNeT++ with GUI
FROM base as builder

ARG VERSION
WORKDIR /root
RUN wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-$VERSION/omnetpp-$VERSION-src-linux.tgz \
         --referer=https://omnetpp.org/ -O omnetpp-src-linux.tgz --progress=dot:giga && \
         tar xf omnetpp-src-linux.tgz && rm omnetpp-src-linux.tgz
RUN mv omnetpp-$VERSION omnetpp
WORKDIR /root/omnetpp
ENV PATH /root/omnetpp/bin:$PATH
# remove unused files and build
RUN ./configure WITH_OSG=no WITH_OSGEARTH=no && \
    make -j $(nproc) MODE=debug base && make -j $(nproc) MODE=release base && \
    rm -r doc out test samples config.log config.status

# second stage - copy only the final binaries (to get rid of the 'out' folder and reduce the image size)
FROM base

ARG VERSION
ENV OPP_VER=$VERSION
RUN mkdir -p /root/omnetpp
WORKDIR /root/omnetpp
COPY --from=builder /root/omnetpp/ .
ENV PATH /root/omnetpp/bin:$PATH
RUN chmod 775 /root/ && \
    mkdir -p /root/models && \
    chmod 775 /root/models && \
    touch ide/error.log && chmod 666 ide/error.log && \
    rm -f bin/omnest && \
    mv bin/omnetpp bin/omnetpp.bak && \
    sed 's!-Dosgi.instance.area.default=$IDEDIR/../samples!-Duser.home=/root/models -Dosgi.instance.area=@user.home!' bin/omnetpp.bak >bin/omnetpp && \
    rm bin/omnetpp.bak && chmod +x bin/omnetpp
WORKDIR /root/models
RUN echo 'PS1="omnetpp-gui-$OPP_VER:\w\$ "' >> /root/.bashrc && chmod +x /root/.bashrc && \
    touch /root/.hushlogin
ENV HOME=/root/
ENV XDG_RUNTIME_DIR=/tmp/xdg-runtime-root
CMD ["/bin/bash", "--init-file", "/root/.bashrc"]
