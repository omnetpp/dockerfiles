#
# Copyright (C) OpenSim Kft.
#
# SPDX-License-Identifier: MIT
#

FROM ghcr.io/omnetpp/cross-compilers:ubuntu24.04-macos15.1-250303

# The name of the release on GitHub and the tarballs have the .0 minor version
ARG OMNETPP_RELEASE=6.1.0
# But the Version file and the name of the folder in the tarballs don't
ARG OMNETPP_VERSION=6.1

RUN apt-get update && apt-get install -y --no-install-recommends \
                        wget ca-certificates bison flex \
                        libopenscenegraph-dev build-essential pkg-config python3-dev

WORKDIR /root

RUN wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-${OMNETPP_RELEASE}/omnetpp-${OMNETPP_RELEASE}-core.tgz \
         -O omnetpp-${OMNETPP_RELEASE}-core.tgz --progress=dot:giga && \
    tar xf omnetpp-${OMNETPP_RELEASE}-core.tgz && rm omnetpp-${OMNETPP_RELEASE}-core.tgz

WORKDIR /root/omnetpp-${OMNETPP_VERSION}

# these are optional now, and we don't need them
RUN rm -rf samples

WORKDIR /root

RUN cp -r omnetpp-${OMNETPP_VERSION} omnetpp-${OMNETPP_VERSION}-macosx && \
    cp -r omnetpp-${OMNETPP_VERSION} omnetpp-${OMNETPP_VERSION}-windows && \
    mv omnetpp-${OMNETPP_VERSION} omnetpp-${OMNETPP_VERSION}-linux

#### building the linux version

WORKDIR /root/omnetpp-${OMNETPP_VERSION}-linux

# partially emulating . setenv
ENV PATH /root/omnetpp-${OMNETPP_VERSION}-linux/bin:$PATH
ENV __omnetpp_root_dir /root/omnetpp-${OMNETPP_VERSION}-linux
ENV OMNETPP_RELEASE omnetpp-${OMNETPP_VERSION}

RUN ./configure WITH_QTENV=no WITH_OSG=yes WITH_OSGEARTH=no
RUN make -j $(nproc)


#### building the mac version using some linux tools

WORKDIR /root/omnetpp-${OMNETPP_VERSION}-macosx

ENV PATH /root/omnetpp-${OMNETPP_VERSION}-macosx/bin:$PATH
ENV __omnetpp_root_dir /root/omnetpp-${OMNETPP_VERSION}-macosx

RUN ./configure WITH_SCAVE_PYTHON_BINDINGS=no WITH_QTENV=no WITH_OSG=no WITH_OSGEARTH=no --host="x86_64-apple-darwin24.1" \
        CXX="x86_64-apple-darwin24.1-clang++-libc++" CC="x86_64-apple-darwin24.1-clang" \
        MSGC="/root/omnetpp-${OMNETPP_VERSION}-linux/bin/opp_msgc" NEDTOOL="/root/omnetpp-${OMNETPP_VERSION}-linux/bin/nedtool"
RUN make -j $(nproc)


#### building the windows version using some linux tools

WORKDIR /root/omnetpp-${OMNETPP_VERSION}-windows

ENV PATH /root/omnetpp-${OMNETPP_VERSION}-windows/bin:$PATH
ENV __omnetpp_root_dir /root/omnetpp-${OMNETPP_VERSION}-windows

RUN ./configure WITH_SCAVE_PYTHON_BINDINGS=no WITH_QTENV=no WITH_OSG=no WITH_OSGEARTH=no --host=x86_64-w64-mingw32 \
        MSGC="/root/omnetpp-${OMNETPP_VERSION}-linux/bin/opp_msgc" NEDTOOL="/root/omnetpp-${OMNETPP_VERSION}-linux/bin/nedtool"

# This is a HACK to get around `error: external linkage required for symbol 'omnetpp::scave::NULLSTRING' because of 'dllexport' attribute`
RUN sed -i 's/const SCAVE_API std::string NULLSTRING = "";/extern const SCAVE_API std::string NULLSTRING = "";/' src/scave/resultitems.cc

RUN make -j $(nproc)

# switch back to using the linux tools
ENV PATH /root/omnetpp-${OMNETPP_VERSION}-linux/bin:$PATH

WORKDIR /root

