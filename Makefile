# Copyright 2020-2022 F4PGA Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

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

