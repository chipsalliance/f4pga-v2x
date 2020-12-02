#!/bin/bash

set -ex

source "$HOME/miniconda/etc/profile.d/conda.sh"
conda activate yosys-env
python -m pip install --upgrade pip
which python
python --version
python -mpip --version
which tox
tox
