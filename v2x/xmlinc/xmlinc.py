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

import lxml.etree as ET
import os

xi_url = "http://www.w3.org/2001/XInclude"

xi_include = "{{{}}}include".format(xi_url)

ET.register_namespace('xi', xi_url)


def make_relhref(outfile, href):
    outpath = os.path.dirname(os.path.abspath(outfile))
    relpath = os.path.relpath(os.path.dirname(os.path.abspath(href)), outpath)
    return os.path.join(relpath, os.path.basename(href))


def include_xml(parent, href, outfile, xptr=None):
    """
    Generate an XML include, using a relative path.

    Inputs
    ------
    parent : XML element to insert include into
    href : path to included file
    outfile : path to output file, for relative path generation
    xptr : optional value for xpointer attribute
    """
    xattrs = {'href': make_relhref(outfile, href)}
    if xptr is not None:
        xattrs["xpointer"] = xptr
    return ET.SubElement(parent, xi_include, xattrs)
