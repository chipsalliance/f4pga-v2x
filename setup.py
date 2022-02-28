#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
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

import setuptools

with open("README.rst", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="v2x",
    version="0.0.1",
    entry_points={"console_scripts": ["v2x=v2x.__main__:v2x"]},
    author="F4PGA Authors",
    author_email="f4pga-wg@lists.chipsalliance.org",
    description="Python library for generating VPR architecture \
                description files from Verilog models.",
    long_description=long_description,
    long_description_content_type="text/x-rst",
    url="https://github.com/chipsalliance/f4pga-v2x",
    packages=setuptools.find_packages(),
    install_requires=[
        'lxml',
        'pyjson',
        'vtr-xml-utils',
    ],
    setup_requires=["pytest-runner"],
    tests_require=[
        'pytest',
    ],
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: Apache Software License",
        "Operating System :: OS Independent",
    ],
)
