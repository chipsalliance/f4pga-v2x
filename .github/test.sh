#!/bin/bash
#
# Copyright (C) 2020  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier:	ISC

set -ex

source "$HOME/miniconda/etc/profile.d/conda.sh"
conda activate yosys-env
which python
python --version
which tox
tox
