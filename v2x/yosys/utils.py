#!/usr/bin/env python3

# Copyright (C) 2020  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier:	ISC

import re

CLOCK_NAME_REGEX = re.compile(r"[a-z_]*clk[a-z0-9]*$")


def strip_yosys_json(text):
    """The JSON Yosys outputs isn't acutally compliant JSON, as it contains C-style
    comments. These must be stripped."""
    stripped = re.sub(r'\\\n', '', text)
    stripped = re.sub(r'//.*\n', '\n', stripped)
    stripped = re.sub(r'/\*.*\*/', '', stripped)
    return stripped


def is_clock_name(name):
    """
    Returns true if the port name correspond to a clock according to arbitrary
    regular expressions.

    >>> is_clock_name("data")
    False
    >>> is_clock_name("clk")
    True
    >>> is_clock_name("Clk")
    True
    >>> is_clock_name("Clk_Rst0")
    False
    >>> is_clock_name("Data_clk")
    True
    >>> is_clock_name("clk99")
    True
    >>> is_clock_name("bus_clk99")
    True
    >>> is_clock_name("busclk15")
    True
    >>> is_clock_name("clkb")
    True
    """
    match = CLOCK_NAME_REGEX.match(name.lower())
    return match is not None
