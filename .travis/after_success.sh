#!/usr/bin/env bash

set -x -e

# Only publish when a tag is build
if [[ -n "$TRAVIS_TAG" ]]; then
  export PATH="$HOME/miniconda/bin:$PATH"
  source activate $MINICONDA_ENV_NAME
  file=$(conda build .conda/ --output)
  anaconda -t $ANACONDA_TOKEN upload $file -u $ANACONDA_USER --force
fi
