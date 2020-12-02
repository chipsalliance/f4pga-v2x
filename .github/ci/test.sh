#!/bin/bash

set -ex

source "$HOME/miniconda/etc/profile.d/conda.sh"
conda activate yosys-env
which python
python --version
which tox
tox
