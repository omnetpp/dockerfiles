FROM omnetpp/cross-compilers:ubuntu16.04-macos11-171206

WORKDIR /root


RUN wget https://www.omnetpp.org/omnetpp/send/30-omnet-releases/2323-omnetpp-5-2-1-core \
        --referer=https://omnetpp.org/omnetpp -O omnetpp-5.2.1-src-core.tgz --progress=dot:giga && \
    tar xf omnetpp-5.2.1-src-core.tgz && rm omnetpp-5.2.1-src-core.tgz

WORKDIR /root/omnetpp-5.2.1

# these are optional now, and we don't need them
RUN rm -rf samples

WORKDIR /root

RUN cp -r omnetpp-5.2.1 omnetpp-5.2.1-macosx
RUN cp -r omnetpp-5.2.1 omnetpp-5.2.1-windows
RUN mv omnetpp-5.2.1 omnetpp-5.2.1-linux


#### building the linux version

WORKDIR omnetpp-5.2.1-linux

# Removing the default "-march native" options, as those are not practical in a Docker image.
# We have to echo into configure.user because of Bug #1006 (https://dev.omnetpp.org/bugs/view.php?id=1006).
RUN echo "CFLAGS_RELEASE='-O3 -DNDEBUG=1 -D_XOPEN_SOURCE'" >> configure.user
# Adding O1 because without it, the INET fingerprint tests timed out on travis on a debug build, and we don't actually want to debug.
RUN echo "CFLAGS_DEBUG='-O1 -ggdb -Wall'" >> configure.user

ENV PATH /root/omnetpp-5.2.1-linux/bin:$PATH
RUN ./configure WITH_TKENV=no WITH_QTENV=no WITH_OSG=no WITH_OSGEARTH=no
RUN make -j $(nproc)


#### building the mac version using some linux tools

WORKDIR /root/omnetpp-5.2.1-macosx

# The _XOPEN_SOURCE macro has to be defined otherwise the deprecated context switching functions are not available.
# Also we remove the default "-march native" options, as those are not practical in a Docker image.
# We have to echo into configure.user because of Bug #1006 (https://dev.omnetpp.org/bugs/view.php?id=1006).
RUN echo "CFLAGS_RELEASE='-O3 -DNDEBUG=1 -D_XOPEN_SOURCE'" >> configure.user
# Adding O1 because without it, the INET fingerprint tests timed out on travis on a debug build, and we don't actually want to debug.
RUN echo "CFLAGS_DEBUG='-O1 -ggdb -Wall'" >> configure.user

ENV PATH /root/omnetpp-5.2.1-macosx/bin:$PATH
RUN ./configure WITH_TKENV=no WITH_QTENV=no WITH_OSG=no WITH_OSGEARTH=no --host="x86_64-apple-darwin15" \
        CXX="x86_64-apple-darwin15-clang++-libc++" CC="x86_64-apple-darwin15-clang" \
        MSGC="/root/omnetpp-5.2.1-linux/bin/opp_msgc" NEDTOOL="/root/omnetpp-5.2.1-linux/bin/nedtool"
RUN make -j $(nproc)


#### building the windows version using some linux tools

WORKDIR /root/omnetpp-5.2.1-windows

# Removing the default "-march native" options, as those are not practical in a Docker image.
# We have to echo into configure.user because of Bug #1006 (https://dev.omnetpp.org/bugs/view.php?id=1006).
RUN echo "CFLAGS_RELEASE='-O3 -DNDEBUG=1'" >> configure.user
# Adding O1 because without it, the INET fingerprint tests timed out on travis on a debug build, and we don't actually want to debug.
RUN echo "CFLAGS_DEBUG='-O1 -ggdb -Wall'" >> configure.user

ENV PATH /root/omnetpp-5.2.1-windows/bin:$PATH
RUN ./configure WITH_TKENV=no WITH_QTENV=no WITH_OSG=no WITH_OSGEARTH=no --host=x86_64-w64-mingw32 \
        MSGC="/root/omnetpp-5.2.1-linux/bin/opp_msgc" NEDTOOL="/root/omnetpp-5.2.1-linux/bin/nedtool"
RUN make -j $(nproc)

# switch back to using the linux tools
ENV PATH /root/omnetpp-5.2.1-linux/bin:$PATH

WORKDIR /root

