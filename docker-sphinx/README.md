# Docker Sphinx

[![Build Status](https://travis-ci.org/nickjer/docker-sphinx.svg?branch=master)](https://travis-ci.org/nickjer/docker-sphinx)
[![Docker Build Status](https://img.shields.io/docker/build/nickjer/docker-sphinx.svg)](https://hub.docker.com/r/nickjer/docker-sphinx/)
[![GitHub License](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT)

Docker image for [Sphinx](http://www.sphinx-doc.org/en/stable/).

This image contains:

- [Sphinx](http://www.sphinx-doc.org/en/stable/)
- A variety of themes:
  - [Alabaster](http://alabaster.readthedocs.io/en/latest/)
  - [Sphinx Bootstrap Theme](http://ryan-roemer.github.io/sphinx-bootstrap-theme/README.html)
  - [sphinx_rtd_theme](https://github.com/rtfd/sphinx_rtd_theme)
- A markdown parser for reStructuredText ([recommonmark](https://github.com/rtfd/recommonmark))
- A sphinx watcher tool ([sphinx-autobuild](https://github.com/GaretJax/sphinx-autobuild/))
- A variety of plugins:
  - [sphinx-prompt](https://github.com/sbrunner/sphinx-prompt)
  - [sphinxcontrib-actdiag](https://pypi.python.org/pypi/sphinxcontrib-actdiag)
  - [sphinxcontrib-blockdiag](https://pypi.python.org/pypi/sphinxcontrib-blockdiag)
  - [sphinxcontrib-nwdiag](https://pypi.python.org/pypi/sphinxcontrib-nwdiag)
  - [sphinxcontrib-seqdiag](https://pypi.python.org/pypi/sphinxcontrib-seqdiag)
  - [sphinxcontrib-plantuml](https://pypi.python.org/pypi/sphinxcontrib-plantuml)
  - [sphinxcontrib-exceltable](https://pypi.python.org/pypi/sphinxcontrib-exceltable)
  - [sphinxcontrib-googleanalytics](https://pypi.python.org/pypi/sphinxcontrib-googleanalytics)
  - [sphinxcontrib-googlechart](https://pypi.python.org/pypi/sphinxcontrib-googlechart)
  - [sphinxcontrib-googlemaps](https://pypi.python.org/pypi/sphinxcontrib-googlemaps)
  - [sphinxcontrib-httpdomain](https://pypi.python.org/pypi/sphinxcontrib-httpdomain)
- Latex to generate PDF documents

## Build

```sh
git clone https://github.com/nickjer/docker-sphinx.git
cd docker-sphinx
docker build --force-rm -t omnetpp/docker-sphinx .
```

## Install

```sh
docker pull omnetpp/docker-sphinx
```

## Usage

```sh
docker run --rm -i -t -p 8000:8000 -v "${PWD}:/doc" -u "$(id -u):$(id -g)" omnetpp/docker-sphinx <cmd>
```

### Docker Compose

It is recommended to use [Docker Compose](https://docs.docker.com/compose/). An
example `docker-compose.yml` is seen as:

```yaml
version: "2"
services:
  sphinx:
    image: "omnetppdocker-sphinx"
    volumes:
      - "${PWD}:/doc"
    user: "1000:1000"
```

Then run:

```sh
docker-compose run --rm sphinx <cmd>
```

Examples:

```sh
docker-compose run --rm sphinx sphinx-quickstart
docker-compose run --rm sphinx make html
```
