#!/usr/bin/env bash

set -x -e

export PATH="$HOME/miniconda/bin:$PATH"
source activate $MINICONDA_ENV_NAME
conda build .conda/ --no-test --no-anaconda-upload --python $TRAVIS_PYTHON_VERSION
