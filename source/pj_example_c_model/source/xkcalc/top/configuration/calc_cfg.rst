============ ================== ====== =========== ======== =============== =============== =========== =============== =========================================================================================
 domain       name               size   short key   type     minimum value   maximum value   precision   default value   description
============ ================== ====== =========== ======== =============== =============== =========== =============== =========================================================================================
 virtual      strFileCfg         /      c           /        /               /               /           /               full location of the configuration file
 virtual      help               /      /           /        /               /               /           /               to print help information
 virtual      show               /      /           /        /               /               /           /               to show configuration value
 virtual      dryRun             /      /           /        /               /               /           /               to check input without running
 changeable   idxFrame           1      /           int      /               /               /           /               index of the current frame
 changeable   idxUnitX           1      /           int      /               /               /           /               index of the current unit in 1st dimension
 changeable   idxUnitY           1      /           int      /               /               /           /               index of the current unit in 2nd dimension
 top          strFileInp         1      i           string   /               /               /           /               full location of the input file
 top          strFileOut         1      o           string   /               /               /           out.dat         full location of the output file
 top          strPrefixDump      1      /           string   /               /               /           /               dump prefix for debug data
 top          strPrefixLoad      1      /           string   /               /               /           /               load prefix for debug data
 top          numFrame           1      /           int      /               /               /           10              number of the frames to be processed
 top          sizFrameX          1      /           int      1               1024            /           256             size of frames in 1st dimension
 top          sizFrameY          1      /           int      1               1024            /           256             size of frames in 2nd dimension
 top          sizFrameZ          1      /           int      1               16              /           4               size of frames in 3rd dimension
 top          enmProc            1      /           int      0               1               /           0               enumerator for processing behavior (<value> 0: software 1: hardware)
 top          enmInfo            1      /           int      0               4               /           2               enumerator for information level (<value> 0: none 1: system 2: top 3: module 4: common)
 top          enmLoad            1      /           int      0               2               /           2               enumerator for load source (<value> 0: pipeline 1: file 2: random)
 top          datSeed            1      r           int      /               /               /           0               value of random seed
 top          sizUnitX           1      /           int      1               32              /           32              size of units' 1st dimension
 top          sizUnitY           1      /           int      1               32              /           32              size of units' 2nd dimension
 top          sizUnitZ           1      /           int      1               16              /           4               size of units' 3rd dimension
 adder        addFlgProc         1      /           bool     /               /               /           1               enable flag for processing
 adder        addFlgSaturation   1      /           bool     /               /               /           0               enable flag for saturation
 adder        addEnmLoad         1      /           int      0               2               /           0               enumerator for load source (<value> 0: pipeline 1: file 2: random)
 adder        addEnmDump         1      /           int      0               2               /           0               enumerator for data dump (<value> 0: none 1: inout 2: intermediate)
 substrator   subFlgProc         1      /           bool     /               /               /           1               enable flag for processing
 substrator   subFlgSaturation   1      /           bool     /               /               /           0               enable flag for saturation
 substrator   subEnmLoad         1      /           int      0               2               /           0               enumerator for load source (<value> 0: pipeline 1: file 2: random)
 substrator   subEnmDump         1      /           int      0               2               /           0               enumerator for data dump (<value> 0: none 1: inout 2: intermediate)
 multiplier   mulFlgProc         1      /           bool     /               /               /           1               enable flag for processing
 multiplier   mulFlgSaturation   1      /           bool     /               /               /           0               enable flag for saturation
 multiplier   mulEnmLoad         1      /           int      0               2               /           0               enumerator for load source (<value> 0: pipeline 1: file 2: random)
 multiplier   mulEnmDump         1      /           int      0               2               /           0               enumerator for data dump (<value> 0: none 1: inout 2: intermediate)
 divider      divFlgProc         1      /           bool     /               /               /           1               enable flag for processing
 divider      divFlgSaturation   1      /           bool     /               /               /           0               enable flag for saturation
 divider      divEnmLoad         1      /           int      0               2               /           0               enumerator for load source (<value> 0: pipeline 1: file 2: random)
 divider      divEnmDump         1      /           int      0               2               /           0               enumerator for data dump (<value> 0: none 1: inout 2: intermediate)
 example      exampleDatInt      1      /           int      0               1               /           0               an example for int (scalar)
 example      exampleDatDouble   1      /           double   0               0.875           8           0               an example for double (scalar)
 example      exampleDatVector   2      /           int      0               1               /           0 0             an example for (int) vector
 example      exampleDatArray    2x3    /           int      0               1               /           0 0 0 0 0 0     an example for (int) array
 derived      numUnitX           1      /           int      /               /               /           /               number of units in 1st dimension
 derived      numUnitY           1      /           int      /               /               /           /               number of units in 2nd dimension
============ ================== ====== =========== ======== =============== =============== =========== =============== =========================================================================================
