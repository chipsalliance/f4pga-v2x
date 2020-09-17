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

import argparse
import os
import shlex

from v2x import vlog_to_model
from v2x import vlog_to_pbtype
from v2x.xmlinc import xmlinc

from vtr_xml_utils.convert import vtr_stylize_xml

# =============================================================================


def make_xml_for_docs(vlog_src, output_dir):
    """
    Recursively runs V2X (model and pb_type) on the given Verilog file and
    all its includes. Output XMLs are stylized using vtr-xml-utils.

    The Verilog file is copied to the output_dir. All include paths are
    updated so that they reflect the module hierarchy. It is assumed that
    a Verilog file is named <module>.sim.v. Next V2X is run followed by XML
    stylization using vtr-xml-utils. 

    The process continues recursively (depth-first).
    """

    # Make absolute paths
    vlog_src = os.path.abspath(vlog_src)
    output_dir = os.path.abspath(output_dir)

    # Make the output directory
    os.makedirs(output_dir, exist_ok=True)

    # Copy the verilog file, rearrange includes
    vlog_title = os.path.basename(vlog_src)
    vlog_dir = os.path.dirname(vlog_src)
    vlog_dst = os.path.join(output_dir, vlog_title)

    # Scan it for dependencies (includes), rewrite them
    vlog_deps = []

    with open(vlog_src, "r") as fsrc, open(vlog_dst, "w") as fdst:
        for src_line in fsrc:

            # Modify included file path
            line = src_line.strip()
            if line.startswith("`include"):
                fields = shlex.split(line)
                assert len(fields) == 2, fields

                dep_src = fields[1]
                dep_mod = os.path.basename(dep_src).split(".")[0]
                dep_dst = "./{f}/{f}.sim.v".format(f=dep_mod)

                vlog_deps.append((dep_src, dep_dst,))

                dst_line = "`include \"{}\"\n".format(dep_dst)

            # Pass unchanges
            else:
                dst_line = src_line

            # Write the line
            fdst.write(dst_line)

    # Process dependencies recursively first
    for dep_src, dep_dst in vlog_deps:
        dep_file = os.path.join(vlog_dir, dep_src)
        dep_dir = os.path.join(output_dir, os.path.dirname(dep_dst))

        make_xml_for_docs(dep_file, dep_dir)

    # Run V2X
    vlog_mod = vlog_title.split(".")[0]

    model_file = os.path.join(output_dir, vlog_mod + ".model.xml")
    pbtype_file = os.path.join(output_dir, vlog_mod + ".pb_type.xml")

    xml = vlog_to_model.vlog_to_model([vlog_dst], None, None, model_file)
    with open(model_file, "w") as fp:
        fp.write(xml)

    xml = vtr_stylize_xml(model_file)
    with open(model_file, "w") as fp:
        fp.write(xml)

    xml = vlog_to_pbtype.vlog_to_pbtype([vlog_dst], pbtype_file, None)
    with open(pbtype_file, "w") as fp:
        fp.write(xml)

    xml = vtr_stylize_xml(pbtype_file)
    with open(pbtype_file, "w") as fp:
        fp.write(xml)


# =============================================================================


if __name__ == "__main__":

    parser = argparse.ArgumentParser()

    parser.add_argument(
        "verilog",
        help="Input Verilog file"
    )
    parser.add_argument(
        "path",
        help="Output path"
    )

    args = parser.parse_args()
    make_xml_for_docs(args.verilog, args.path)
