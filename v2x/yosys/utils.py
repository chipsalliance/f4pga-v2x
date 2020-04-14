#!/usr/bin/env python3

# Copyright (C) 2020  The SymbiFlow Authors.
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

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
