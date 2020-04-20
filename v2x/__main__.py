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
            fp.write(vlog_to_pbtype.vlog_to_pbtype(
                args.infiles, args.outfile, args.top))
    else:
        with open(args.outfile, "w") as fp:
            fp.write(vlog_to_model.vlog_to_model(
                args.infiles, args.includes, args.top, args.outfile))


def v2x():
    parser = argparse.ArgumentParser(
        description="Verilog to XML"
    )
    parser.add_argument(
        'infiles',
        metavar='input.v',
        type=str,
        nargs='+',
        help="""\
One or more Verilog input files, that will be passed to Yosys internally.
They should be enough to generate a flattened representation of the model,
so that paths through the model can be determined.
"""
    )
    parser.add_argument(
        '--top',
        help="""\
Top level module, will usually be automatically determined from the file name
%.sim.v
"""
    )
    parser.add_argument(
        '--outfile',
        '-o',
        type=str,
        default="output.xml",
        help="""\
Output filename, default 'output.xml'
"""
    )
    parser.add_argument(
        '--includes',
        help="""\
Comma separate list of include directories.
""",
        default=""
    )
    parser.add_argument(
        '--mode',
        type=str,
        default='pb_type',
        choices=['pb_type', 'model'],
        help="""\
Output file type, possible values are: pb_type and model.
Default value is pb_type
"""
    )
    args = parser.parse_args()
    sys.exit(main(args))


if __name__ == '__main__':
    v2x()
