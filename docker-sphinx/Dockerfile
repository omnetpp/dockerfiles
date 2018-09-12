FROM ubuntu:18.04
MAINTAINER Rudolf Hornig <rudi@omnetpp.org>

# Set up requirements
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update && apt-get install --yes --no-install-recommends \
    python3 \
    python3-pip \
    graphviz \
    imagemagick \
    ghostscript \
    texlive \
    texlive-fonts-recommended \
    texlive-font-utils \
    texlive-lang* \
    texlive-latex-extra \
    texlive-latex-recommended \
    latexmk \
    build-essential \
    wget \
    rsync && \
    apt-get autoremove -y && \
    pip3 install --upgrade pip setuptools && \
    rm -r /root/.cache

# Install Sphinx and extras
RUN pip3 install Sphinx \
    alabaster \
    sphinx_bootstrap_theme \
    sphinx_rtd_theme \
    sphinx_materialdesign_theme \
    recommonmark \
    sphinx-autobuild \
    sphinx-prompt \
    sphinxcontrib-actdiag \
    sphinxcontrib-blockdiag \
    sphinxcontrib-nwdiag \
    sphinxcontrib-seqdiag \
    sphinxcontrib-exceltable \
    sphinxcontrib-httpdomain

ENV HOME /home

EXPOSE 8000

WORKDIR /doc
