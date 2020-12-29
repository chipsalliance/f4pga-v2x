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

import os
import lxml.etree as ET


class PbTypeNode:
    """
    This is a utility class to manage pre-generated pb_types XMLs

    Its current functionalities are:
        - discover all the pb type hierarchy starting from the initial
          pb_type.
        - discover direct connection paths to add pack patterns at posteriori
    """

    def __init__(self, name, href, base_path, level=0):
        self.name = name
        self.href = href
        self.base_path = base_path
        self.level = level
        self.children = set()
        self.paths = dict()

    def populate_children(self):
        """
        This function is used to discover all the children iteratively until
        the leaf pb_types.
        """

        with open(os.path.join(self.base_path, self.href), 'r') as href_file:
            href_xml = ET.fromstring(href_file.read().encode('utf-8'))

            elem_set = set()
            for elem in href_xml.iter():
                if "xpointer" in elem.attrib:
                    elem_href = elem.attrib["href"]
                    elem_name = elem_href.split("/")[-1]
                    elem_name = elem_name.split(".")[0]
                    elem_set.add((elem_name, elem_href))

            if len(elem_set) == 0:
                return

            for elem_name, elem_href in elem_set:
                new_pb_type = PbTypeNode(
                    elem_name,
                    elem_href,
                    self.base_path,
                    self.level + 1
                )
                new_pb_type.populate_children()
                self.children.add(new_pb_type)

    def print_tree(self):
        """
        This is a utility function to print all the pb_type hierarchy.
        """
        padding = ""
        for level in range(self.level):
            padding += "\t"

        print("{}{}. {} {}".format(padding, self.level, self.name, self.href))
        for child in self.children:
            child.print_tree()

    def find_paths_from_pin(self, pin_name, pattern):
        """
        This function is used to discover the paths from a given pb_type
        pin to be able to add a pack pattern to all the direct interconnects
        in the path.

        The path is saved under a `pattern` key, which identifies the pack
        pattern to add to that path.
        """

        def connection(direct):
            """
            This function returns the port connections of a direct XML
            instance.
            """
            in_port = direct.xpath("port[@type='input']")[0]
            out_port = direct.xpath("port[@type='output']")[0]

            in_name = in_port.attrib["name"]
            out_name = out_port.attrib["name"]

            in_cell_name = in_port.attrib.get("from", None)
            out_cell_name = out_port.attrib.get("from", None)

            return (in_cell_name, out_cell_name, in_name, out_name)

        def recurse_search(xml, path):
            """
            This function recursively iterates to find the path from
            the first top-level direct.
            """
            in_cell_name, out_cell_name, in_name, out_name = path[-1]

            next = None
            if out_cell_name == xml.attrib["name"]:
                xml_path = "pb_type/interconnect/direct/port"
                next = xml.xpath(
                    "{}[@type='input' and @name='{}']"
                    .format(xml_path, out_name)
                )

            if not next:
                return

            assert len(next) <= 1
            next = next[0].getparent()

            result = connection(next)

            path.append(result)

            recurse_search(xml, path)

        with open(os.path.join(self.base_path, self.href), 'r') as href_file:
            root_pb_type_xml = ET.fromstring(href_file.read().encode('utf-8'))

            if root_pb_type_xml is None:
                return

            paths = list()
            # Determine connection between
            for mode in root_pb_type_xml.xpath("mode"):
                path = list()

                xml_path = "interconnect/direct/port"
                first = mode.xpath(
                    "{}[@name='{}' and not(@from)]".format(xml_path, pin_name)
                )
                assert len(first) == 1
                first = first[0].getparent()
                result = connection(first)
                path.append(result)

                recurse_search(mode, path)

                in_cell_name, out_cell_name, in_name, out_name = path[-1]
                last = mode.xpath(
                    "{}[@name='{}' and @from='{}']"
                    .format(xml_path, out_name, mode.attrib["name"])
                )

                if len(last) == 1:
                    last = last[0].getparent()
                    result = connection(last)
                    path.append(result)

                paths.append(path)

            self.paths[pattern] = paths

    def get_paths(self, pattern):
        """
        This function returns the paths for a given pack pattern.
        """
        paths = self.paths.get(pattern, [])

        return paths

    def has_paths(self, pattern):
        """
        This function returns a boolean depending whether, for
        a given pack pattern, there are paths available.
        """
        paths = self.paths.get(pattern, [])

        return True if paths else False

    def add_pack_patterns(self, path, pattern):
        """
        This function adds the pack patterns to all the directs
        in a given path.
        """

        def create_port(xml, cell_name, pin_name, direction):
            """
            This function generates a port XML tag for the
            pack pattern tag.
            """
            port = dict()
            if cell_name:
                port['from'] = cell_name
            port['name'] = pin_name
            port['type'] = direction
            ET.SubElement(xml, 'port', port)

        with open(os.path.join(self.base_path, self.href), 'r') as href_file:
            directs = list()

            pb_type_xml = ET.fromstring(href_file.read().encode('utf-8'))
            for direct in path:
                in_cell, out_cell, in_pin, out_pin = direct

                if in_cell:
                    pin_name = in_pin
                    cell_name = in_cell
                    direction = 'input'
                elif out_cell:
                    pin_name = out_pin
                    cell_name = out_cell
                    direction = 'output'
                else:
                    assert False

                port = pb_type_xml.xpath(
                    "//port[@type='{}' and @name='{}' and @from='{}']"
                    .format(direction, pin_name, cell_name)
                )
                port = port[0]
                direct_xml = port.getparent()

                if direct_xml in directs:
                    continue
                else:
                    directs.append(direct_xml)

                pp_xml = ET.SubElement(
                    direct_xml, 'pack_pattern', {
                        'name': pattern,
                        'type': 'pack'
                    }
                )
                create_port(pp_xml, in_cell, in_pin, "input")
                create_port(pp_xml, out_cell, out_pin, "output")

            pb_type_xml_string = ET.tostring(
                pb_type_xml,
                pretty_print=True,
                encoding="utf-8",
                xml_declaration=True
            ).decode('utf-8')

        with open(os.path.join(self.base_path, self.href), 'w') as href_file:
            href_file.write(pb_type_xml_string)

    def create_pack_patterns(self, other_pb_type_node, pattern):
        """
        This function iterates through all the paths of the current
        pb_type and the adjacent pb_type passed as argument.

        Given that a pack pattern may traverse two siblings,
        we need to assign the same pack pattern to both of them.

        With this function, each possible path combination is
        generated for two siblings and the pack patterns added
        to both of the pre-generated pb_type XMLs
        """

        assert self.has_paths() and other_pb_type_node.has_paths()

        this_paths = self.paths[pattern]
        other_paths = other_pb_type_node.get_paths(pattern)

        pack_patterns = set()

        for this_idx, this_path in enumerate(this_paths):
            for other_idx, other_path in enumerate(other_paths):
                pack_pattern = "{}-{}-{}".format(pattern, this_idx, other_idx)

                self.add_pack_patterns(this_path, pack_pattern)
                other_pb_type_node.add_pack_patterns(other_path, pack_pattern)

                pack_patterns.add(pack_pattern)

        return pack_patterns
