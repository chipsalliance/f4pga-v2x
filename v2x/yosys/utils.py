#!/usr/bin/env python3
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
    """
    match = CLOCK_NAME_REGEX.match(name.lower())
    return match is not None
