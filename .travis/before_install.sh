#!/usr/bin/env bash

set -x -e

if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  rvm get stable # We need this since there is a bug in osx. See https://github.com/travis-ci/travis-ci/issues/6307
  OS="MacOSX"
  MINICONDA_MD5="ff3d7b69e32e1e4246176fb90f8480c8"
else
  OS="Linux"
  MINICONDA_MD5="c8b836baaa4ff89192947e4b1a70b07e"
fi

if [[ "$TRAVIS_PYTHON_VERSION" == "2.7" ]]; then
  PYTHON_V="2"
else
  PYTHON_V="3"
fi

hash conda 2>/dev/null || ( \
  curl -fSL "https://${MINICONDA_BUCKET}/miniconda/Miniconda${PYTHON_V}-${MINICONDA_VERSION}-${OS}-x86_64.sh" -o miniconda.sh \
  && echo "${MINICONDA_MD5} *miniconda.sh" | md5sum -c - \
  && rm -rf $MINICONDA_FOLDER \
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
