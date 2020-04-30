from enum import Enum
import json
import re

# =============================================================================


class State(Enum):
    """
    Parser state
    """
    IDLE = 0
    MODULE_KEYWORD = 1
    MODULE = 2

class AttributeExtractor():
    """
    This is a class that follows the Verilog parser and extracts attributes
    specified on module parameters.
    """

    RE_ATTR = re.compile(r"^(?P<name>\w+)(\s*=\s*(?P<value>\S+))?")
    RE_PARAM = re.compile(r"^parameter\s+(?P<name>\w+)\s*=\s*(?P<value>\S+)")

    def __init__(self):
        self.modules = {}

        self.state = State.IDLE

        self.module = None
        self.attributes = {}

    @staticmethod
    def unquote(s):
        """
        Removes quotes from a string
        """
        if s is None:
            return None
        if s.startswith("\"") and s.endswith("\""):
            return s[1:-1]
        return s

    def add_module(self, name):
        """
        Adds a new module
        """
        module = {
            "parameters": {}
        }

        self.modules[name] = module
        return module

    def finish(self):
        """
        Invoked on parser finish. Dumps all collected data to stdout in JSON
        format with prefix appended to each line.
        """
        for line in json.dumps(self.modules, indent=1).splitlines():
            print("V2X:", line)

    def clear_attributes(self):
        """
        Clears attribute "accumulator"
        """
        self.attributes = {}

    def enter_attribute(self, prog, ctx):
        """
        Called when an attribute specification is encountered"
        """

        # Parse the attribute, split name and value
        text = SLgetText(prog, ctx).strip()
        
        match = self.RE_ATTR.match(text)
        if match:
            name  = match.group("name")
            value = self.unquote(match.group("value"))
            self.attributes[name] = value

    def enter_parameter(self, prog, ctx):
        """
        Called when a parameter specification is encountered.
        """

        assert self.module

        # Parse the parameter, split name and value
        text = SLgetText(prog, ctx).strip()

        match = self.RE_PARAM.match(text)
        if match is not None:

            parameter = {
                "default": match.group("value"),
                "attributes": self.attributes
            }

            name = match.group("name")
            self.module["parameters"][name] = parameter

        # Clear attributes
        self.clear_attributes()

    def enter_module_keyword(self, prog, ctx):
        """
        Called on module keyword. Initiates looking for its name
        """
        self.state = State.MODULE_KEYWORD

    def exit_module(self, prog, ctx):
        """
        Called on module definition exit
        """
        self.clear_attributes()
        self.module = None
        self.state = State.IDLE

    def enter_identifier(self, prog, ctx):
        """
        Called on every identified. Captures a module name.
        """

        # Module definition
        if self.state == State.MODULE_KEYWORD:

            text = SLgetText(prog, ctx).strip()

            # Add new module
            self.module = self.add_module(text)
            self.module["attributes"] = self.attributes
            self.clear_attributes()

            self.state = State.MODULE


# Instantiate the attribute extractor
extractor = AttributeExtractor()

# =============================================================================

def enterAttr_spec(prog, ctx):
    extractor.enter_attribute(prog, ctx)

def enterParameter_declaration(prog, ctx):
    extractor.enter_parameter(prog, ctx)


def enterModule_keyword(prog, ctx):
    extractor.enter_module_keyword(prog, ctx)

def exitModule_declaration(prog, ctx):
    extractor.exit_module(prog, ctx)

def enterIdentifier(prog, ctx):
    extractor.enter_identifier(prog, ctx)


def exitTop_level_rule(prog, ctx):
    extractor.finish()

# =============================================================================

# TODO: Identify all hooks that are requiret to call clear_attributes() so
# no attributes "fall through" a statement.

def enterStatement_or_null(prog, ctx):
    extractor.clear_attributes();

def enterStatement(prog, ctx):
    extractor.clear_attributes();

def enterPort_declaration(prog, ctx):
    extractor.clear_attributes();

