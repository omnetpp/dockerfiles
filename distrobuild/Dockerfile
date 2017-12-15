FROM omnetpp/distrobuild-base:ubuntu16.04-macos11-171215
MAINTAINER Rudolf Hornig <rudi@omnetpp.org>

# provide the github ssh keys in the context dir that can access the OMNeT++ repo (./is_rsa, ./id_rsa.pub) - no password please!
# the tools directory should contain the Windows and macOS toolchains (i.e. ./tools/170717/...)

# omnetpp specific
ENV TOOLS_DIR /root/tools
ENV TOOLS_VERSION 170717
ENV OMNETPP_DIR /root/omnetpp

# clone the directory
WORKDIR /root
RUN mkdir -p ~/.ssh
COPY id_rsa* /root/.ssh/
RUN chmod go-rwx /root/.ssh/id_rsa
RUN GIT_SSH_COMMAND='ssh -o StrictHostKeyChecking=no' git clone -n git@github.com:omnetpp/omnetpp.git

# update the eclipse build's MAVEN cache for faster builds
WORKDIR $OMNETPP_DIR
# getting only the dependnecies does not work correctly
#RUN git checkout 85348ed && (cd $OMNETPP_DIR/ui && (mvn dependency:go-offline -DexcludeGroupIds=org.omnetpp.ide || true)) && rm $OMNETPP_DIR/* -rf
# we dummy build the IDE and then delete the whole OMNeT++ source, so as a side effect the maven cache will be updated
ENV PATH $PATH:$OMNETPP_DIR/bin
RUN git fetch -p && git checkout 2b7b797 && \
    cp configure.user.dist configure.user && \
    ./configure WITH_TKENV=no WITH_QTENV=no WITH_OSG=no WITH_OSGEARTH=no && \
    make MODE=release ui -j$(nproc)
RUN ui/releng/org.omnetpp.ide.product/build-ide-java && rm $OMNETPP_DIR/* -rf

# copy the windows/macOS tools into the build image
# NOTE: update the toolchain vvvvvv HERE !!!
COPY tools/$TOOLS_VERSION $TOOLS_DIR/$TOOLS_VERSION

# default variables controlling the build
ENV GIT_VERSION origin/master
ENV WHAT omnetpp
ENV BUILD_CORE_DISTRO true
ENV BUILD_LINUX_DISTRO true
ENV BUILD_WIN64_DISTRO true
ENV BUILD_MACOSX_DISTRO true
CMD git reset --hard && git fetch -f && git checkout -f $GIT_VERSION && _scripts/build-omnetpp-src-dist
