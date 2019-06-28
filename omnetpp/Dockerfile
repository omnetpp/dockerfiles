FROM omnetpp/omnetpp-base:u18.04 as base
MAINTAINER Rudolf Hornig <rudi@omnetpp.org>

# first stage - build omnet
FROM base as builder
ARG VERSION=4.6
WORKDIR /root
RUN wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-$VERSION/omnetpp-$VERSION-src.tgz \
         --referer=https://omnetpp.org/ -O omnetpp-src-core.tgz --progress=dot:giga && \
         tar xf omnetpp-src-core.tgz && rm omnetpp-src-core.tgz
RUN mv omnetpp-$VERSION omnetpp
WORKDIR /root/omnetpp
ENV PATH /root/omnetpp/bin:$PATH
# remove unused files and build
RUN sed -i "/#  NO_TCL=true/c\NO_TCL=true" configure.user && \
    ./configure  && \
    make -j $(nproc) MODE=release base && \
    rm -rf ide samples doc out config.log config.status

# second stage - copy only the final binaries (to get rid of the 'out' folder and reduce the image size)
FROM base
ARG VERSION=4.6
ENV OPP_VER=$VERSION
RUN mkdir -p /root/omnetpp
WORKDIR /root/omnetpp
COPY --from=builder /root/omnetpp/ .
ENV PATH /root/omnetpp/bin:$PATH
RUN chmod 775 /root/ && \
    mkdir -p /root/models && \
    chmod 775 /root/models
WORKDIR /root/models
RUN echo 'PS1="omnetpp-$OPP_VER:\w\$ " && echo "NOTE: Only release mode binaries are available so use > make MODE=release < for building."' >> /root/.bashrc && chmod +x /root/.bashrc && \
    touch /root/.hushlogin
ENV HOME=/root/
CMD /bin/bash --init-file /root/.bashrc