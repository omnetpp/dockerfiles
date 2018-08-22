FROM ubuntu:16.04
MAINTAINER Rudolf Hornig <rudi@omnetpp.org>

# Set up requirements
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update && apt-get install --yes --no-install-recommends \
    default-jre \
    graphviz \
    imagemagick \
    python \
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
    rsync \
  && apt-get autoremove -y \
  && rm -fr /var/cache/* \
  && rm -fr /var/lib/apt/lists/*

# Patch for bug in `titlesec`
# see: http://tex.stackexchange.com/questions/299969/titlesec-loss-of-section-numbering-with-the-new-update-2016-03-15
RUN wget -O /usr/share/texlive/texmf-dist/tex/latex/titlesec/titlesec.sty "http://mirrors.ctan.org/macros/latex/contrib/titlesec/titlesec.sty"

# Install PlantUML
RUN wget -O /opt/plantuml.jar "https://sourceforge.net/projects/plantuml/files/plantuml.jar" --no-check-certificate \
  && printf '#!/bin/sh -e\njava -jar /opt/plantuml.jar "$@"' > /usr/local/bin/plantuml \
  && chmod 755 /usr/local/bin/plantuml

# Install Sphinx and extras
RUN wget -O /tmp/get-pip.py "https://bootstrap.pypa.io/get-pip.py" \
  && python /tmp/get-pip.py \
  && rm /tmp/get-pip.py \
  && pip install Sphinx \
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
    sphinxcontrib-plantuml \
    sphinxcontrib-exceltable \
    sphinxcontrib-googleanalytics \
    sphinxcontrib-googlechart \
    sphinxcontrib-googlemaps \
    sphinxcontrib-httpdomain

# Stop Java from writing files in documentation source
ENV HOME /home
ENV _JAVA_OPTIONS -Duser.home=${HOME}

EXPOSE 8000

WORKDIR /doc
