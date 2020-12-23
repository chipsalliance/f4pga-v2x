import os
import lxml.etree as ET


class PbTypeNode:

    def __init__(self, name, href, base_path, level=0):
        self.name = name
        self.href = href
        self.base_path = base_path
        self.level = level
        self.children = set()
        self.paths = dict()

    def populate_children(self):

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
                new_pb_type = PbTypeNode(elem_name, elem_href, self.base_path, self.level + 1)
                new_pb_type.populate_children()
                self.children.add(new_pb_type)

    def print_tree(self):
        padding = ""
        for level in range(self.level):
            padding += "\t"

        print("{}{}. {} {}".format(padding, self.level, self.name, self.href))
        for child in self.children:
            child.print_tree()

    def find_paths_from_pin(self, pin_name, pattern):

        def connection(direct):
            input_port = direct.xpath("port[@type='input']")[0]
            output_port = direct.xpath("port[@type='output']")[0]

            input_name = input_port.attrib["name"]
            output_name = output_port.attrib["name"]

            input_cell_name = input_port.attrib.get("from", None)
            output_cell_name = output_port.attrib.get("from", None)

            return (input_cell_name, output_cell_name,  input_name, output_name)


        def recurse_search(xml, path):
            input_cell_name, output_cell_name, input_name, output_name = path[-1]

            next = None
            if output_cell_name == xml.attrib["name"]:
                next = xml.xpath("pb_type/interconnect/direct/port[@type='input' and @name='{}']".format(output_name))

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

            elem_set = set()

            paths = list()
            # Determine connection between
            for mode in root_pb_type_xml.xpath("mode"):
                path = list()

                first = mode.xpath("interconnect/direct/port[@name='{}' and not(@from)]".format(pin_name))
                assert len(first) == 1
                first = first[0].getparent()
                result = connection(first)
                path.append(result)

                recurse_search(mode, path)

                input_cell_name, output_cell_name, input_name, output_name = path[-1]
                last = mode.xpath("interconnect/direct/port[@name='{}' and @from='{}']".format(output_name, mode.attrib["name"]))

                if len(last) == 1:
                    last = last[0].getparent()
                    result = connection(last)
                    path.append(result)

                paths.append(path)

            self.paths[pattern] = paths

    def get_paths(self, pattern):
        paths = self.paths.get(pattern, [])

        return paths

    def add_pack_patterns(self, path, pattern):
        def create_port(xml, cell_name, pin_name, direction):
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

                port = pb_type_xml.xpath("//port[@type='{}' and @name='{}' and @from='{}']".format(direction, pin_name, cell_name))
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


