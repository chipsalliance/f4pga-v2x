#!/usr/bin/env python3

import pytest
from pathlib import Path
import os
from functools import cmp_to_key

from v2x import vlog_to_model
from v2x import vlog_to_pbtype
from v2x.xmlinc import xmlinc
from v2x.mux_gen import mux_gen

from vtr_xml_utils import convert


@pytest.fixture(scope="session", autouse=True)
def prepare_files(request):
    mux_gen(outdir='tests/muxes/routing',
            outfilename='rmux',
            datatype='routing',
            width=2,
            split_inputs=True,
            name_output='O',
            name_mux='RMUX',
            name_inputs='I0,I1'
            )
    mux_gen(outdir='tests/vtr/lutff-pair/omux',
            outfilename='omux',
            datatype='routing',
            width=2,
            split_inputs=True,
            name_output='O',
            name_mux='omux',
            name_inputs='L,F'
            )
def order_based_on_deps(left, right):
    with open(left, 'r') as leftfile:
        relhref = xmlinc.make_relhref(left, right)
        leftcontent = leftfile.read()
        if relhref in leftcontent:
            return 1
    with open(right, 'r') as rightfile:
        relhref = xmlinc.make_relhref(right, left)
        rightcontent = rightfile.read()
        if relhref in rightcontent:
            return -1
    return 0


def find_files(pattern, rootdir):
    return [str(f) for f in Path(os.path.abspath(rootdir)).glob(pattern)]


def get_test_goldens(goldentype, testfile):
    simfiles = sorted(
        sorted(convert.get_filenames_containing('*.sim.v', testfile)),
        key=cmp_to_key(order_based_on_deps))
    for sim in simfiles:
        res = find_files('golden.' + goldentype, os.path.dirname(sim))
        if len(res) == 1:
            yield res[0]


@pytest.mark.parametrize("testdatafile",
                         get_test_goldens('model.xml', __file__))
def test_model_generation_with_vlog_to_model(testdatafile):
    """Parametrized test that checks  if the model.xml files produced by the
    vlog_to_model function are valid
    Parameters
    ----------
    testdatafile : str
        The filename of the model.xml file that should be produced by the
        corresponding sim.v file
    """
    testdatadir = os.path.dirname(testdatafile) + '/'
    vlog_filenames = find_files('*.sim.v', testdatadir)
    assert len(vlog_filenames) == 1
    vlog_filename = vlog_filenames[0]
    testname = vlog_filename.split('/')[-1].split('.')[0]
    generatedmodelfile = testdatadir + testname + '.model.xml'
    modelout = vlog_to_model.vlog_to_model([vlog_filename], None, None,
                                           generatedmodelfile)
    with open(generatedmodelfile, 'w') as model:
        model.write(modelout)

    convertedgolden = convert.vtr_stylize_xml(testdatafile)
    convertedmodel = convert.vtr_stylize_xml(generatedmodelfile)

    assert convertedmodel == convertedgolden

    with open(generatedmodelfile, 'w') as model:
        model.write(convertedmodel)


@pytest.mark.parametrize("testdatafile",
                         get_test_goldens('pb_type.xml', __file__))
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
    testname = vlog_filename.split('/')[-1].split('.')[0]
    generatedmodelfile = testdatadir + testname + '.pb_type.xml'
    pbtypeout = vlog_to_pbtype.vlog_to_pbtype([vlog_filename],
                                              generatedmodelfile,
                                              None)
    with open(generatedmodelfile, 'w') as model:
        model.write(pbtypeout)

    convertedgolden = convert.vtr_stylize_xml(testdatafile)
    convertedmodel = convert.vtr_stylize_xml(generatedmodelfile)

    assert convertedmodel == convertedgolden

    with open(generatedmodelfile, 'w') as model:
        model.write(convertedmodel)
