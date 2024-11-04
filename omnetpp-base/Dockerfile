FROM ubuntu:24.04
LABEL maintainer="Rudolf Hornig <rudi@omnetpp.org>"

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends git wget curl ca-certificates \
    build-essential pkg-config ccache clang lld gdb bison flex perl python3 \
    python3-pip python3-venv python3-dev libxml2-dev zlib1g-dev doxygen \
    graphviz xdg-utils libdw-dev \
    && apt-get clean
