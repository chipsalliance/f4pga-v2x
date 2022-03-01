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

# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html


from pathlib import Path

from collect_examples import collect_examples
from pygments.lexers.hdl import VerilogLexer
from sphinx.highlighting import lexers
from re import sub as re_sub

from os import path as os_path, environ, popen
from sys import path as sys_path

sys_path.insert(0, os_path.abspath('.'))

from markdown_code_symlinks import LinkParser, MarkdownSymlinksDomain  # noqa


lexers['verilog'] = VerilogLexer(tabsize=2)

# -- General configuration ------------------------------------------------

project = u'F4PGA Verilog to XML (V2X)'
copyright = u'2018-2022, F4PGA Authors'
author = u'F4PGA Authors'

extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.autosummary',
    'sphinx.ext.doctest',
    'sphinx.ext.imgmath',
    'sphinx.ext.napoleon',
    'sphinx.ext.todo',
    'sphinx_markdown_tables',
    'sphinxcontrib_hdl_diagrams',
    'recommonmark'
]

hdl_diagram_yosys = "system"

templates_path = ['_templates']

source_suffix = ['.rst', '.md']
source_parsers = {
    '.md': 'markdown_code_symlinks.LinkParser',
}

master_doc = 'index'

on_rtd = environ.get('READTHEDOCS', None) == 'True'
if on_rtd:
    docs_dir = os_path.abspath(os_path.dirname(__file__))
    print("Docs dir is:", docs_dir)
    import subprocess
    subprocess.call('git fetch origin --unshallow', cwd=docs_dir, shell=True)
    subprocess.check_call('git fetch origin --tags', cwd=docs_dir, shell=True)

release = re_sub('^v', '', popen('git describe ').read().strip())
version = release

language = None

exclude_patterns = ['_build', 'env', 'Thumbs.db', '.DS_Store']

pygments_style = 'default'

todo_include_todos = True

# -- Options for HTML output ----------------------------------------------

# Enable github links when not on readthedocs
if not on_rtd:
    html_context = {
        "display_github": True,  # Integrate GitHub
        "github_user": "chipsalliance",  # Username
        "github_repo": "f4pga-v2x",  # Repo name
        "github_version": "master",  # Version
        "conf_py_path": "/doc/",
    }

html_theme = 'sphinx_symbiflow_theme'

html_theme_options = {
    'repo_name': 'chipsalliance/f4pga-v2x',
    'github_url' : 'https://github.com/chipsalliance/f4pga-v2x',
    'globaltoc_collapse': True,
    'color_primary': 'indigo',
    'color_accent': 'blue',
}

html_static_path = ['_static']

html_logo = str(Path(html_static_path[0]) / 'logo.svg')
html_favicon = str(Path(html_static_path[0]) / 'favicon.svg')

# -- Options for HTMLHelp output ------------------------------------------

htmlhelp_basename = 'f4pga-v2x'

# -- Options for LaTeX output ---------------------------------------------

latex_elements = {}

latex_documents = [
    (
        master_doc, 'F4PGAV2X.tex', u'F4PGA V2X Documentation',
        u'F4PGA Authors', 'manual'),
]

# -- Options for manual page output ---------------------------------------

man_pages = [
    (master_doc, 'f4pga-v2x', u'F4PGA V2X Documentation', [author], 1)
]

# -- Options for Texinfo output -------------------------------------------

texinfo_documents = [
    (
        master_doc, 'F4PGAV2X', u'F4PGA V2X Documentation', author,
        'F4PGAV2X', 'One line description of project.', 'Miscellaneous'),
]

intersphinx_mapping = {'https://docs.python.org/': None}

def setup(app):
    # Collect tests to form examples
    collect_examples()

    github_code_repo = 'https://github.com/chipsalliance/f4pga-v2x/'
    github_code_branch = 'blob/master/'

    docs_root_dir = os_path.realpath(os_path.dirname(__file__))
    code_root_dir = os_path.realpath(os_path.join(docs_root_dir, ".."))

    MarkdownSymlinksDomain.init_domain(
        github_code_repo, github_code_branch, docs_root_dir, code_root_dir)
    MarkdownSymlinksDomain.find_links()
    app.add_domain(MarkdownSymlinksDomain)
    app.add_config_value(
        'recommonmark_config', {
            'github_code_repo': github_code_repo,
        }, True)
