#!/usr/bin/env python3

from pathlib import Path
import os
from functools import cmp_to_key

from v2x import vlog_to_model
from v2x import vlog_to_pbtype
from v2x.xmlinc import xmlinc
from v2x.mux_gen import mux_gen

from vtr_xml_utils import convert

from distutils.dir_util import copy_tree

TEST_TMP_SUFFIX = 'build/'


def prepare_files():
    # Copy all files for tests to the build/ directory
    scriptdir = os.path.dirname(__file__)
    testdir = os.path.join(os.path.dirname(scriptdir), TEST_TMP_SUFFIX)
    os.makedirs(testdir, exist_ok=True)

    for tdir in os.listdir(scriptdir):
        s = os.path.join(scriptdir, tdir)
        d = os.path.join(testdir, tdir)
        if os.path.isdir(s):
            copy_tree(s, d, update=1)

    # Generate muxes/routing for tests/muxes model
    mux_gen(outdir=os.path.join(testdir, 'muxes/routing'),
            outfilename='rmux',
            datatype='routing',
            width=2,
            split_inputs=True,
            name_output='O',
            name_mux='RMUX',
            name_inputs='I0,I1'
            )
    # Generate tests/vtr/lutff-pair/omux for tests/vtr/lutff-pair
    mux_gen(outdir=os.path.join(testdir, 'vtr/lutff-pair/omux'),
            outfilename='omux',
            datatype='routing',
            width=2,
            split_inputs=True,
            name_output='O',
            name_mux='omux',
            name_inputs='L,F'
            )

    # Generate dff.pb_type.xml required by various tests
    newpbfile = os.path.join(testdir, 'vtr/dff/dff.pb_type.xml')
    pbtypeout = vlog_to_pbtype.vlog_to_pbtype(
        [os.path.join(testdir, 'vtr/dff/dff.sim.v')],
        newpbfile,
        None)
    with open(newpbfile, 'w') as model:
        model.write(pbtypeout)

    # Generate ff.pb_type.xml required by various tests
    newpbfile = os.path.join(testdir, 'vtr/lutff-pair/ff/ff.pb_type.xml')
    pbtypeout = vlog_to_pbtype.vlog_to_pbtype(
        [os.path.join(testdir, 'vtr/lutff-pair/ff/ff.sim.v')],
        newpbfile,
        'DFF')
    with open(newpbfile, 'w') as model:
        model.write(pbtypeout)


def order_based_on_deps(left, right):
    # TODO: this is overly simplified sorting over files with dependencies
    # normally it should be solved with use of topological sort
    with open(left, 'r') as leftfile:
        relhref = xmlinc.make_relhref(left, right)
        leftcontent = leftfile.read()
        if relhref in leftcontent:
            return 1
        leftinccount = leftcontent.count('`include')
    with open(right, 'r') as rightfile:
        relhref = xmlinc.make_relhref(right, left)
        rightcontent = rightfile.read()
        if relhref in rightcontent:
            return -1
        rightinccount = rightcontent.count('`include')
    return leftinccount - rightinccount


def find_files(pattern, rootdir):
    return [str(f) for f in Path(os.path.abspath(rootdir)).glob(pattern)]


def get_test_goldens(goldentype, testfile):
    simfiles = sorted(
        sorted(convert.get_filenames_containing('*.sim.v', testfile)),
        key=cmp_to_key(order_based_on_deps))
    goldens = []
    for sim in simfiles:
        res = find_files('golden.' + goldentype, os.path.dirname(sim))
        if len(res) == 1:
            goldens.append({
                'simfile': sim,
                'goldenfile': res[0]})
    return goldens


def pytest_generate_tests(metafunc):
    prepare_files()
    scriptdir = os.path.dirname(__file__)
    testdir = os.path.join(os.path.dirname(scriptdir), TEST_TMP_SUFFIX)

    if "modelcase" in metafunc.fixturenames:
        models = get_test_goldens('model.xml', os.path.join(testdir, 'test'))
        metafunc.parametrize("modelcase",
                             models,
                             ids=[i['simfile'] for i in models])
    if "pbtypecase" in metafunc.fixturenames:
        models = get_test_goldens('pb_type.xml', os.path.join(testdir, 'test'))
        metafunc.parametrize("pbtypecase",
                             models,
                             ids=[i['simfile'] for i in models])


def test_model_generation_with_vlog_to_model(modelcase):
    """Parametrized test that checks  if the model.xml files produced by the
    vlog_to_model function are valid
    Parameters
    ----------
    modelcase : dict
        A dict of the filename of the model.xml file that should be produced
        by the corresponding sim.v file ('goldenfile') and the corresponding
        sim.v file ('simfile')
    """
    modelfile = modelcase['goldenfile']
    testdatadir = os.path.dirname(modelfile) + '/'
    vlog_filename = modelcase['simfile']
    testname = vlog_filename.split('/')[-1].split('.')[0]
    generatedmodelfile = os.path.join(testdatadir, testname) + '.model.xml'
    modelout = vlog_to_model.vlog_to_model([vlog_filename], None, None,
                                           generatedmodelfile)
    with open(generatedmodelfile, 'w') as model:
        model.write(modelout)

    convertedgolden = convert.vtr_stylize_xml(modelfile)
    convertedmodel = convert.vtr_stylize_xml(generatedmodelfile)

    with open(generatedmodelfile + '.actual', 'w') as model:
        model.write(convertedmodel)

    assert convertedmodel == convertedgolden


def test_pbtype_generation_with_vlog_to_pbtype(pbtypecase):
    """Parametrized test that checks  if the pb_type.xml files produced by the
    vlog_to_pbtype function are valid
    Parameters
    ----------
    pbtypecase : dict
        A dict of the filename of the model.xml file that should be produced
        by the corresponding sim.v file ('goldenfile') and the corresponding
        sim.v file ('simfile')
    """
    testdatafile = pbtypecase['goldenfile']
    testdatadir = os.path.dirname(testdatafile) + '/'
    vlog_filename = pbtypecase['simfile']
    testname = vlog_filename.split('/')[-1].split('.')[0]
    generatedmodelfile = os.path.join(testdatadir, testname) + '.pb_type.xml'
    pbtypeout = vlog_to_pbtype.vlog_to_pbtype([vlog_filename],
                                              generatedmodelfile,
                                              None)
    with open(generatedmodelfile, 'w') as model:
        model.write(pbtypeout)

    convertedgolden = convert.vtr_stylize_xml(testdatafile)
    convertedmodel = convert.vtr_stylize_xml(generatedmodelfile)

    with open(generatedmodelfile + '.actual', 'w') as model:
        model.write(convertedmodel)

    assert convertedmodel == convertedgolden
