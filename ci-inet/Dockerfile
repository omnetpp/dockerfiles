FROM ghcr.io/inet-framework/ci-base:6.0.1-230503

RUN apt-get update && apt-get install -y --no-install-recommends \
        python3 ccache libfl-dev

WORKDIR /root

#RUN wget https://research.wand.net.nz/software/nsc/nsc-0.5.3.tar.bz2 --progress=dot:giga && \
#    tar xfj nsc-0.5.3.tar.bz2 && \
#    rm nsc-0.5.3.tar.bz2

#WORKDIR /root/nsc-0.5.3

#RUN wget https://raw.githubusercontent.com/inet-framework/inet-gpl/master/3rdparty/patch_for_nsc-0.5.3-amd64.txt
#RUN patch -p 2 -i patch_for_nsc-0.5.3-amd64.txt

# we have to ignore an error during nsc testing, so the docker build command doesn't halt
#RUN python2 scons.py -i

#ENV LD_LIBRARY_PATH /root/nsc-0.5.3/lib:$LD_LIBRARY_PATH

#WORKDIR /root
