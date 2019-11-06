#!/usr/bin/env python3

import pytest
from pathlib import Path
import os
from v2x import vlog_to_model
from v2x import vlog_to_pbtype


def get_filenames_containing(pattern, rootdir):
    return list(set([str(f) for f in
                     Path(os.path.dirname(__file__)).rglob(pattern)]))


def find_files(pattern, rootdir):
    return [str(f) for f in Path(os.path.abspath(rootdir)).glob(pattern)]


@pytest.mark.parametrize("testdatafile",
                         get_filenames_containing('*.model.xml', __file__))
def test_model_generation_with_vlog_to_model(testdatafile):
    """Parametrized test that checks  if the model.xml files produced by the
    vlog_to_model function are valid
    Parameters
    ----------
    testdatafile : str
        The filename of the model.xml file that should be produced by the
        corresponding sim.v file
    """
    testdatadir = os.path.dirname(testdatafile)
    vlog_filenames = find_files('*.sim.v', testdatadir)
    assert len(vlog_filenames) == 1
    vlog_filename = vlog_filenames[0]
    modelout = vlog_to_model.vlog_to_model([vlog_filename], None, None)
    assert modelout == open(testdatafile).read()

@pytest.mark.parametrize("testdatafile",
                         get_filenames_containing('*.pb_type.xml', __file__))
def test_pbtype_generation_with_vlog_to_pbtype(testdatafile):
    """Parametrized test that checks  if the pb_type.xml files produced by the
    vlog_to_pbtype function are valid
    Parameters
    ----------
    testdatafile : str
        The filename of the pb_type.xml file that should be produced by the
        corresponding sim.v file
    """
    testdatadir = os.path.dirname(testdatafile)
    vlog_filenames = find_files('*.sim.v', testdatadir)
    assert len(vlog_filenames) == 1
    vlog_filename = vlog_filenames[0]
    pbtypeout = vlog_to_pbtype.vlog_to_pbtype([vlog_filename],
                                              testdatadir + 'actual.xml',
                                              None)
    assert pbtypeout == open(testdatafile).read()
