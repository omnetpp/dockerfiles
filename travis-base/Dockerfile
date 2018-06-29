FROM omnetpp/cross-compilers:ubuntu18.04-macos11-180611

RUN apt-get update && apt-get install -y --no-install-recommends wget ca-certificates bison flex

WORKDIR /root

RUN wget https://www.omnetpp.org/omnetpp/send/30-omnet-releases/2329-omnetpp-5-4-1-core \
        --referer=https://omnetpp.org/omnetpp -O omnetpp-5.4.1-src-core.tgz --progress=dot:giga && \
    tar xf omnetpp-5.4.1-src-core.tgz && rm omnetpp-5.4.1-src-core.tgz

WORKDIR /root/omnetpp-5.4.1

# these are optional now, and we don't need them
RUN rm -rf samples

WORKDIR /root

RUN cp -r omnetpp-5.4.1 omnetpp-5.4.1-macosx && \
    cp -r omnetpp-5.4.1 omnetpp-5.4.1-windows && \
    mv omnetpp-5.4.1 omnetpp-5.4.1-linux

#### building the linux version

WORKDIR omnetpp-5.4.1-linux

ENV PATH /root/omnetpp-5.4.1-linux/bin:$PATH
RUN ./configure WITH_TKENV=no WITH_QTENV=no WITH_OSG=no WITH_OSGEARTH=no
RUN make -j $(nproc)


#### building the mac version using some linux tools

WORKDIR /root/omnetpp-5.4.1-macosx

ENV PATH /root/omnetpp-5.4.1-macosx/bin:$PATH
RUN ./configure WITH_TKENV=no WITH_QTENV=no WITH_OSG=no WITH_OSGEARTH=no --host="x86_64-apple-darwin15" \
        CXX="x86_64-apple-darwin15-clang++-libc++" CC="x86_64-apple-darwin15-clang" \
        MSGC="/root/omnetpp-5.4.1-linux/bin/opp_msgc" NEDTOOL="/root/omnetpp-5.4.1-linux/bin/nedtool"
RUN make -j $(nproc)


#### building the windows version using some linux tools

WORKDIR /root/omnetpp-5.4.1-windows

ENV PATH /root/omnetpp-5.4.1-windows/bin:$PATH
RUN ./configure WITH_TKENV=no WITH_QTENV=no WITH_OSG=no WITH_OSGEARTH=no --host=x86_64-w64-mingw32 \
        MSGC="/root/omnetpp-5.4.1-linux/bin/opp_msgc" NEDTOOL="/root/omnetpp-5.4.1-linux/bin/nedtool"
RUN make -j $(nproc)

# switch back to using the linux tools
ENV PATH /root/omnetpp-5.4.1-linux/bin:$PATH

WORKDIR /root

