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

import argparse


class ActionStoreBool(argparse.Action):
    """Convert a string argument into a boolean.

    Use like this for a default off argument which can be turned on;
    >>> parser = argparse.ArgumentParser()
    >>> parser.add_argument(
    ...    '--arg', action=ActionStoreBool, default=False)
    ActionStoreBool(['--arg'], False)
    >>> parser.parse_args([]).arg
    False
    >>> parser.parse_args(['--arg']).arg
    True
    >>> parser.parse_args(['--no-arg']).arg
    False
    >>> parser.parse_args(['--arg', 'yes']).arg
    True
    >>> parser.parse_args(['--arg', 'no']).arg
    False
    >>>

    Use like this for a default on argument which can be turned off;
    >>> parser = argparse.ArgumentParser()
    >>> parser.add_argument(
    ...    '--arg', action=ActionStoreBool, default=True)
    ActionStoreBool(['--arg'], True)
    >>> parser.parse_args([]).arg
    True
    >>> parser.parse_args(['--arg']).arg
    True
    >>> parser.parse_args(['--no-arg']).arg
    False
    >>> parser.parse_args(['--arg', 'yes']).arg
    True
    >>> parser.parse_args(['--arg', 'no']).arg
    False
    >>>

    Converts the following (in can capitalization) to `True`:
        * yes
        * y
        * true
        * t
        * 1

    Converts the following (in can capitalization) to `False`:
        * no
        * n
        * false
        * f
        * 0
    """

    def __init__(
            self,
            option_strings,
            dest,
            default=None,
            required=False,
            help=None,
            metavar=None):
        self.orig_option_strings = option_strings
        new_option_strings = []
        for s in option_strings:
            assert s.startswith("--"), s
            new_option_strings.append(s)
            new_option_strings.append("--no-" + s[2:])
        argparse.Action.__init__(
            self,
            new_option_strings,
            dest=dest,
            nargs='?',
            const=[True],
            default=default,
            type=self.value,
            choices=None,
            required=required,
            help=help,
            metavar=metavar)

    def value(self, s):
        if not s:
            return self.default
        elif s.lower() in ('yes', 'true', 't', 'y', '1'):
            return [True]
        elif s.lower() in ('no', 'false', 'f', 'n', '0'):
            return [False]
        else:
            raise argparse.ArgumentTypeError('Boolean value expected.')

    def __call__(self, parser, namespace, values, option_string=None):
        if len(values) == 0:
            values = [self.default]
        assert len(values) == 1
        if option_string.startswith("--no"):
            values[0] = False
        setattr(namespace, self.dest, values[0])

    def __repr__(self):
        return "ActionStoreBool({}, {})".format(
            self.orig_option_strings, self.default)


if __name__ == "__main__":
    import doctest
    failure_count, test_count = doctest.testmod()
    assert test_count > 0
    assert failure_count == 0, "Doctests failed!"
