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

from . import vlog_to_pbtype
from . import vlog_to_model
import argparse
import sys

from .yosys.run import get_yosys


def main(args):

    # Check if Yosys can be found. Print an error message if not.
    if get_yosys() is None:
        print("ERROR: Cannot find the Yosys binary or its not executable.")
        return -1

    if args.mode == "pb_type":
        with open(args.outfile, "w") as fp:
            fp.write(
                vlog_to_pbtype.vlog_to_pbtype(
                    args.infiles, args.outfile, args.top))
    else:
        with open(args.outfile, "w") as fp:
            fp.write(
                vlog_to_model.vlog_to_model(
                    args.infiles, args.includes, args.top, args.outfile))


def v2x():
    parser = argparse.ArgumentParser(description="Verilog to XML")
    parser.add_argument(
        'infiles',
        metavar='input.v',
        type=str,
        nargs='+',
        help="""\
One or more Verilog input files, that will be passed to Yosys internally.
They should be enough to generate a flattened representation of the model,
so that paths through the model can be determined.
""")
    parser.add_argument(
        '--top',
        help="""\
Top level module, will usually be automatically determined from the file name
%.sim.v
""")
    parser.add_argument(
        '--outfile',
        '-o',
        type=str,
        default="output.xml",
        help="""\
Output filename, default 'output.xml'
""")
    parser.add_argument(
        '--includes',
        help="""\
Comma separate list of include directories.
""",
        default="")
    parser.add_argument(
        '--mode',
        type=str,
        default='pb_type',
        choices=['pb_type', 'model'],
        help="""\
Output file type, possible values are: pb_type and model.
Default value is pb_type
""")
    args = parser.parse_args()
    sys.exit(main(args))


if __name__ == '__main__':
    v2x()
