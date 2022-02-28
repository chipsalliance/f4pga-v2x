Verilog to Routing XML file generation from Verilog (`f4pga-v2x`)
=================================================================


.. image:: https://readthedocs.org/projects/f4pga-v2x/badge/?version=latest
   :target: https://f4pga-v2x.readthedocs.io/en/latest/?badge=latest
   :alt: Documentation Status

v2x is a tool for converting specialized annotated Verilog models into XML needed for
`Verilog to Routing flow <https://docs.verilogtorouting.org/en/latest/arch/reference/>`_.

Documentation can be found at `https://f4pga-v2x.readthedocs.io/en/latest/ <https://f4pga-v2x.readthedocs.io/en/latest/>`_.

Installation
------------

v2x can be installed from a local git repository using pip.

.. code-block::

   cd f4pga-v2x
   pip install .

Alternatively, it can be installed from GitHub directly.

.. code-block::

   pip install git+https://github.com/chipsalliance/f4pga-v2x.git#egg=f4pga-v2x

Usage
-----

After installing v2x, you can run ``v2x`` to use it.

.. code-block::

   v2x -h
   usage: __main__.py [-h] [--top TOP] [--outfile OUTFILE] [--includes INCLUDES]
                      [--mode {pb_type,model}]
                      input.v [input.v ...]

   Verilog to XML

   positional arguments:
     input.v               One or more Verilog input files, that will be passed
                           to Yosys internally. They should be enough to generate
                           a flattened representation of the model, so that paths
                           through the model can be determined.

   optional arguments:
     -h, --help            show this help message and exit
     --top TOP             Top level module, will usually be automatically
                           determined from the file name im.v
     --outfile OUTFILE, -o OUTFILE
                           Output filename, default 'output.xml'
     --includes INCLUDES   Comma separate list of include directories.
     --mode {pb_type,model}
                           Output file type, possible values are: pb_type and
                           model. Default value is pb_type

For example, to generate a pb_type xml file from adder.v, run

.. code-block::

   v2x -o adder.pb_type.xml adder.v

Or, to generate a model xml file, run

.. code-block::

   v2x --mode model -o adder.model.xml adder.v

v2x expects the module name to be the same as the file name. If it is different, make sure to specifiy it with the ``--top`` argument.

.. code-block::

   v2x --top BLOCK -o adder.pb_type.xml adder.v

Tests
-----

The test cases are stored in tests/, and pytest can be used to run them.

.. code-block::

   rm -rf build  # run this step so that pytest uses the latest files for the tests
   pytest -vv

If you are making changes to any python code, make sure that they follow the PEP8 style guide by running flake8.

.. code-block::

   flake8 tests
   flake8 v2x

Documentation
-------------

We use sphinx for our documentation and the files are stored in docs/. To host it locally (if you are planning to update it), you can use the Makefile inside.

First, run ``make env`` to prepare a Conda environment that contains the necessary packages to build and host the documentation site. After that, simply run ``make livehtml`` which starts a local server running at port 8000 with the documentation site.

.. code-block::

   cd docs
   make env
   make livehtml

Talks
-----

**VPR device models generation from Verilog with V2X - Karol Gugala - ORConf 2019**


.. image:: https://img.youtube.com/vi/a31vH_tZLBM/0.jpg
   :target: https://www.youtube.com/watch?v=a31vH_tZLBM
   :alt: v2x orconf talk

