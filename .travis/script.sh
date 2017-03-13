#!/usr/bin/env bash

set -e -x

export PATH="$HOME/miniconda/bin:$PATH"
source activate $MINICONDA_ENV_NAME
conda build -t .conda/
