FROM omnetpp/travis-base:6.0pre12-210728

# ccache to allow a very fast build in the second stage, using object files from the first.
# Parts of ffmpeg for the VoIPStream feature. pkg-config so "make makefiles"
# can detect ffmpeg. libpcap is for the ExternalInterface feature.
# git and ssh for CircleCI, as on there the repo is cloned with git inside the image.
RUN apt-get update && apt-get install -y --no-install-recommends \
        python python3 ccache git openssh-client libpcap-dev pkg-config \
        libavcodec-dev libavformat-dev libavutil-dev libavresample-dev libfl-dev

WORKDIR /root

RUN wget https://research.wand.net.nz/software/nsc/nsc-0.5.3.tar.bz2 --progress=dot:giga && \
    tar xfj nsc-0.5.3.tar.bz2 && \
    rm nsc-0.5.3.tar.bz2

WORKDIR /root/nsc-0.5.3

RUN wget https://raw.githubusercontent.com/inet-framework/inet/master/3rdparty/patch_for_nsc-0.5.3-amd64.txt
RUN patch -p 2 -i patch_for_nsc-0.5.3-amd64.txt

# we have to ignore an error during nsc testing, so the docker build command doesn't halt
RUN python2 scons.py -i

ENV LD_LIBRARY_PATH /root/nsc-0.5.3/lib:$LD_LIBRARY_PATH

WORKDIR /root
