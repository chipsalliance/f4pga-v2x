An example and test how to specify fasm features for modules
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

A module can be assigned with a number of fasm features that are to be emitted if it is used. The list of those features is defined via FASM_FEATURES attribute of the module definition. The list contains a set of semicolon separated fasm feature names. It is an error to specify FASM_FEATURES on a cell instance.

When a module has multiple modes, then features from the FASM_FEATURE list will be appended to the pb_type containing the "mode" tag. Feature lists for particular modes may be specified through FASM_FEATURES_{mode} attribute. When such an attribute is provided, the feature list that it defines will be attached to the pb_type corresponding for that mode.
