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
  - [sphinxcontrib-exceltable](https://pypi.python.org/pypi/sphinxcontrib-exceltable)
  - [sphinxcontrib-googlechart](https://pypi.python.org/pypi/sphinxcontrib-googlechart)
  - [sphinxcontrib-httpdomain](https://pypi.python.org/pypi/sphinxcontrib-httpdomain)
  - [sphinxcontrib-image](https://pypi.org/project/sphinxcontrib-images/)
  - [sphinxcontrib-googleanalytics](https://bitbucket.org/birkenfeld/sphinx-contrib/)
- Latex to generate PDF documents

## Build

```sh
docker build --force-rm -t ghcr.io/omnetpp/docker-sphinx:200610 .
```

## Install

```sh
docker pull ghcr.io/omnetpp/docker-sphinx
```

## Usage

```sh
docker run --rm -i -t -p 8000:8000 -v "${PWD}:/docs" -u "$(id -u):$(id -g)" ghcr.io/omnetpp/docker-sphinx <cmd>
```
