import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="v2x",
    version="0.0.1",
    author="SymbiFlow Authors",
    author_email="symbiflow@lists.librecores.org",
    description="Python library for generating VPR architecture \
                description files from Verilog models.",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/SymbiFlow/python-symbiflow-v2x",
    packages=setuptools.find_packages(),
    install_requires=['lxml', 'pyjson'],
    setup_requires=["pytest-runner"],
    tests_require=["pytest"],
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: ISC License",
        "Operating System :: OS Independent",
    ],
    #entry_points={
    #    'console_scripts': ['sdf_timing_parse=sdf_timing.sdfparse:main'],
    #},
)
