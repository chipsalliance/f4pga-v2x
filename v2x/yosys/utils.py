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
