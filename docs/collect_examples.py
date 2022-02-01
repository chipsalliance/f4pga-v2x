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

import os
from shutil import copy, copytree, ignore_patterns

from make_xml_for_docs import make_xml_for_docs

# =============================================================================


README_NAME = "README.rst"
TEMPLATE_NAME = "examples.rst.template"
INDEX_NAME = "examples.rst"


def process_verilog_files(src_dir, dst_dir):
    """
    Looks for Verilog models for V2X and runs make_xml_for_docs on them.

    If at least one Verilog model is found at a directory level then
    the function does not look deeper. Otherwise it searches for models
    recursively.
    """

    got_verilog = False

    # Find and process all verilog files at this directory level
    for f in os.listdir(src_dir):
        f_name = os.path.join(src_dir, f)
        if os.path.isfile(f_name) and f_name.endswith(".sim.v"):
            got_verilog = True

            make_xml_for_docs(f_name, dst_dir)

    # Don't go deeper if one was found
    if got_verilog is True:
        return

    # Look into subdirectories
    for d in os.listdir(src_dir):
        d_name = os.path.join(src_dir, d)
        if os.path.isdir(d_name):

            process_verilog_files(
                os.path.join(src_dir, d),
                os.path.join(dst_dir, d)
            )


def collect_examples():
    """
    Collects test designs that have readme files and converts them for
    documentation examples.
    """

    # Base directory for tests
    tests_dir = os.path.abspath(
        os.path.join(
            os.path.dirname(__file__),
            "../tests"
        )
    )

    # Base directory for examples
    examples_dir = os.path.abspath(
        os.path.join(
            os.path.dirname(__file__),
            "examples"
        )
    )

    # Skip if the directory already exist
    if os.path.isdir(examples_dir):
        return

    print("Collecting test designs and including them in \"examples\" section")

    # Create the directory
    os.makedirs(examples_dir, exist_ok=True)

    # Look for all subdirectories that have "readme.rst" file inside
    tests = []
    for d in os.listdir(tests_dir):

        # Only directories
        d_name = os.path.join(tests_dir, d)
        if os.path.isdir(d_name):

            # Must contain the readme file
            f_name = os.path.join(d_name, README_NAME)
            if os.path.isfile(f_name):
                tests.append((d, d_name,))

    # Process each test
    check_ignore = ignore_patterns("*.v", "golden.*.xml")
    for test_name, test_src in tests:

        test_rel = os.path.relpath(test_src, tests_dir)
        test_dst = os.path.join(examples_dir, test_rel)

        print("", test_name)

        # Copy files
        copytree(test_src, test_dst, ignore=check_ignore)

        # Build XMLs for verilog giles
        process_verilog_files(test_src, test_dst)

    # Build examples.rst
    tname = os.path.join(os.path.dirname(__file__), TEMPLATE_NAME)
    fname = os.path.join(examples_dir, INDEX_NAME)

    with open(tname, "r") as fsrc, open(fname, "w") as fdst:

        # Copy
        for line in fsrc:
            fdst.write(line)

        # Append included tests
        tests = sorted(tests, key=lambda t:t[0])
        for test_name, _ in tests:
            fdst.write("   {}/{}\n".format(test_name, README_NAME))


if __name__ == "__main__":
    collect_examples()
