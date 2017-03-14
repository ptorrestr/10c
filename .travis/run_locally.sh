#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export MINICONDA_ENV_NAME="10c-test"
export TRAVIS_PYTHON_VERSION="2.7"
$DIR/install.sh
$DIR/before_script.sh
$DIR/script.sh
$DIR/after_script.sh
