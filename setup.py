#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Copyright (C) 2020  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier:	ISC

import setuptools

with open("README.rst", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="v2x",
    version="0.0.1",
    entry_points={
        "console_scripts": ["v2x=v2x.__main__:v2x"]
    },
    author="SymbiFlow Authors",
    author_email="symbiflow@lists.librecores.org",
    description="Python library for generating VPR architecture \
                description files from Verilog models.",
    long_description=long_description,
    long_description_content_type="text/x-rst",
    url="https://github.com/SymbiFlow/python-symbiflow-v2x",
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
        "License :: OSI Approved :: ISC License",
        "Operating System :: OS Independent",
    ],
)
