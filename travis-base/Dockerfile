FROM omnetpp/cross-compilers:ubuntu20.04-macos10.15-200914

ARG OMNETPP_VERSION=6.0pre10

RUN apt-get update && apt-get install -y --no-install-recommends \
                        wget ca-certificates bison flex \
                        libopenscenegraph-dev openscenegraph-plugin-osgearth libosgearth-dev

WORKDIR /root

RUN wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-${OMNETPP_VERSION}/omnetpp-${OMNETPP_VERSION}-src-core.tgz \
         -O omnetpp-${OMNETPP_VERSION}-src-core.tgz --progress=dot:giga && \
    tar xf omnetpp-${OMNETPP_VERSION}-src-core.tgz && rm omnetpp-${OMNETPP_VERSION}-src-core.tgz

WORKDIR /root/omnetpp-${OMNETPP_VERSION}

# these are optional now, and we don't need them
RUN rm -rf samples

WORKDIR /root

RUN cp -r omnetpp-6.0pre10 omnetpp-6.0pre10-macosx && \
    cp -r omnetpp-6.0pre10 omnetpp-6.0pre10-windows && \
    mv omnetpp-${OMNETPP_VERSION} omnetpp-${OMNETPP_VERSION}-linux

#### building the linux version

WORKDIR /root/omnetpp-${OMNETPP_VERSION}-linux

ENV PATH /root/omnetpp-${OMNETPP_VERSION}-linux/bin:$PATH
RUN ./configure WITH_QTENV=no WITH_OSG=yes WITH_OSGEARTH=yes
RUN make -j $(nproc)


#### building the mac version using some linux tools

WORKDIR /root/omnetpp-${OMNETPP_VERSION}-macosx

ENV PATH /root/omnetpp-${OMNETPP_VERSION}-macosx/bin:$PATH
RUN ./configure WITH_QTENV=no WITH_OSG=no WITH_OSGEARTH=no --host="x86_64-apple-darwin19" \
        CXX="x86_64-apple-darwin19-clang++-libc++" CC="x86_64-apple-darwin19-clang" \
        MSGC="/root/omnetpp-${OMNETPP_VERSION}-linux/bin/opp_msgc" NEDTOOL="/root/omnetpp-${OMNETPP_VERSION}-linux/bin/nedtool"
RUN make -j $(nproc)


#### building the windows version using some linux tools

WORKDIR /root/omnetpp-${OMNETPP_VERSION}-windows

ENV PATH /root/omnetpp-${OMNETPP_VERSION}-windows/bin:$PATH
RUN ./configure WITH_QTENV=no WITH_OSG=no WITH_OSGEARTH=no --host=x86_64-w64-mingw32 \
        MSGC="/root/omnetpp-${OMNETPP_VERSION}-linux/bin/opp_msgc" NEDTOOL="/root/omnetpp-${OMNETPP_VERSION}-linux/bin/nedtool"
RUN make -j $(nproc)

# switch back to using the linux tools
ENV PATH /root/omnetpp-${OMNETPP_VERSION}-linux/bin:$PATH

WORKDIR /root

