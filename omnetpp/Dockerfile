FROM omnetpp/omnetpp-base:u18.04 as base
MAINTAINER Rudolf Hornig <rudi@omnetpp.org>

# first stage - build omnet
FROM base as builder
ARG VERSION=3.3
WORKDIR /root
RUN wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-$VERSION-ubuntu18.04/omnetpp-$VERSION-src-gcc73.tgz \
         --referer=https://omnetpp.org/ -O omnetpp-src-core.tgz --progress=dot:giga && \
         tar xf omnetpp-src-core.tgz && rm omnetpp-src-core.tgz
RUN mv omnetpp-omnetpp-$VERSION-ubuntu18.04 omnetpp
WORKDIR /root/omnetpp
ENV PATH /root/omnetpp/bin:$PATH
# remove unused files and build
RUN sed -i "/#  NO_TCL=true/c\NO_TCL=true" configure.user; \
    ./configure && make libs progs MODE=release && \
    find src -name '*.o' -o -name '*.so' | xargs rm && \
    rm -r config.log config.status

# second stage - copy only the final binaries (to get rid of the 'out' folder and reduce the image size)
FROM base
ARG VERSION=3.3
ENV OPP_VER=$VERSION
RUN mkdir -p /root/omnetpp
WORKDIR /root/omnetpp
COPY --from=builder /root/omnetpp/ .
ENV PATH /root/omnetpp/bin:$PATH
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/omnetpp/lib
RUN chmod 775 /root/ && \
    mkdir -p /root/models && \
    chmod 775 /root/models
WORKDIR /root/models
RUN echo 'PS1="omnetpp-$OPP_VER:\w\$ " ; echo "Note that Tkenv is not available in the container so you must create your Makefiles with > opp_makemake -u Cmdenv <"' >> /root/.bashrc && chmod +x /root/.bashrc && \
    touch /root/.hushlogin
ENV HOME=/root/
CMD /bin/bash --init-file /root/.bashrc