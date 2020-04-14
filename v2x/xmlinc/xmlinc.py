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
