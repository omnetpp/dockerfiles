FROM ghcr.io/omnetpp/omnetpp-base:u22.04-1 as base

LABEL maintainer="Rudolf Hornig <rudi@omnetpp.org>"


RUN apt-get update -y && apt-get install -y --no-install-recommends qtbase5-dev qtchooser\
                          qt5-qmake qtbase5-dev-tools libqt5opengl5-dev libwebkit2gtk-4.0-37

# first stage - build OMNeT++ with GUI
FROM base as builder

ARG VERSION
WORKDIR /root
RUN wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-$VERSION/omnetpp-$VERSION-linux-x86_64.tgz \
         --referer=https://omnetpp.org/ -O omnetpp-core.tgz --progress=dot:giga && \
         tar xf omnetpp-core.tgz && rm omnetpp-core.tgz

RUN mv omnetpp-$VERSION omnetpp
WORKDIR /root/omnetpp
ENV PATH /root/omnetpp/bin:$PATH
# remove unused files and build
RUN . ./setenv && \
    ./configure WITH_LIBXML=yes WITH_OSG=no WITH_OSGEARTH=no && \
    make -j $(nproc) MODE=release base && \
    rm -r doc out test samples misc config.log config.status

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
