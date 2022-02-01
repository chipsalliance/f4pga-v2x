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
"""
Convert a Verilog simulation model to a VPR `model.xml`

The following Verilog attributes are considered on ports:
    - `(* CLOCK *)` or `(* CLOCK=1 *)` : force a given port to be a clock

    - `(* CLOCK=0 *)` : force a given port not to be a clock

    - `(* ASSOC_CLOCK="RDCLK" *)` : force a port's associated
                                    clock to a given value

    - `(* COMB_INCLUDE_CLOCKS *)` : When specified on a clock input port
                                    allows it to have combinational relations
                                    with other ports.

    - `(* NO_COMB *)` : Forces removal of all combinational relations of an
                        input port.

    - `(* NO_SEQ *)` : Forces removal of all sequential relations of an input
                       port.

The following Verilog attributes are considered on modules:
    - `(* MODEL_NAME="model" *)` : override the name used for
    <model> and for ".subckt name" in the BLIF model. Mostly
    intended for use with w.py, when several different pb_types
    implement the same model.

    - `(* CLASS="lut|routing|mux|flipflop|mem" *)` : specify the
    class of an given instance. A model will not be generated for
    the `lut`, `routing` or `flipflop` class.
"""
import os
import re
import sys

import lxml.etree as ET

from .yosys import run
from .yosys.json import YosysJSON
from .yosys import utils as utils

from .xmlinc import xmlinc


def is_clock_assoc(infiles, module, clk, port, direction):
    """Checks if a specific port is associated with a clk clock

    Returns a boolean value
    -------
    is_clock_assoc: bool
    """
    clock_assoc_signals = run.get_clock_assoc_signals(infiles, module, clk)

    if direction == "input":
        assoc_outputs = run.get_related_output_for_input(infiles, module, port)
        for out in assoc_outputs:
            if out in clock_assoc_signals:
                return True
    elif direction == "output":
        if port in clock_assoc_signals:
            return True
    else:
        assert False, "Bidirectional ports are not supported yet"

    return False


def is_registered_path(tmod, pin, pout):
    """Checks if a i/o path is sequential. If that is the case
    no combinational_sink_port is needed

    Returns a boolean value
    """

    for cell, ctype in tmod.all_cells:
        if ctype != "$dff":
            continue

        if tmod.port_conns(pin) == tmod.cell_conn_list(
                cell, "D") and tmod.port_conns(pout) == tmod.cell_conn_list(
                    cell, "Q"):
            return True

    return False


def vlog_to_model(infiles, includes, top, outfile=None):

    # Check Yosys version
    pfx = run.determine_select_prefix()
    if pfx != "=":
        print(
            "ERROR The version of Yosys found is outdated and not supported"
            " by V2X")
        sys.exit(-1)

    iname = os.path.basename(infiles[0])

    if outfile is None:
        outfile = "model.xml"

    if includes:
        for include in includes.split(','):
            run.add_include(include)

    aig_json = run.vlog_to_json(infiles, flatten=True, aig=True)

    if top is not None:
        top = top.upper()
    else:
        yj = YosysJSON(aig_json)
        if yj.top is not None:
            top = yj.top
        else:
            wm = re.match(r"([A-Za-z0-9_]+)\.sim\.v", iname)
            if wm:
                top = wm.group(1).upper()
            else:
                print(
                    """\
    ERROR file name not of format %.sim.v ({}), cannot detect top level.
    Manually specify the top level module using --top""").format(iname)
                sys.exit(1)

    assert top is not None
    yj = YosysJSON(aig_json, top)
    if top is None:
        print(
            """\
    ERROR: more than one module in design, cannot detect top level.
    Manually specify the top level module using --top""")
        sys.exit(1)

    tmod = yj.top_module
    models_xml = ET.Element("models", nsmap={'xi': xmlinc.xi_url})

    inc_re = re.compile(r'^\s*`include\s+"([^"]+)"')

    deps_files = set()
    # XML dependencies need to correspond 1:1 with Verilog includes, so we have
    # to do this manually rather than using Yosys
    with open(infiles[0], 'r') as f:
        for line in f:
            im = inc_re.match(line)
            if not im:
                continue
            deps_files.add(im.group(1))

    if len(deps_files) > 0:
        # Has dependencies, not a leaf model
        for df in sorted(deps_files):
            abs_base = os.path.dirname(os.path.abspath(infiles[0]))
            abs_dep = os.path.normpath(os.path.join(abs_base, df))
            module_path = os.path.dirname(abs_dep)
            module_basename = os.path.basename(abs_dep)
            wm = re.match(r"([A-Za-z0-9_]+)\.sim\.v", module_basename)
            if wm:
                model_path = "{}/{}.model.xml".format(
                    module_path,
                    wm.group(1).lower())
            else:
                assert False, "included Verilog file name {} does \
                        not follow pattern %%.sim.v".format(module_basename)
            xmlinc.include_xml(
                parent=models_xml,
                href=model_path,
                outfile=outfile,
                xptr="xpointer(models/child::node())")
    else:
        # Is a leaf model
        topname = tmod.attr("MODEL_NAME", top)
        assert topname == topname.upper(
        ), "Leaf model names should be all uppercase!"
        modclass = tmod.attr("CLASS", "")

        if modclass not in ("input", "output", "lut", "routing", "flipflop"):
            model_xml = ET.SubElement(models_xml, "model", {'name': topname})
            ports = tmod.ports

            inports_xml = ET.SubElement(model_xml, "input_ports")
            outports_xml = ET.SubElement(model_xml, "output_ports")

            clocks = run.list_clocks(infiles, top)

            for name, width, bits, iodir in ports:
                port_attrs = tmod.port_attrs(name)

                is_clock = name in clocks or utils.is_clock_name(name)

                if "CLOCK" in port_attrs:
                    is_clock = int(port_attrs["CLOCK"]) != 0

                attrs = dict(name=name)
                sinks = run.get_combinational_sinks(infiles, top, name)

                # Removes comb sinks if path from in to out goes through a dff
                for sink in sinks:
                    if is_registered_path(tmod, name, sink):
                        sinks.remove(sink)

                if is_clock:
                    attrs["is_clock"] = "1"

                    # Remove comb sinks that do not have "COMB_INCLUDE_CLOCKS"
                    # attribute
                    for sink in sinks:
                        sink_attrs = tmod.port_attrs(sink)
                        if int(sink_attrs.get("COMB_INCLUDE_CLOCKS", 0)) == 0:
                            sinks.remove(sink)

                else:
                    clks = list()
                    for clk in clocks:
                        if is_clock_assoc(infiles, top, clk, name, iodir):

                            clks.append(clk)
                        if clks and int(port_attrs.get("NO_SEQ", 0)) == 0:
                            attrs["clock"] = " ".join(clks)

                if len(sinks) > 0 and iodir == "input" and \
                   int(port_attrs.get("NO_COMB", 0)) == 0:
                    attrs["combinational_sink_ports"] = " ".join(sinks)
                if iodir == "input":
                    ET.SubElement(inports_xml, "port", attrs)
                elif iodir == "output":
                    ET.SubElement(outports_xml, "port", attrs)
                else:
                    assert False, "bidirectional ports not permitted \
                                  in VPR models"

    if len(models_xml) == 0:
        models_xml.insert(
            0, ET.Comment("this file is intentionally left blank"))

    return ET.tostring(models_xml, pretty_print=True).decode('utf-8')
