FROM omnetpp/omnetpp:u18.04-5.6 as base
MAINTAINER Rudolf Hornig <rudi@omnetpp.org>

# first stage - build inet
FROM base as builder
ARG VERSION=4.2.0
WORKDIR /root
RUN wget https://github.com/inet-framework/inet/releases/download/v$VERSION/inet-$VERSION-src.tgz \
         --referer=https://omnetpp.org/ -O inet-src.tgz --progress=dot:mega && \
         tar xf inet-src.tgz && rm inet-src.tgz
WORKDIR /root/inet4
RUN make makefiles && \
    make -j $(nproc) MODE=release && \
    rm -rf out

# second stage - copy only the final binaries (to get rid of the 'out' folder and reduce the image size)
FROM base
RUN mkdir -p /root/inet4
WORKDIR /root/inet4
COPY --from=builder /root/inet4/ .
ARG VERSION=4.2.0
ENV INET_VER=$VERSION
RUN echo 'PS1="inet-$INET_VER:\w\$ "' >> /root/.bashrc && chmod +x /root/.bashrc && \
    touch /root/.hushlogin