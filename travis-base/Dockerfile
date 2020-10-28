FROM omnetpp/cross-compilers:ubuntu20.04-macos10.15-200914

RUN apt-get update && apt-get install -y --no-install-recommends wget ca-certificates bison flex

WORKDIR /root

RUN wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-6.0pre9/omnetpp-6.0pre9-src-core.tgz \
         -O omnetpp-6.0pre9-src-core.tgz --progress=dot:giga && \
    tar xf omnetpp-6.0pre9-src-core.tgz && rm omnetpp-6.0pre9-src-core.tgz

WORKDIR /root/omnetpp-6.0pre9

# these are optional now, and we don't need them
RUN rm -rf samples

WORKDIR /root

RUN cp -r omnetpp-6.0pre9 omnetpp-6.0pre9-macosx && \
    cp -r omnetpp-6.0pre9 omnetpp-6.0pre9-windows && \
    mv omnetpp-6.0pre9 omnetpp-6.0pre9-linux

#### building the linux version

WORKDIR /root/omnetpp-6.0pre9-linux

ENV PATH /root/omnetpp-6.0pre9-linux/bin:$PATH
RUN ./configure WITH_QTENV=no WITH_OSG=no WITH_OSGEARTH=no
RUN make -j $(nproc)


#### building the mac version using some linux tools

WORKDIR /root/omnetpp-6.0pre9-macosx

ENV PATH /root/omnetpp-6.0pre9-macosx/bin:$PATH
RUN ./configure WITH_QTENV=no WITH_OSG=no WITH_OSGEARTH=no --host="x86_64-apple-darwin19" \
        CXX="x86_64-apple-darwin19-clang++-libc++" CC="x86_64-apple-darwin19-clang" \
        MSGC="/root/omnetpp-6.0pre9-linux/bin/opp_msgc" NEDTOOL="/root/omnetpp-6.0pre9-linux/bin/nedtool"
RUN make -j $(nproc)


#### building the windows version using some linux tools

WORKDIR /root/omnetpp-6.0pre9-windows

ENV PATH /root/omnetpp-6.0pre9-windows/bin:$PATH
RUN ./configure WITH_QTENV=no WITH_OSG=no WITH_OSGEARTH=no --host=x86_64-w64-mingw32 \
        MSGC="/root/omnetpp-6.0pre9-linux/bin/opp_msgc" NEDTOOL="/root/omnetpp-6.0pre9-linux/bin/nedtool"
RUN make -j $(nproc)

# switch back to using the linux tools
ENV PATH /root/omnetpp-6.0pre9-linux/bin:$PATH

WORKDIR /root

