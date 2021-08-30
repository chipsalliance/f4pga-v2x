# Copyright (C) 2021  The Symbiflow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

SHELL=bash

TOP_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
REQUIREMENTS_FILE ?= requirements.txt
ENVIRONMENT_FILE ?= environment.yml

TOXENV ?=

V2X_PYTHON_SRCS = $(shell find v2x -name "*py")

include third_party/make-env/conda.mk

env:: | $(CONDA_ENV_PYTHON)

format: $(V2X_PYTHON_SRCS)
	$(IN_CONDA_ENV) yapf -i ${V2X_PYTHON_SRCS} setup.py

test-py:
	$(IN_CONDA_ENV) TOXENV=$(TOXENV) tox

.PHONY: env build test-py

