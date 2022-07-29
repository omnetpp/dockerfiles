FROM ubuntu:22.04
LABEL maintainer="Rudolf Hornig <rudi@omnetpp.org>"

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends git wget curl ca-certificates \
             make clang lld gdb bison flex perl doxygen graphviz libxml2-dev zlib1g-dev \
             python3 python3-pip python3-pandas python3-numpy python3-matplotlib \
             python3-scipy python3-seaborn python3-posix-ipc && \
    apt-get clean
# python3 -m pip install --user --upgrade numpy pandas matplotlib scipy seaborn posix_ipc
