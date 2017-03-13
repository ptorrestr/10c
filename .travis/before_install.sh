#!/usr/bin/env bash

set -x -e

MINICONDA_BUCKET="repo.continuum.io"
MINICONDA_VERSION="4.2.12"
MINICONDA_FOLDER="$HOME/miniconda"
MINICONDA_ENV_NAME="10c"
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  rvm get stable # We need this since there is a bug in osx. See https://github.com/travis-ci/travis-ci/issues/6307
  OS="MacOSX"
  MINICONDA_MD5="d2edb7d4f3f55c35b9a25fd2d0ef6856"
else
  OS="Linux"
  MINICONDA_MD5="d573980fe3b5cdf80485add2466463f5"
fi

if [[ "$TRAVIS_PYTHON_VERSION" == "2.7" ]]; then
  PYTHON_V="2"
else
  PYTHON_V="3"
fi

hash conda 2>/dev/null || ( \
  curl -fSL "https://${MINICONDA_BUCKET}/miniconda/Miniconda${PYTHON_V}-${MINICONDA_VERSION}-${OS}-x86_64.sh" -o miniconda.sh \
  && echo "${MINICONDA_MD5} *miniconda.sh" | md5sum -c - \
  && bash miniconda.sh -b -p $MINICONDA_FOLDER \
  && export PATH="$MINICONDA_FOLDER/bin:$PATH" \
  && hash -r \
  && conda config --set always_yes yes --set changeps1 no \
  && conda update -q conda \
  && rm miniconda.sh \
  && conda install conda-build anaconda-client \
  && conda create -q -n $MINICONDA_ENV_NAME python=$TRAVIS_PYTHON_VERSION \
  && conda -V )

conda config --add channels conda-forge
conda config --add channels ptorrestr
